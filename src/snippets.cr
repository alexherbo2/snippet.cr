require "json"

# Structs ──────────────────────────────────────────────────────────────────────

# Snippet
record(Snippet, scope : String, name : String, content : String) do
  include JSON::Serializable
end

# Access a snippet by its name.
# snippets[name] ⇒ snippet
alias HashSnippets = Hash(String, Snippet)

# Access snippets by their scope name.
# snippets[scope][name] ⇒ snippet
alias HashScopes = Hash(String, HashSnippets)

class Snippets

  property data_path
  property build_paths

  # Converts string paths
  def build_paths=(paths : Array(String))
    paths = paths.map do |path|
      Path[path]
    end

    @build_paths = paths
  end

  # Initialize ─────────────────────────────────────────────────────────────────

  def initialize(data @data_path : Path, build @build_paths : Array(Path))
    if File.exists?(@data_path)
      @snippets = HashScopes.from_json(File.open(@data_path))
    else
      @snippets = HashScopes.new
    end
  end

  def self.new(data data_path : String, build build_paths : Array(String))
    data_path = Path[data_path]
    build_paths = build_paths.map do |path|
      Path[path]
    end

    new(data_path, build_paths)
  end

  # All ────────────────────────────────────────────────────────────────────────

  def all
    @snippets
  end

  # Get ────────────────────────────────────────────────────────────────────────

  def get
    all
  end

  def get(scope_name : String)
    @snippets.fetch(scope_name, HashSnippets.new)
  end

  def get(scope_names : Array(String))
    scope_names.each_with_object(HashSnippets.new) do |scope_name, scoped_snippets|
      scoped_snippets.merge!(get(scope_name))
    end
  end

  def get(scope_name : String, snippet_name)
    @snippets.dig?(scope_name, snippet_name)
  end

  def get(scope_names : Array(String), snippet_name)
    scope_names.each

    .map do |scope_name|
      get(scope_name, snippet_name)
    end

    .find(&.itself)
  end

  # Build ──────────────────────────────────────────────────────────────────────

  def build
    @snippets = self.class.build(@build_paths)

    File.write(@data_path, @snippets.to_json)

    @snippets
  end

  # Static build methods
  def self.build(path : Path)
    # Declare snippets
    # Allow directly: snippets[scope][name] = snippet
    snippets = HashScopes.new do |snippets, scope|
      snippets[scope] = HashSnippets.new
    end

    return HashScopes.new unless Dir.exists?(path)

    # Save root
    root = path
    walk(path) do |path, directories, files|
      files.each do |file|
        scope = path.relative_to(root).to_s
        name = file.basename
        content = File.read(file).chomp

        snippets[scope][name] = Snippet.new(scope, name, content)
      end
    end

    return snippets
  end

  def self.build(path : String)
    build(Path[path])
  end

  def self.build(paths : Array(Path | String))
    # Declare snippets
    snippets = HashScopes.new

    # Build snippets
    paths.each do |path|
      snippets.merge!(build(path))
    end

    # Return snippets
    snippets
  end

  # Watch ──────────────────────────────────────────────────────────────────────

  def watch(&block)
    self.class.watch(@build_paths) do
      build

      # Yield
      block.call if block
    end
  end

  def self.watch(directories : Array(String), &block)
    directories = directories.map do |directory|
      Path[directory]
    end

    watch(directories, &block)
  end

  def self.watch(directories : Array(Path))
    directories = directories.map(&.to_s)

    loop do
      status = Process.run("inotifywait", ["--recursive", "--event", "close_write"] + directories)

      break unless status.exit_code.zero?

      # Yield
      yield
    end
  end

  # Walk ───────────────────────────────────────────────────────────────────────

  def self.walk(path, &block : Path, Array(Path), Array(Path) ->)
    # Path entries
    paths = Dir.children(path).map do |child|
      path / child
    end

    # Partition directories and files
    directories, files = paths.partition do |path|
      Dir.exists?(path)
    end

    # Yield
    yield(path, directories, files)

    # Recursion
    directories.each do |directory|
      walk(directory, &block)
    end
  end
end

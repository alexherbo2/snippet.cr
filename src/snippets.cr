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

  # Input and output paths
  property input_paths
  property output_path

  # Converts string paths
  def input_paths=(paths : Array(String))
    @input_paths = self.class.pathify(paths)
  end

  # Initialize ─────────────────────────────────────────────────────────────────

  def initialize(input @input_paths : Array(Path), output @output_path : Path)
    if File.exists?(@output_path)
      @snippets = HashScopes.from_json(File.open(@output_path))
    else
      @snippets = HashScopes.new
    end
  end

  def self.new(input input_paths : Array(String), output output_path : String)
    new(pathify(input_paths), pathify(output_path))
  end

  # All ────────────────────────────────────────────────────────────────────────

  def all
    @snippets
  end

  # Get ────────────────────────────────────────────────────────────────────────

  # All
  def get
    all
  end

  # Scope
  # Example: snippets.get("crystal")
  def get(scope_name : String)
    @snippets.fetch(scope_name, HashSnippets.new)
  end

  # Example: snippets.get(["crystal", "crystal/spec"])
  def get(scope_names : Array(String))
    scope_names.each_with_object(HashSnippets.new) do |scope_name, scoped_snippets|
      scoped_snippets.merge!(get(scope_name))
    end
  end

  # Dig into the snippets
  # Example: snippets.get("crystal", "def")
  def get(scope_name : String, snippet_name)
    @snippets.dig?(scope_name, snippet_name)
  end

  # Example: snippets.get(["crystal", "crystal/spec"], "it")
  def get(scope_names : Array(String), snippet_name)
    scope_names.each

    .map do |scope_name|
      get(scope_name, snippet_name)
    end

    .find(&.itself)
  end

  # Build ──────────────────────────────────────────────────────────────────────

  def build
    @snippets = self.class.build(@input_paths)

    File.write(@output_path, @snippets.to_json)

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
    build(pathify(path))
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
    self.class.watch(@input_paths) do
      build

      # Yield
      block.call if block
    end
  end

  def self.watch(directories : Array(String), &block)
    watch(pathify(directories), &block)
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

  # Pathify ────────────────────────────────────────────────────────────────────

  def self.pathify(path : String)
    Path[path]
  end

  def self.pathify(paths : Array(String))
    paths.map do |path|
      pathify(path)
    end
  end
end

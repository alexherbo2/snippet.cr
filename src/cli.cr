require "option_parser"
require "./snippets"
require "./env"

# Snippets location
SNIPPETS_DATA_PATH = Path[ENV["XDG_CACHE_HOME"], "snippets.json"]
SNIPPETS_CONFIG_PATH = Path[ENV["XDG_CONFIG_HOME"], "snippets"]
SNIPPETS_BUILD_PATHS = Dir.children(SNIPPETS_CONFIG_PATH).map do |child|
  SNIPPETS_CONFIG_PATH / child
end

# Subcommand
command = :help

# Options
watch = false

# Option parser
option_parser = OptionParser.new do |parser|
  parser.banner = "Usage: snippets <command> [arguments]"

  parser.on("build", "Build snippets") do
    command = :build

    parser.on("--watch", "Watch specified directories") do
      watch = true
    end
  end

  parser.on("get", "Get a property") do
    command = :get

    parser.on("path", "Get path") do
      command = :get_path

      parser.on("data", "Get data path") do
        command = :get_data_path
      end

      parser.on("build", "Get build paths") do
        command = :get_build_paths
      end
    end

    parser.on("all", "Get all snippets") do
      command = :get_all
    end

    parser.on("snippets", "Get snippets") do
      command = :get_snippets
    end

    parser.on("snippet", "Get a snippet") do
      command = :get_snippet
    end
  end

  parser.on("help", "Show help") do
    command = :help
  end

  parser.invalid_option do |flag|
    STDERR.puts "Error: Unknown option: #{flag}"
    STDERR.puts parser
    exit(1)
  end
end

# Parse options
option_parser.parse(ARGV)

# Initialization
snippets = Snippets.new(
  data: SNIPPETS_DATA_PATH,
  build: SNIPPETS_BUILD_PATHS
)

# Commands ─────────────────────────────────────────────────────────────────────

case command

# Build ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

when :build
  # Build paths
  snippets.build_paths = ARGV unless ARGV.empty?

  puts snippets.build.to_json

  if watch
    snippets.watch do
      puts snippets.all.to_json
    end
  end

# Get ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

when :get
  puts option_parser.parse(["get", "--help"])

when :get_path
  puts option_parser.parse(["get", "path", "--help"])

when :get_data_path
  puts snippets.data_path.to_json

when :get_build_paths
  puts snippets.build_paths.to_json

when :get_all
  puts snippets.all.to_json

when :get_snippets
  scope = ARGV

  puts snippets.get(scope).to_json

when :get_snippet
  name = ARGV.pop
  scope = ARGV

  puts snippets.get(scope, name).to_json

# Help ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

when :help
  puts option_parser

# Error ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

else
  STDERR.puts option_parser
  exit(1)
end

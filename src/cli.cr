require "option_parser"
require "./snippets"
require "./env"

# Snippets location
SNIPPETS_PATH = Path[ENV["XDG_CACHE_HOME"], "snippets.json"]

# Subcommand
command = :help

# Option parser
option_parser = OptionParser.new do |parser|
  parser.banner = "Usage: snippets <command> [arguments]"

  parser.on("build", "Build snippets") do
    command = :build
  end

  parser.on("get", "Get a property") do
    command = :get

    parser.on("path", "Get path") do
      command = :get_path
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
snippets = Snippets.new(SNIPPETS_PATH)

# Commands ─────────────────────────────────────────────────────────────────────

case command

# Build ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

when :build
  paths = ARGV
  snippets.build(paths).to_json

# Get ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

when :get
  puts option_parser.parse(["get", "--help"])

when :get_path
  puts snippets.path

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

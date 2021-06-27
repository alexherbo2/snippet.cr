require "option_parser"
require "json"
require "./main"
require "./env"

DATA_PATH = Path[ENV["XDG_DATA_HOME"], "scr"]
SNIPPETS_PATH = DATA_PATH / "snippets"

module Snippet::CLI
  extend self

  struct Options
    property command : Symbol?
    property path : Path?
    property stdin = false
  end

  def start(argv)
    # Options
    options = Options.new

    # Option parser
    option_parser = OptionParser.new do |parser|
      parser.banner = "Usage: scr <command> [arguments]"

      parser.on("-v", "--version", "Display version") do
        puts VERSION
        exit
      end

      parser.on("-h", "--help", "Show help") do
        puts parser
        exit
      end

      parser.on("--", "Stop handling options") do
        parser.stop
      end

      parser.on("-", "Stop handling options and read stdin") do
        parser.stop
        options.stdin = true
      end

      parser.on("select", "Select snippets") do
        options.command = :select

        parser.on("-P PATH", "--path=PATH", "File path") do |path|
          options.path = Path[path]
        end
      end

      parser.on("help", "Show help") do
        options.command = :help
      end

      parser.on("version", "Display version") do
        options.command = :version
      end

      parser.invalid_option do |flag|
        STDERR.puts "Error: Unknown option: #{flag}"
        STDERR.puts parser
        exit(1)
      end
    end

    # Parse options
    option_parser.parse(argv)

    # Run command
    case options.command

    when :select
      snippets = Directory.read(SNIPPETS_PATH).select(options.path.as(Path))

      puts snippets.to_json

    when :help
      option_parser.parse(argv + ["--help"])

    when :version
      puts VERSION
      exit

    else
      STDERR.puts "No such command: #{options.command}"
      exit(1)

    end
  end
end

Snippet::CLI.start(ARGV)

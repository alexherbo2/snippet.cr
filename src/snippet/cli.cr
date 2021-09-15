require "option_parser"
require "json"
require "file_utils"

module Snippet::CLI
  extend self

  CONFIG_PATH = Path[ENV["SCR_CONFIG"]]
  RUNTIME_PATH = Path[ENV["SCR_RUNTIME"]]

  struct Options
    property command : Symbol?
    property path : Path?
    property? stdin = false
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

      parser.on("install", "Install files") do
        options.command = :install

        parser.banner = "Usage: scr install <name>"

        parser.on("snippets", "Install snippets") do
          options.command = :install_snippets
        end
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
        abort "Error: Unknown option: #{flag}"
      end
    end

    # Parse options
    option_parser.parse(argv)

    # Run command
    case options.command

    when :install
      option_parser.parse(["install", "--help"])

    when :install_snippets
      install_snippets

    when :select
      snippets = Directory.read(CONFIG_PATH / "snippets").select(options.path.as(Path))

      puts snippets.to_json

    when :help
      option_parser.parse(argv + ["--help"])

    when :version
      puts VERSION
      exit

    else
      abort "No such command: #{options.command}"

    end
  end

  def install_snippets
    install_path = CONFIG_PATH / "snippets" / "support"

    { RUNTIME_PATH.join("snippets").to_s, install_path.to_s, install_path.dirname }.tap do |source, destination, directory|
      return if Dir.exists?(destination)

      Dir.mkdir_p(directory)
      FileUtils.cp_r(source, destination)
      puts "Copied #{source} to #{destination}"
    end
  end

end

require "./env"
require "./snippet"
require "./snippet/cli"

Snippet::CLI.start(ARGV)

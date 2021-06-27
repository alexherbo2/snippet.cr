# Creates a new `Snippet` instance from file.
#
# Example:
#
# Snippet::File::Snippet.read("crystal/def")
#
# ------------------------------------------------------------------------------
#
# Crystal define methods – [crystal/def]:
#
# def {{name}}
# 	{{content}}
# end
#
# ------------------------------------------------------------------------------
module Snippet::FileSnippet
  extend self

  def read(path : Path)
    name = path.basename
    content = File.read(path).chomp

    Snippet.new(name, content)
  end

  def read(path : String)
    read(Path[path])
  end
end

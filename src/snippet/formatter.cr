struct Snippet::Formatter
  # Properties
  property prefix = ""
  property? tab = false
  property indent = 2

  def initialize(@prefix = prefix, @tab = tab?, @indent = indent)
  end

  def format(input : IO, output : IO)
    input.each_line(chomp: false) do |line|
      output << prefix + line.gsub('\t', indent_replacement)
    end
  end

  def format(string : String)
    input = IO::Memory.new(string)
    output = IO::Memory.new
    format(input, output)
    output.to_s
  end

  private def indent_replacement
    if tab?
      '\t'
    else
      " " * indent
    end
  end
end

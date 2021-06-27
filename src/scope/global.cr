class Snippet::ScopeGlobal < Snippet::Scope
  # Properties
  property enabled : Bool

  # Creates a new instance.
  def initialize(@enabled)
  end

  # Evaluates the scope of a snippet.
  def call(path : Path)
    @enabled
  end
end

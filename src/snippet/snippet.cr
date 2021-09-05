require "json"

struct Snippet::Snippet
  include JSON::Serializable

  # Properties
  property name : String
  property content : String

  # Creates a new instance.
  def initialize(@name, @content)
  end
end

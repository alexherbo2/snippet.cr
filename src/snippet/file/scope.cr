require "yaml"

# Examples
#
# ------------------------------------------------------------------------------
#
# Crystal – [crystal/scope.yml]:
#
# extensions: [".cr"]
#
# ------------------------------------------------------------------------------
#
# Crystal specs – [crystal/spec/scope.yml]:
#
# paths: ["**/spec/*_spec.cr"]
#
# ------------------------------------------------------------------------------
module Snippet::FileScope
  extend self

  def read(path : Path)
    Hash(String, Bool | Array(String)).from_yaml(File.open(path)).map do |key, value|
      case key
      when "global"
        ScopeGlobal.new(value.as(Bool))
      when "roots"
        ScopeRoot.new(value.as(Array(String)))
      when "paths"
        ScopePath.new(value.as(Array(String)))
      when "extensions"
        ScopeExtension.new(value.as(Array(String)))
      else
        raise "Invalid scope: #{key}"
      end
    end
  end

  def read(path : String)
    read(Path[path])
  end
end

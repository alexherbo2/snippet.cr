module Snippet
  macro version
    {{ `git describe --tags --always`.chomp.stringify }}
  end
  VERSION = version
end

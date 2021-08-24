ENV["XDG_CONFIG_HOME"] ||= Path["~/.config"].expand(home: true).to_s
ENV["XDG_DATA_HOME"] ||= Path["~/.local/share"].expand(home: true).to_s

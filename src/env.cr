ENV["XDG_CONFIG_HOME"] ||= Path["~/.config"].expand(home: true).to_s
ENV["XDG_CACHE_HOME"] ||= Path["~/.cache"].expand(home: true).to_s
ENV["EDITOR"] ||= "vi"

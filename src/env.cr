ENV["XDG_CONFIG_HOME"] ||= Path["~/.config"].expand(home: true).to_s
ENV["XDG_DATA_HOME"] ||= Path["~/.local/share"].expand(home: true).to_s
ENV["SCR_CONFIG"] ||= Path[ENV["XDG_CONFIG_HOME"], "scr"].to_s
ENV["SCR_RUNTIME"] ||= Path[Process.executable_path.as(String), "../../share/scr"].expand.to_s

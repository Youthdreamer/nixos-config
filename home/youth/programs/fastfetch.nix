{ config, lib, ... }:

{
  programs.fastfetch = {
    enable = true;
    
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        padding = {
          top = 1;
	};
      };

      display = {
        separator = " ";
      };
      
      modules = [
        {
          type = "title";
          key = "╭─";
          format = "{user-name}@{host-name}";
          keyColor = "blue";
        }
        {
          type = "os";
          key = "├─";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = "├─";
          keyColor = "blue";
        }
        {
          type = "packages";
          key = "├─󰏖";
          keyColor = "blue";
        }
        {
          type = "uptime";
          key = "├─󰅐";
          keyColor = "blue";
        }
        {
          type = "localip";
          key = "├─󰩟";
          compact = true;
          keyColor = "blue";
        }
        {
          type = "locale";
          key = "╰─";
          keyColor = "blue";
        }
        "break"

        {
          type = "shell";
          key = "╭─";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = "├─";
          keyColor = "yellow";
        }
        {
          type = "terminalfont";
          key = "├─";
          keyColor = "yellow";
        }
        {
          type = "lm";
          key = "├─󰧨";
          keyColor = "yellow";
        }
        {
          type = "de";
          key = "├─";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "╰─";
          keyColor = "yellow";
        }
        "break"

        {
          type = "host";
          key = "╭─󰌢";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "├─󰻠";
	  format= "{1} @{7}";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "├─󰍛";
	  format = "{1} {2} {3}";
          keyColor = "green";
        }
        {
          type = "disk";
          key = "├─";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "├─󰑭";
          keyColor = "green";
        }
        {
          type = "display";
          key = "├─󰍹";
	  format = "{1}x{2} @{3}Hz {6}";
          keyColor = "green";
        }
        {
          type = "sound";
          key = "╰─";
          keyColor = "green";
        }
	{
          type = "colors";
	  paddingLeft = 10;
	  symbol = "circle";
	}
      ];
    };
  };
}

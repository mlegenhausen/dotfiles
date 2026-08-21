{ lib, ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      subagent_depth = 2;

      agent = {
        plan = {
          model = "openai/gpt-5.6-sol-fast";
          variant = "high";
        };

        build = {
          model = "openai/gpt-5.6-luna-fast";
          variant = "xhigh";
        };

        general = {
          model = "openai/gpt-5.6-luna-fast";
          variant = "high";
          permission.task = {
            "*" = "deny";
            review = lib.hm.dag.entryAfter [ "*" ] "allow";
          };
        };

        explore = {
          model = "openai/gpt-5.6-sol-fast";
          variant = "medium";
          permission.task = {
            "*" = "deny";
            review = lib.hm.dag.entryAfter [ "*" ] "allow";
          };
        };
      };

      permission = {
        read = {
          "*.env" = "deny";
          "*.env.*" = "deny";
          "*.env.example" = lib.hm.dag.entryAfter [ "*.env" "*.env.*" ] "allow";
        };

        edit = {
          "*.env" = "deny";
          "*.env.*" = "deny";
          "*.env.example" = lib.hm.dag.entryAfter [ "*.env" "*.env.*" ] "allow";
        };

        external_directory = {
          "~/dev/**" = "allow";
        };
      };
    };

    context = ./opencode/AGENTS.md;

    agents.review = ./opencode/agents/review.md;

    web = {
      enable = true;
      environmentFile = "/Users/mlegenhausen/.config/opencode/web.env";
      extraArgs = [
        "--hostname"
        "0.0.0.0"
        "--port"
        "4096"
      ];
    };
  };
}

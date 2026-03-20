{ ... }:

{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    extraConfigLuaPre = ''
      --- Move to a window (one of hjkl) or create a split if a window does not exist in the direction.
      --- Lua translation of:
      --- https://www.reddit.com/r/vim/comments/166a3ij/comment/jyivcnl/?utm_source=share&utm_medium=web2x&context=3
      --- Usage: vim.keymap("n", "<C-h>", function() move_or_create_win("h") end, {})
      --
      ---@param key string One of h, j, k, l, a direction to move or create a split
      _G.smarter_win_nav = function(key)
        local fn = vim.fn
        local curr_win = fn.winnr()
        vim.cmd("wincmd " .. key)        --> attempt to move

        if (curr_win == fn.winnr()) then --> didn't move, so create a split
          if key == "h" or key == "l" then
            vim.cmd("wincmd v")
          else
            vim.cmd("wincmd s")
          end

          vim.cmd("wincmd " .. key)      --> move again
        end
      end
    '';

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<Space>";
        action = "<Nop>";
      }

      # Default overrides
      {
        mode = "n";
        key = "<ESC>";
        action = "<CMD>nohlsearch<CR>";
      }
      {
        mode = "t";
        key = "<ESC><ESC>";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }
      {
        mode = "n";
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = { expr = true; silent = true; };
      }
      {
        mode = "n";
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = { expr = true; silent = true; };
      }
      { mode = "n"; key = "n"; action = "nzz"; }
      { mode = "n"; key = "N"; action = "Nzz"; }

      # Custom keymaps
      {
        mode = "i";
        key = "jk";
        action = "<ESC>";
        options.desc = "Better ESC";
      }
      {
        mode = "i";
        key = "<C-s>";
        action = "<C-g>u<ESC>[s1z=`]a<C-g>u";
        options.desc = "Fix nearest [S]pelling error and put the cursor back";
      }

      # Emacs alerts
      { mode = "i"; key = "<C-a>"; action = "<C-o>^"; options.desc = "Emacs alert"; }
      { mode = "i"; key = "<C-b>"; action = "<LEFT>"; options.desc = "Sorry"; }
      { mode = "i"; key = "<C-f>"; action = "<RIGHT>"; options.desc = "Hey Emacs users use Evil all the time"; }

      # Copy and paste
      {
        mode = [ "n" "x" ];
        key = "<leader>a";
        action = "gg<S-v>G";
        options.desc = "Select [A]ll";
      }
      {
        mode = "x";
        key = "<leader>y";
        action = "\"+y";
        options.desc = "[Y]ank to the system clipboard (+)";
      }
      {
        mode = "x";
        key = "<leader>p";
        action = "\"_dP";
        options.desc = "[P]aste the current selection without overriding the register";
      }

      # Buffers
      {
        mode = "n";
        key = "[b";
        action = "<CMD>bprevious<CR>";
        options.desc = "Go to previous [B]uffer";
      }
      {
        mode = "n";
        key = "]b";
        action = "<CMD>bnext<CR>";
        options.desc = "Go to next [B]uffer";
      }

      # Smart Window Navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<CMD>lua _G.smarter_win_nav('h')<CR>";
        options.desc = "Move focus to the left window or create a vertical split";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<CMD>lua _G.smarter_win_nav('j')<CR>";
        options.desc = "Move focus to the lower window or create a horizontal split";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<CMD>lua _G.smarter_win_nav('k')<CR>";
        options.desc = "Move focus to the upper window or create a horizontal split";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<CMD>lua _G.smarter_win_nav('l')<CR>";
        options.desc = "Move focus to the right window or create a vertical split";
      }
    ];
  };
}

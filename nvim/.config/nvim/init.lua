-- 1. Self-Bootstrapping Python Provider
local provider_dir = vim.fn.expand("~/.local/share/nvim/python-provider")
local python_provider = provider_dir .. "/bin/python"

-- If the python binary doesn't exist, create the venv and install pynvim
if not vim.uv.fs_stat(python_provider) then
    vim.notify("Bootstrapping Neovim Python provider via uv...", vim.log.levels.INFO)
    vim.fn.system({ "uv", "venv", provider_dir })
    vim.fn.system({ "uv", "pip", "install", "--python", python_provider, "pynvim" })
end

-- Bind the isolated provider
vim.g.python3_host_prog = python_provider

-- Disable unused providers for faster startup
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

--[[ Migration commands from vimscript ]]
require("options")

--[[ Custom keymaps ]]
require("remap")

--[[ Custom autocmds]]
require("autocmds")


--[[ Lazy - plugin manager ]]
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- Setup lazy.nvim
require("lazy").setup( "plugins", {
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


--[[ Colorscheme ]]
require('onedark').load()

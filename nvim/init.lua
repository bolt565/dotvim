-- ============================================================================
-- init.lua  —  translated 1:1 from the legacy ~/.vimrc
-- Plugin manager: lazy.nvim (modern replacement for vim-plug)
-- Philosophy: keep every plugin + every hotkey. Pure-Lua where it's clean
-- (options, keymaps, plugin globals); verbatim vimscript (wrapped in vim.cmd)
-- where rewriting would risk changing behavior.
-- ============================================================================

-- Leaders must be set BEFORE lazy/plugins load so mappings register correctly.
-- was: let mapleader = ','   /   let maplocalleader="\<space>"
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- ----------------------------------------------------------------------------
-- Options   (was: set ...)
-- ----------------------------------------------------------------------------
local opt = vim.opt
opt.background     = "dark"                       -- set background=dark
opt.clipboard      = "unnamedplus"                -- set clipboard=unnamedplus
opt.number         = true                         -- set number
opt.relativenumber = true                         -- set relativenumber  (nu rnu)
opt.termguicolors  = true                         -- set termguicolors
opt.swapfile       = false                        -- set noswapfile
opt.expandtab      = true                         -- set expandtab
opt.tabstop        = 2                            -- set tabstop=2
opt.softtabstop    = 2                            -- set softtabstop=2
opt.shiftwidth     = 2                            -- set shiftwidth=2
opt.wildmode       = "list:longest,list:full"     -- set wildmode=...

-- Dropped on purpose (Neovim defaults make these no-ops):
--   set nocompatible            -> Neovim is never 'compatible'
--   filetype plugin indent on   -> on by default
--   syntax on                   -> on by default
--   set encoding=utf-8          -> utf-8 is the default
--   let &t_8f / &t_8b           -> truecolor handled by 'termguicolors'

-- ----------------------------------------------------------------------------
-- Plugin-specific globals  (set before plugins load)
-- ----------------------------------------------------------------------------

-- NERDTree
vim.g.NERDTreeMinimalUI  = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeDirArrows  = 1

-- nerdtree-git-plugin icons.
-- NOTE: the plugin renamed this variable. Old name was
-- g:NERDTreeIndicatorMapCustom; current name is below. Using the new name so
-- the icons actually apply.
vim.g.NERDTreeGitStatusIndicatorMapCustom = {
  Modified  = "✹",
  Staged    = "✚",
  Untracked = "✭",
  Renamed   = "➜",
  Unmerged  = "═",
  Deleted   = "✖",
  Dirty     = "✗",
  Clean     = "✔︎",
  Ignored   = "☒",
  Unknown   = "?",
}

-- fzf.vim color mapping  (was: let g:fzf_colors = {...})
vim.g.fzf_colors = {
  fg      = { "fg", "Normal" },
  hl      = { "fg", "String" },
  ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
  ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
  info    = { "fg", "PreProc" },
  border  = { "fg", "Ignore" },
  pointer = { "fg", "Exception" },
  spinner = { "fg", "Label" },
  header  = { "fg", "Comment" },
}

-- ----------------------------------------------------------------------------
-- Bootstrap lazy.nvim
-- ----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ----------------------------------------------------------------------------
-- Plugins   (was: call plug#begin() ... call plug#end())
-- ----------------------------------------------------------------------------
require("lazy").setup({
  -- Colorschemes — load eagerly + high priority so :colorscheme works at startup
  { "drewtempelmeyer/palenight.vim", lazy = false, priority = 1000 },
  { "morhetz/gruvbox",               lazy = false, priority = 1000 },

  -- fzf: point at the Homebrew install, exactly like the old `Plug '/usr/local/opt/fzf'`
  -- (path updated for Apple-Silicon Homebrew: /usr/local -> /opt/homebrew)
  { dir = "/opt/homebrew/opt/fzf" },
  "junegunn/fzf.vim",

  -- File tree
  "scrooloose/nerdtree",
  "Xuyuanp/nerdtree-git-plugin",

  -- Git
  "tpope/vim-fugitive",
  -- NOTE: this was NOT in your original plug list, but your `<leader>gm` mapping
  -- calls :GitMessenger. Added so that hotkey actually works.
  { "rhysd/git-messenger.vim", cmd = "GitMessenger" },

  -- Editing
  "tpope/vim-commentary",
  "guns/vim-sexp",

  -- Scheme (lazy-loaded, same as `{ 'for': 'scheme', 'on': 'SchemeConnect' }`)
  { "Olical/vim-scheme", ft = "scheme", cmd = "SchemeConnect" },

  -- Tags
  "craigemery/vim-autotag",
})

-- colorscheme must run AFTER plugins are on the runtimepath
vim.cmd.colorscheme("palenight")                  -- colorscheme palenight

-- Hide the vertical window separator (thin grey line between splits, e.g.
-- NERDTree | code). Make WinSeparator the same color as the editor background
-- so the seam disappears. Re-applied whenever the colorscheme changes.
local function hide_winsep()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  local bg = normal and normal.bg
  if bg then
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = bg, bg = bg })
  end
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = hide_winsep })
hide_winsep()

-- ----------------------------------------------------------------------------
-- Keymaps   (was: nmap / nnoremap / vmap ...)
-- ----------------------------------------------------------------------------
local map = vim.keymap.set

map("n", "<leader>r",  ":so $MYVIMRC<CR>")         -- reload config ($MYVIMRC = this init.lua)
map("n", "<leader>v",  "<cmd>Lazy sync<CR>")       -- was :PlugInstall -> lazy.nvim equivalent
map("n", "<leader>gm", "<cmd>GitMessenger<CR>")    -- :GitMessenger
map("n", "<leader>f",  ":FZF<CR>")                 -- :FZF
map("n", "<leader>s",  ":Rg ")                     -- :Rg  (intentionally no <CR> — leaves cmdline open)
map("n", "<leader>t",  ":NERDTreeToggle<CR>")      -- :NERDTreeToggle
map("n", "<leader>g",  ":G<CR>")                   -- fugitive status
map("n", "<leader>w",  ":w<CR>")
map("n", "<leader>q",  ":q<CR>")
map("n", "<leader>d",  ":noh<CR>")
map("n", "<leader>z",  ":Git difftool -y<CR>")
map("n", "<leader>i",  ":tabdo e<CR>")

-- remap = true because the embedded <C-h> must re-trigger the window-left map below
map("n", "<leader>1", ":Gwrite<CR><C-h>:q<CR>:q<CR>", { remap = true })
map("n", "<leader>9", ":Gread<CR>:w<CR>:q<CR>:q<CR>")

-- was :Gcommit -m  — modern fugitive removed :Gcommit in favor of :Git commit.
-- Trailing space preserved (leaves cmdline open to type the message).
map("n", "<leader>m", ":Git commit -m ")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
-- NOTE: your original mapped <C-j>/<C-k> to <C-w>j / <C-w>k, then immediately
-- remapped them to gT / gt — so the window-nav versions were already dead.
-- Preserving the *effective* behavior: <C-j>/<C-k> = tab navigation.
map("n", "<C-k>", "gt")                            -- next tab
map("n", "<C-j>", "gT")                            -- previous tab

-- Visual-mode comment via vim-commentary (remap so 'gc' expands)
map("x", "<leader>c", "gc", { remap = true })

-- Carried over from your file but they were commented out, so left disabled:
--   nmap <leader>a ibinding.pry<ESC>
--   imap <leader>a binding.pry
--   iabbrev <buffer> dbg puts "------------------$$$$$$$$$$$$>"

-- ----------------------------------------------------------------------------
-- Verbatim vimscript — kept as-is because rewriting risks changing behavior.
-- ----------------------------------------------------------------------------
vim.cmd([[
  " Custom :Rg — colored ripgrep output + preview window (overrides fzf.vim's :Rg)
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep('rg --smart-case --line-number --no-heading --color=always --colors "path:fg:93,169,245" --colors "line:fg:128,128,128" --colors "match:fg:195,232,141" --no-hidden --ignore '.shellescape(<q-args>),
    \ 0,
    \ fzf#vim#with_preview({'options': '-e --delimiter : --nth 3..'}),
    \ <bang>0)

  " Auto-open NERDTree when nvim is launched with no file arguments
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  " :SConnect — start the Scheme REPL and arrange the windows
  function! SchemeConnectWrapper()
    :SchemeConnect
    exe "normal \<C-w>L"
    vert resize -50
    exe "normal \<C-w>h"
  endfunction
  command! SConnect call SchemeConnectWrapper()
]])

local options = {
  expandtab = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  number = true,
  relativenumber = true,
  cursorline = true,
  scrolloff = 8,
  sidescrolloff = 8,
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  hlsearch = false,
  ctermbg=none,
  guibg=none,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

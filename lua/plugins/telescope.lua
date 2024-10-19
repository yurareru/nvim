return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Open find files window"})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Open live grep window"})
      vim.keymap.set('n', '<leader>fG', builtin.git_files, { desc = "Open git files window"})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Open buffers window"})
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end
  }
}

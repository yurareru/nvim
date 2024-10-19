return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open harpoon window" })
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(1) end, { desc = "1st harpoon buffer"})
    vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(2) end, { desc = "2nd harpoon buffer"})
    vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(3) end, { desc = "3rd harpoon buffer"})
    vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(4) end, { desc = "4th harpoon buffer"})

    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Previous harpoon buffer"})
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Next harpoon buffer"})
  end
}

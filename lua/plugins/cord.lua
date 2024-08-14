return {
  'vyfor/cord.nvim',
  build = './build',
  event = 'VeryLazy',
  config = function()
    require('cord').setup({
      display = {
        show_repository = false,
      },
    })
  end
}

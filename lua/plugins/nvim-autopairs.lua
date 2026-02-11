return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {}, -- this is equivalent to setup({}) function
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
  end,
}
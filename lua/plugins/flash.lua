return {
    "https://github.com/folke/flash.nvim",
    event = "VeryLazy",
    config = function()
        require("flash").setup({
            modes = {
                search = {
                    enabled = true,
                },
                char = {
                    enabled = false,
                },
            },
        })
    end,
}

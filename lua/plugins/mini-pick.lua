return {
    {
        'echasnovski/mini.pick',
        version = false, -- Use the latest git commit
        config = function()
            require('mini.pick').setup()
            -- See keymaps in config/keymaps.lua
        window = {
          config = {
            relative = 'cursor', anchor = 'NW',
            row = 0, col = 0, width = 40, height = 20
          }
        }
        end,
    },
}

return {
  "tpope/vim-surround",
  event = "VeryLazy",
  config = function()
    -- vim-surround doesn't require explicit setup
    -- It works out of the box with these keybindings:
    -- ys{motion}{char} - add surroundings
    -- cs{old}{new} - change surroundings
    -- ds{char} - delete surroundings
    -- S{char} in visual mode - surround selection
  end,
}


require"telescope".load_extension("frecency")

require"telescope".setup {
    -- defaults = {
    --     sorting_strategy = "ascending",
    --     layout_strategy = "vertical",
    --     layout_config = {
    --       preview_cutoff = 1, -- Preview should always show (unless previewer = false)
    --
    --       mirror = true,
    --       width = 0.8,
    --
    --       height = 0.9,
    --     },
    -- },
    extensions = {
        frecency = {
            show_unindexed = true,
            show_scores = true,
            sorter = require"telescope".extensions.fzf
                .native_fzf_sorter()
        }
    }
}

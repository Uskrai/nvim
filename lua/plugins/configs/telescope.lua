local present, telescope = pcall(require, "telescope")

if not present then
	return
end

vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
		end
	end,
})

telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			preview_cutoff = 1, -- Preview should always show (unless previewer = false)
			prompt_position = "bottom",
		},
	},
	pickers = {
		find_files = {
			follow = true,
		},
	},
})

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope frecency<cr>")
vim.keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>")

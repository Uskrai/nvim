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
  pickers = {
    find_files = {
      follow = true
    }
  },
  defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {  })
})

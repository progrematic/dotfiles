return {
  'ErichDonGubler/lsp_lines.nvim',
  config = function()
    require('lsp_lines').setup()

    -- Disable virtual_text since it's redundant due to lsp_lines.
    vim.diagnostic.config {
      virtual_text = false,
    }
    vim.keymap.set('', '<Leader>l', function()
      require('lsp_lines').toggle()
      local vtval = not vim.diagnostic.config().virtual_lines
      vim.diagnostic.config { virtual_text = vtval }
    end, { desc = 'Toggle lsp_lines' })
  end,
}

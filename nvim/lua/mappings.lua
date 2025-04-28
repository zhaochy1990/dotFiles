require "nvchad.mappings"

-- add yours here

local keymap = vim.keymap.set

keymap("n", ";", ":", { desc = "CMD enter command mode" })
keymap("n", "<leader>gr", function()
  require("telescope.builtin").lsp_references {
    layout_strategy = "vertical",
    layout_config = { width = 0.8, height = 0.9 },
    jump_type = "never",
  }
end, { desc = "Find references in a new window" })

-- map("n", "<leader>w", "<cmd>w<CR>", { desc = "general save file" })
-- map("n", "<leader>q", "<cmd>q<CR>", { desc = "general save file" })
keymap({ "n", "x" }, "<F8>", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

keymap("t", "<C-u>", "<C-\\><C-N>k", { noremap = true, silent = true }) -- Scroll up
keymap("t", "<C-d>", "<C-\\><C-N>j", { noremap = true, silent = true }) -- Scroll down

keymap('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })

-- map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- map("n", "<leader>l", "<cmd>set nu!<CR>", { desc = "toggle line number" })
-- map("n", "<leader>rl", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- require("nvim-tree").setup {
--   on_attach = function(bufnr)
--     local api = require "nvim-tree.api"
--
--     api.config.mappings.default_on_attach(bufnr)
--     -- Define buffer-local key mappings (only when in NvimTree)
--     local function opts(desc)
--       return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--     end
--
--     -- custom mappings
--     vim.keymap.set("n", "v", api.node.open.vertical, opts "Up")
--     vim.keymap.set("n", "x", api.node.open.horizontal, opts "Help")
--   end,
-- }

keymap({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

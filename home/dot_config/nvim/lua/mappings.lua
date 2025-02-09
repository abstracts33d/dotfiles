require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Remap TmuxNavigate (overriden by Lua)
map("n", "<c-h>", ":<C-U>TmuxNavigateLeft<cr>")
map("n", "<c-j>", ":<C-U>TmuxNavigateDown<cr>")
map("n", "<c-k>", ":<C-U>TmuxNavigateUp<cr>")
map("n", "<c-l>", ":<C-U><TmuxNavigateRight<cr>")
map("n", "<c-\\>", ":<C-U>TmuxNavigatePrevious<cr>")

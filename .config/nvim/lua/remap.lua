-- Move highlighted lines - https://youtu.be/w7i4amO_zaE?t=1537
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Splits resize
-- https://youtu.be/kJVqxFnhIuw?t=532
vim.keymap.set("n", "<C-l>", "<c-w>5<")
vim.keymap.set("n", "<C-h>", "<c-w>5>")

-- Taller/Shorter
vim.keymap.set("n", "<C-k>", "<C-W>+")
vim.keymap.set("n", "<C-j>", "<C-W>-")

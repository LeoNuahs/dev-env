vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Alt-move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join next line with current line
-- without cursor moving ;)
vim.keymap.set("n", "J", "mzJ`z")

-- Navigation without cursor movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")     -- Page up
vim.keymap.set("n", "<C-u>", "<C-u>zz")     -- Page down
vim.keymap.set("n", "n", "nzzzv")   -- Search next
vim.keymap.set("n", "N", "Nzzzv")   -- Search previous
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Best remaps ever
vim.keymap.set("x", "<leader>p", "\"_dP")   -- Better paste

vim.keymap.set("n", "<leader>y", "\"+y")   -- Better yank/copy
vim.keymap.set("v", "<leader>y", "\"+y")   -- Better yank/copy
vim.keymap.set("n", "<leader>Y", "\"+Y")   -- Better yank/copy

vim.keymap.set("n", "<leader>d", "\"_d")   -- Better delete
vim.keymap.set("v", "<leader>d", "\"_d")   -- Better delete

-- Replace all of current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
-- chmod +x current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

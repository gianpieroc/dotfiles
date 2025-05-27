local km = vim.keymap

-- Indentation left and right
km.set('n', '<C-l>', '>>', { noremap = true, silent = true })
km.set('n', '<C-h>', '<<', { noremap = true, silent = true })
km.set('v', '<C-h>', '<gv', { noremap = true, silent = true })
km.set('v', '<C-l>', '>gv', { noremap = true, silent = true })

-- Moving current cursor top and bototm
km.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true, silent = true })
km.set('n', '<C-k>', ':m .-2<CR>==', { noremap = true, silent = true })
km.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
km.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- edition
km.set("n", "<leader>rw", ":g/^$/d<CR>")
-- search
km.set("n", "<leader>\\", ":noh<CR>")
-- buffers
km.set("n", "<leader>bn", ":bnext<CR>")
km.set("n", "<leader>bp", ":bprevious<CR>")
km.set("n", "<leader>bd", ":bd!<CR>")
km.set("n", "<leader>br", ":redraw<CR>")
km.set("n", "<leader>bx", ":%bd|e#<CR>")
--tabs
km.set("n", "<leader>tt", ":tabnew<CR>")
km.set("n", "<leader>tc", ":tabclose<CR>")
km.set("n", "<leader>tn", ":tabnext<CR>")
km.set("n", "<leader>tp", ":tabprev<CR>")
-- window splits
km.set("n", "<leader>ws", "<C-w>s")
km.set("n", "<leader>wsj", "<C-w>s<C-w>j")
km.set("n", "<leader>wv", "<C-w>v")
km.set("n", "<leader>wvl", "<C-w>v<C-w>l")
km.set("n", "<leader>wvh", "<C-w>v<C-w>h")
km.set("n", "<leader>ww", "<C-w>n")
km.set("n", "<leader>wx", "<C-w>x") -- swap with the split on the right
km.set("n", "<leader>wr", "<C-w>r") -- rotates clockwise
km.set("n", "<leader>wR", "<C-w>R") -- rotates counterclockwise
km.set("n", "<leader>wc", "<C-w>q")
km.set("n", "<leader>wj", "<C-w>j")
km.set("n", "<leader>wk", "<C-w>k")
km.set("n", "<leader>wh", "<C-w>h")
km.set("n", "<leader>wl", "<C-w>l")

km.set("n", "gj", "<C-w>j")
km.set("n", "gk", "<C-w>k")
km.set("n", "gh", "<C-w>h")
km.set("n", "gl", "<C-w>l")


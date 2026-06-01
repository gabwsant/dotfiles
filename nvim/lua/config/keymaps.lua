-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Mover linhas selecionadas para baixo no modo Visual (v)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move linhas para baixo" })

-- Mover linhas selecionadas para cima no modo Visual (v)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move linhas para cima" })

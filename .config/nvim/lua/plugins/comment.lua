return {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function(_, opts)
        require("Comment").setup({
            toggler = {line = 'gcc', block = 'gcb'},
            opleader = {line = 'gcc', block = 'gcb'},
            extra = {eol = 'gcL'}
        })
    end
}

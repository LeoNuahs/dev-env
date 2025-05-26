return {
    {
        "nvim-treesitter/nvim-treesitter", 
        branch = "master", 
        lazy = false, 
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "bash", "go", "python", "java", "javadoc", "lua",
                    "javascript", "jsdoc", "typescript"
                },
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}

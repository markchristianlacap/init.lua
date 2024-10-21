if vim.g.vscode then return {} end
return {
  "seblj/roslyn.nvim",
  config = function()
    require("roslyn").setup {
      exe = {
        "dotnet",
        vim.fs.joinpath(
          vim.fn.expand "~",
          ".vscode/extensions/ms-dotnettools.csharp-2.50.27-linux-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll"
        ),
      },
    }
  end,
}

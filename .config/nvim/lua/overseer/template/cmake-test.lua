---@type overseer.TemplateDefinition
return {
  name = "cmake-test",
  builder = function()
    local file = vim.fn.expand("%:p")
    local outfile = vim.fn.expand("%:p:r") .. ".out"
    ---@type overseer.TaskDefinition
    return {
      cmd = { "ctest" },
      args = { "--test-dir", "./build" },
      components = {
        { "on_output_quickfix", open_on_exit = "failure" },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}

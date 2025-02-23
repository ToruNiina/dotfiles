---@type overseer.TemplateDefinition
return {
  name = "cmake-build",
  builder = function()
    local file = vim.fn.expand("%:p")
    local outfile = vim.fn.expand("%:p:r") .. ".out"
    local root = require('nvim-rooter').get_root()
    ---@type overseer.TaskDefinition
    return {
      cmd = { "cmake" },
      args = { "--build", root.."/build" },
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

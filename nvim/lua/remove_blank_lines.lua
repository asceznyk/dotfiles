local M = {}

local function get_node_text(node, bufnr)
  return vim.treesitter.get_node_text(node, bufnr)
end

function M.run()
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr, "python")
  local tree = parser:parse()[1]
  local root = tree:root()

  local query = vim.treesitter.query.parse("python", [[
    (function_definition
      body: (block) @body)

    (async_function_definition
      body: (block) @body)
  ]])

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local to_delete = {}

  for _, node in query:iter_captures(root, bufnr) do
    local sr, _, er, _ = node:range()

    -- Skip the first line (def ...)
    for i = sr + 1, er - 1 do
      local prev = lines[i]
      local curr = lines[i + 1]
      local next = lines[i + 2]

      if curr
        and curr:match("^%s*$")
        and prev
        and next
        and prev:match("^%s+")
        and next:match("^%s+")
      then
        table.insert(to_delete, i + 1)
      end
    end
  end

  table.sort(to_delete, function(a, b)
    return a > b
  end)

  for _, lnum in ipairs(to_delete) do
    vim.api.nvim_buf_set_lines(bufnr, lnum - 1, lnum, false, {})
  end

  vim.cmd("write")
end

return M

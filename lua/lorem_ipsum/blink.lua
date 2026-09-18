local generator = require("lorem_ipsum.generator")

local source = {}

function source.new(_)
  return setmetatable({}, { __index = source })
end

local function trigger_range(context)
  local line_before_cursor = context.line:sub(1, context.cursor[2])
  local trigger = line_before_cursor:lower():match("lorem%s*$")
  if trigger == nil then
    return nil
  end

  local line = context.cursor[1] - 1
  local start_column = context.cursor[2] - #trigger
  return {
    start = { line = line, character = start_column },
    ["end"] = { line = line, character = context.cursor[2] },
  }
end

local function copy_range(range)
  return {
    start = { line = range.start.line, character = range.start.character },
    ["end"] = { line = range["end"].line, character = range["end"].character },
  }
end

function source:get_completions(context, callback)
  local range = trigger_range(context)
  local items = {}

  if range ~= nil then
    local kind = require("blink.cmp.types").CompletionItemKind.Text
    local insert_text_format = vim.lsp.protocol.InsertTextFormat.PlainText

    for _, word_count in ipairs({ 10, 50, 100 }) do
      table.insert(items, {
        label = string.format("lorem ipsum (%d words)", word_count),
        kind = kind,
        documentation = {
          kind = "plaintext",
          value = string.format("Generates a lorem ipsum text with %d words", word_count),
        },
        textEdit = {
          newText = generator.generate(word_count),
          range = copy_range(range),
        },
        insertTextFormat = insert_text_format,
      })
    end
  end

  callback({
    items = items,
    is_incomplete_backward = true,
    is_incomplete_forward = true,
  })
end

return source

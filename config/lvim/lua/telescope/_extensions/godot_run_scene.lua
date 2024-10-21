local pickers       = require('telescope.pickers')
local finders       = require('telescope.finders')
local conf          = require('telescope.config').values
local actions       = require('telescope.actions')
local actions_state = require('telescope.actions.state')

local mappings      = function(opts)
  local port = 1337
  if opts.godot_scene_port then
    port = opts.godot_scene_port
  end
  return function(prompt_bufnr, _)
    actions.select_default:replace(function()
      actions.close(prompt_bufnr)

      local selection = actions_state.get_selected_entry()

      vim.api.nvim_command("!echo -n '" .. selection[1] .. "' | nc -4u -w0 localhost " .. port)
    end)

    return true
  end
end


local run = function(opts)
  opts = opts or {}

  local picker = pickers.new(opts, {
    prompt_title    = 'Godot: Run Scene',
    finder          = finders.new_oneshot_job(
      { "fd", "--extension", "tscn", "--color", "never", "--exclude", "addon*" }, opts),
    -- finder          = finders.new_table({ results = {"foo", "bar"} }),
    sorter          = conf.file_sorter(opts),
    attach_mappings = mappings(opts)
  })

  return picker:find()
end

return require('telescope').register_extension({
  exports = {
    godot_run_scene = run
  }
})


local M = {}

M.config = function()
  local status_ok, orgmode = pcall(require, "orgmode")

  if not status_ok then
    return
  end
  orgmode.setup {
    org_agenda_files = { '~/org/*' },
    org_default_notes_file = '~/org/notes-inbox.org',
    org_agenda_templates = {
      t = {
        description = 'Task',
        template = '* TODO %?\n %U\n',
        target = '~/org/todos-inbox.org',
      },
      d = {
        description = 'Dev Task',
        template = '* TODO %?\n%a\n %U\n',
        target = '~/org/todos-inbox.org',
      },
      n = {
        description = 'Quick Note',
        template = '\n**%? TITLE HERE \n%U\n\note here\n',
        target = '~/org/notes-inbox.org',
      },
    },
    notifications = {
      enabled = true,                  -- neovim floating window notifications
      -- cron requires a crontab entry:
      -- * * * * * DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /home/dan/.local/bin/lvim --headless --noplugin -c 'lua require("orgmode").cron()'
      cron_enabled = true,              -- system notifications via cron
      repeater_reminder_time = false,
      deadline_warning_reminder_time = { 1, 15, 30 },
      reminder_time = { 1, 15, 30 },
      deadline_reminder = true,
      scheduled_reminder = true,
      notifier = function(tasks)
        local result = {}
        for _, task in ipairs(tasks) do
          require('orgmode.utils').concat(result, {
            string.format('# %s (%s)', task.category, task.humanized_duration),
            string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
            string.format('%s: <%s>', task.type, task.time:to_string())
          })
        end

        if not vim.tbl_isempty(result) then
          require('orgmode.notifications.notification_popup'):new({ content = result })
        end
      end,
      cron_notifier = function(tasks)
        for _, task in ipairs(tasks) do
          local title = string.format('%s (%s)', task.category, task.humanized_duration)
          local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
          local date = string.format('%s: %s', task.type, task.time:to_string())

          -- Linux
          if vim.fn.executable('notify-send') == 1 then
            vim.loop.spawn('notify-send', { args = { string.format('%s\n%s\n%s', title, subtitle, date) }})
          end

          -- MacOS
          if vim.fn.executable('terminal-notifier') == 1 then
            vim.loop.spawn('terminal-notifier', { args = { '-title', title, '-subtitle', subtitle, '-message', date }})
          end
        end
      end
    },
    org_todo_keywords = {'TODO', 'INPROGRESS', '|', 'DONE', 'DELEGATED'},
    org_todo_keyword_faces = {
      INPROGRESS = ':foreground blue :weight bold',
      DELEGATED = ':background #FFFFFF :slant italic :underline on',
    }
  }
end

return M

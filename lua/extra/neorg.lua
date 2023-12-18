require('neorg').setup {
  load = {
    ["core.defaults"] = {},        -- Loads default behaviour
    ["core.concealer"] = {},       -- Adds pretty icons to your documents
    ["core.dirman"] = {            -- Manages Neorg workspaces
      config = {
        workspaces = {
          personalNotes = "/mnt/hasanweb/programming/important_notes/",
          workNotes = "/mnt/hasanweb/programming/work/notes/",
        },
      },
    },
  },
}

VMap = {}

local opts = { noremap = true, silent = true }

local function create_mapping_fn(first_mode, ...)
  local modes = { first_mode, unpack({ ... } or {}) }
  return function(keymap, cmd, other_opts)
    local options = { unpack(opts), unpack(other_opts or {}) }
    for _, mode in ipairs(modes) do
      vim.keymap.set(mode, keymap, cmd, options)
    end
  end
end

VMap.nmap = create_mapping_fn("n")

VMap.tmap = create_mapping_fn("t")

VMap.imap = create_mapping_fn("i")

VMap.vmap = create_mapping_fn("v")

VMap.map = create_mapping_fn("i", "n")

VMap.vnmap = create_mapping_fn("v", "n")

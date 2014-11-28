local application = require "mjolnir.application"
local hotkey      = require "mjolnir.hotkey"
local window      = require "mjolnir.window"
local fnutils     = require "mjolnir.fnutils"
local tiling      = require "mjolnir.tiling"

--------------------------------------------------------------------------------
-- tiling window layout
--------------------------------------------------------------------------------
local mash = {"cmd", "alt", "ctrl"}

local function maximize(window)
  frame   = window:screen():frame()
  frame.x = 0
  frame.y = 0
  frame.w = frame.w
  frame.h = frame.h
  window:setframe(frame)
end

hotkey.bind(mash, "c"    , function() tiling.cyclelayout()         end)
hotkey.bind(mash, "j"    , function() tiling.cycle(1)              end)
hotkey.bind(mash, "k"    , function() tiling.cycle(-1)             end)
hotkey.bind(mash, "space", function() tiling.promote()             end)

-- maximize window
hotkey.bind(mash, "M"    , function() tiling.togglefloat(maximize) end)

--------------------------------------------------------------------------------
-- shift focus
--------------------------------------------------------------------------------
hotkey.bind(mash, 'up'   , function() window.focusedwindow():focuswindow_north() end)
hotkey.bind(mash, 'down' , function() window.focusedwindow():focuswindow_south() end)
hotkey.bind(mash, 'left' , function() window.focusedwindow():focuswindow_west()  end)
hotkey.bind(mash, 'right', function() window.focusedwindow():focuswindow_east()  end)

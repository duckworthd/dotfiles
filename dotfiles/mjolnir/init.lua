--------------------------------------------------------------------------------
-- Add non-standard homebrew directories to lua's path
--
-- This is critical to ensure that lua can import the extensions installed by
-- luarocks.
--------------------------------------------------------------------------------
require "os"

local homebrew = os.getenv("HOME") .. "/homebrew"
package.path  = package.path  .. ";" .. homebrew .. "/share/lua/5.2/?.lua"
package.cpath = package.cpath .. ";" .. homebrew .. "/lib/lua/5.2/?.so"

--------------------------------------------------------------------------------
-- mjolnir extensions
--------------------------------------------------------------------------------
local application = require "mjolnir.application"
local hotkey      = require "mjolnir.hotkey"
local window      = require "mjolnir.window"
local fnutils     = require "mjolnir.fnutils"
local tiling      = require "mjolnir.tiling"

local mash = {"cmd", "alt", "ctrl"}

--------------------------------------------------------------------------------
-- tiling window layout
--------------------------------------------------------------------------------

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

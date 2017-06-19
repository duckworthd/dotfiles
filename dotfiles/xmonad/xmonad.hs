{-# LANGUAGE DeriveDataTypeable #-}

-- | Imports
import XMonad hiding ((|||))

-- Basic data types
import qualified Data.List as L
import qualified Data.Maybe as M

-- Utils
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import System.Exit
import System.IO

-- Imports for various layouts
import XMonad.Layout hiding ((|||))
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation

-- Imports for desktop management
import XMonad.Hooks.ManageDocks

-- For special extensions and TODOs
-- * for storing state, specifically the screen pairing boolean
import qualified XMonad.Util.ExtensibleState as XS
-- * for executing actions on both screens without changing focus
import XMonad.Actions.OnScreen
-- * for alt-tab functionality between screens and workspaces
import XMonad.Actions.CycleWS
-- * for xmobar & stalonetray
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)


-- | start xmonad + xmobar
main = do
    xmobar <- spawnPipe "xmobar"
    xmonad $ myConfig xmobar


-- | Main config
myConfig logHandle = defaultConfig
    { terminal            = myTerminal
    , modMask             = mod4Mask
    , focusFollowsMouse   = False
    , workspaces          = myWorkspaces
    , layoutHook          = myLayoutHook
    , manageHook          = myManageHook
    , logHook             = myLogHook logHandle
    , keys                = myKeys
    , normalBorderColor   = myInactiveBorderColor
    , focusedBorderColor  = myActiveBorderColor
    , borderWidth         = 5

    }

-- | Logging
myLogHook logHandle = dynamicLogWithPP $ xmobarPP
  { ppOutput  = hPutStrLn logHandle
  , ppCurrent = currentStyle      -- currently selected screen
  , ppVisible = visibleStyle      -- visible but currently unselected screen
  , ppTitle   = titleStyle        -- currently selected app name
  , ppSep     = sepStyle          -- separator between fields
  , ppLayout  = (\layout -> case layout of
      "ResizableTall"         -> "[ | ]"
      "Mirror ResizableTall"  -> "[———]"
      "ThreeCol"              -> "[| |]"
      "Spiral"                -> "[ o ]"
      "Tabbed Simplest"       -> "[   ]"
      other                   -> other
    )
  }
  where
    currentStyle = xmobarColor "#70db70" "" . wrap "[" "]"
    visibleStyle = xmobarColor "#274d27" "" . wrap "[" "]"
    titleStyle   = xmobarColor "cyan" "" . shorten 100 . filterCurly
    filterCurly  = filter (not . isCurly)
    sepStyle     = xmobarColor "#474747" "" " »»» "
    isCurly x    = x == '{' || x == '}'

-- | Terminal
myTerminal = "gnome-terminal"


-- | Workspaces
myWorkspaces = nums ++ map ("F"++) nums
    where nums = map show [1..10]

-- workspace switching keys
myWsKeys = myNumKeys ++ myFunKeys
myNumKeys = map show [1..9] ++ ["0"]
myFunKeys = map (\n -> "<F"++n++">") (map show [1..10])


-- | Layouts
-- windowNavigation for M-[hjkl] movement
-- avoidStruts hides spacing for xmobar & friends. Use ToggleStrut (M-b) to show.
myLayoutHook = windowNavigation $ avoidStruts
  ( two ||| Mirror two ||| ThreeCol 1 (3/100) (1/3) ||| spiral (1) ||| simpleTabbed )
    where two = ResizableTall 1 (3/100) (1/2) []


-- | Management
-- Special window management policies for specific applications. To discover
-- the name of a window, you can use,
--   $ xprop | grep 'WM_CLASS'
-- then set,
--   className =? "[FIRST OUTPUT HERE]"
-- using its output.
--
-- You can also move floating windows arround by holding Meta and long clicking.
myManageHook = composeAll
    [ className =? "Xmessage"     --> doFloat
    , resource  =? "stalonetray"  --> doFloat
    , role      =? "pop-up"       --> doFloat   -- Google Hangouts extension for Chrome
    , className =? "Keepassx"     --> doFloat
    , manageDocks
    ]
  where
    role = stringProperty "WM_WINDOW_ROLE"


-- | Keyboard shortcuts
myKeys = \conf -> mkKeymap conf $
  -- Window Navigation
  [ ("M-h",             sendMessage $ Go L)
  , ("M-j",             sendMessage $ Go D)
  , ("M-k",             sendMessage $ Go U)
  , ("M-l",             sendMessage $ Go R)

  , ("M-m",             windows W.focusMaster)
  , ("M-n",             windows W.focusDown)
  , ("M-p",             windows W.focusUp)

  -- Window Movement
  , ("M-S-h",           sendMessage $ Swap L)
  , ("M-S-j",           sendMessage $ Swap D)
  , ("M-S-k",           sendMessage $ Swap U)
  , ("M-S-l",           sendMessage $ Swap R)

  , ("M-S-m",           windows W.swapMaster)
  , ("M-S-n",           windows W.swapDown)
  , ("M-S-p",           windows W.swapUp)

  -- Drop floating window back into tiling
  , ("M-t",             withFocused $ windows . W.sink)

  -- Kill window
  , ("M-q",             kill)
  ]

  -- Layout Management
  ++
  [ ("M-<Space>",       sendMessage NextLayout)
  , ("M-S-<Space>",     sendMessage FirstLayout)

  -- shrink/grow size of main panel
  , ("M--",             sendMessage Shrink)
  , ("M-=",             sendMessage Expand)

  -- toggle spacing for xmobar
  , ("M-b",             sendMessage $ ToggleStruts)

  , ("M-<Scroll_lock>", XS.modify wsTogglePairState)
  ]

  -- Applications
  ++
  [ ("M-<Return>",      spawn $ XMonad.terminal conf)
  , ("M-S-<Return>",    spawn $ "dmenu_run -i -l 5")
  ]

  -- XMonad system
  ++
  [ ("M-C-<Esc>",       spawn $ "xkill")
  , ("M-S-q",           io (exitWith ExitSuccess))
  , ("M-S-r",           spawn "xmonad --recompile; xmonad --restart")
  ]

  -- Shift monitors
    -- mod-{y,o}: Switch to physical/Xinerama screens 1, 2
    -- mod-shift-{y/u,o/i}: Move window to screen 1, 2
  ++
  [ ("M-y",             screenWorkspace 0 >>= flip whenJust (windows . W.view))
  , ("M-o",             screenWorkspace 1 >>= flip whenJust (windows . W.view))

  , ("M-S-y",           screenWorkspace 0 >>= flip whenJust (windows . W.shift))
  , ("M-S-o",           screenWorkspace 1 >>= flip whenJust (windows . W.shift))
  ]

  -- alt-tab for monitors and workspaces, via CycleWS
  ++
  [ ("M-<Tab>",         nextScreen)
  , ("M-S-<Tab>",       shiftNextScreen >> nextScreen)
  , ("M-`",             toggleWS)
  ]

  -- Unified workspace shifting.
  -- mod-#      : Switch to workspace.
  -- mod-shift-#: Move current pane to workspace.
  ++
  [ (m ++ k,            f k)
  | k <- myWsKeys
  , (m, f) <- [("M-", myViewer), ("M-S-", myShifter)]
  ]

  -- Lock screen.
  ++
  [ ("M-<Esc>",         spawn "gnome-screensaver-command --lock")
  ]


-- | Colors
myActiveBorderColor   = "#00ff35"    -- bright, bright green
myInactiveBorderColor = "black"


-- | Helper functions
--
-- let bools be stored in persistent storage
data WsPairState = WsPairState Bool deriving (Typeable, Read, Show)
instance ExtensionClass WsPairState where
  initialValue  = WsPairState False
  extensionType = PersistentExtension

-- toggle the state of the stored bool
wsTogglePairState (WsPairState s) = WsPairState $ not s

-- The core of the workspace switching
-- * if the pair state is false, just do normal views
-- * if the pair state is true, do paired workspace switching
myViewer k = do
  WsPairState s <- XS.get
  case s of
    False -> windows $ W.view (keyWs k)
    True  -> windows (onlyOnScreen 0 (numKeyWs k)) >> windows (onlyOnScreen 1 (funKeyWs k))

myShifter k = windows $ W.shift (keyWs k)

-- Maps input keys to corresponding workspaces
keyWs k = snd . head $ filter ((==k) . fst) myWsMap
  where
    myWsMap = zip myWsKeys myWorkspaces

-- Maps input keys to corresponding number or function workspaces
numKeyWs k = keyWs $ myNumKeys !! modIndex k
funKeyWs k = keyWs $ myFunKeys !! modIndex k
modIndex k = M.fromJust (L.elemIndex k myWsKeys) `mod` 10

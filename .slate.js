///////////////////////////// Environment //////////////////////////////////////
S.configAll({
  "defaultToCurrentScreen"         : true,
  "secondsBetweenRepeat"           : 0.1,
  "checkDefaultsOnLoad"            : true,
  "focusCheckWidthMax"             : 3000,
  "orderScreensLeftToRight"        : true,
  "windowHintsShowIcons"           : true,
  "windowHintsIgnoreHiddenWindows" : false,
  "windowHintsSpread"              : true
});

///////////////////////////// Layouts //////////////////////////////////////////
// push active window around
var push = (function() {
  var push = {};

  // create a "push screen to left/right/top/bottom half"
  var pushHalf = function(direction, axis) {
    return {
      "direction" : direction,
      "style"     : "bar-resize:screenSize" + axis + "/2"
    };
  };

  // create a "push to one of the 4 quarters"
  var pushQuarter = function(direction) {
    return {
      "direction" : direction,
      "width"     : "screenSizeX/2",
      "height"    : "screenSizeY/2"
    };
  };

  push.right  = slate.operation("push", pushHalf( "right", "X"));
  push.left   = slate.operation("push", pushHalf(  "left", "X"));
  push.top    = slate.operation("push", pushHalf(   "top", "Y"));
  push.bottom = slate.operation("push", pushHalf("bottom", "Y"));

  push.topLeft     = slate.operation("corner", pushQuarter(    "top-left"));
  push.topRight    = slate.operation("corner", pushQuarter(   "top-right"));
  push.bottomLeft  = slate.operation("corner", pushQuarter( "bottom-left"));
  push.bottomRight = slate.operation("corner", pushQuarter("bottom-right"));

  return push;
})();

// focus on a window
var focus = (function() {
  var focus = {};

  focus.left   = slate.operation("focus", { "direction" : "left"  });
  focus.right  = slate.operation("focus", { "direction" : "right"  });
  focus.top    = slate.operation("focus", { "direction" : "up"  });
  focus.bottom = slate.operation("focus", { "direction" : "down"  });

  return focus;
}());

// make window full scree
var fullscreen = slate.operation("move", {
  "x"      : "screenOriginX",
  "y"      : "screenOriginY",
  "width"  : "screenSizeX",
  "height" : "screenSizeY"
});

/**
 * Collect all windows except with a specified name
 */
var collectWindows = function(ignore) {
  var windows = [];
  slate.eachApp(function(app) {
    if (_.contains(ignore, app.name())) return;
    app.eachWindow(function(win) {
      if (!win.isResizable()) return;
      if (win.isMinimizedOrHidden()) return;
      if (null == win.title() || win.title() === "") return;
      windows.push(win);
    });
  });

  return windows;
};

/**
 * a sort of "golden spiral" layout
 */
var retile = function(windowObject) {
  slate.log("retiling");

  // collect windows
  slate.log("retrieving windows...");
  var windows = collectWindows(["iTerm"]);
  slate.log("retrieved " + windows.length.toString() + " windows");

  // decide on window size for non-main windows (40% of right side)
  slate.log("determining window sizes...");
  var ss          = slate.screen().rect();
  var windowSizeX = ss.width * 0.4;
  var windowSizeY = ss.height / (windows.length - 1);
  var winPosY     = 0;

  slate.log("moving windows");
  for (i = 0; i < windows.length; i++) {
    w = windows[i];

    if (w.title() == windowObject.title()) {
      // main window; resize to 60% of left side
      mainWidth = (windows.length > 1) ? "screenSizeX*0.6" : "screenSizeX";

      w.doOperation("move", {
        "x"      : "screenOriginX",
        "y"      : "screenOriginY",
        "width"  : mainWidth,
        "height" : "screenSizeY"
      });
    }
    else {
      // "other" window; 40% of right size
      w.doOperation("move", {
        "x"      : "screenSizeX*0.6",
        "y"      : winPosY,
        "width"  : windowSizeX,
        "height" : windowSizeY
      });

      winPosY += windowSizeY;
    }
  }
}

///////////////////////////// Key Bindings /////////////////////////////////////

// throw to halves
slate.bind("h:alt;cmd",   push.left);
slate.bind("l:alt;cmd",  push.right);
slate.bind("k:alt;cmd",    push.top);
slate.bind("j:alt;cmd", push.bottom);

// fullscreen
slate.bind("m:alt;cmd", fullscreen);

// throw to corners
slate.bind("1:alt;cmd",     push.topLeft);
slate.bind("2:alt;cmd",    push.topRight);
slate.bind("3:alt;cmd",  push.bottomLeft);
slate.bind("4:alt;cmd", push.bottomRight);

// window selector
slate.bind("tab:cmd", slate.operation("hint"));

// focus
slate.bind("h:alt;cmd;ctrl",   focus.left);
slate.bind("l:alt;cmd;ctrl",  focus.right);
slate.bind("k:alt;cmd;ctrl",    focus.top);
slate.bind("j:alt;cmd;ctrl", focus.bottom);

// // divide screen into grid
// slate.bind("g:alt;cmd", slate.operation("grid", {
//   "grids": {
//     "1366x768": { "width"  : 4, "height" : 3 }
//   },
//   "padding": 0
// }))
// })

// Basic keybinds
slate.bind("r:cmd;alt", retile);

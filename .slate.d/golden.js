// golden spiral
var golden = function() {
  // parse arguments
  var defaults = {
        // screen limits
        'xMin' : 0,
        'yMin' : 0,
        'xMax' : 1000,
        'yMax' : 1000,

        // number of windows
        'n' : 10,

        // number of panes per layer
        'count' : function(layer) { return layer == 0 ? 2 : 3; },

        // initial orientation of splits
        'orientation' : 'horizontal'
      },
      args = configure(arguments[0], defaults);

  slate.log("xMin: " + args.xMin.toString());
  slate.log("yMin: " + args.yMin.toString());
  slate.log("xMax: " + args.xMax.toString());
  slate.log("yMax: " + args.yMax.toString());

  var layer = 0,
      boxes = [],
      orientation = args.orientation,
      box = {
        'xMin' : args.xMin,
        'xMax' : args.xMax,
        'yMin' : args.yMin,
        'yMax' : args.yMax
      },
      remaining = function() { return args.n - boxes.length; };

  while (true) {
    var n = _.min([remaining(), args.count(layer)]),   // number of panels in this layer
        nWindows = n == remaining() ? n : n - 1;  // number of panels dedicated to windows

    if (orientation == 'horizontal') {
      // partition y into the remaining space
      var size = ~~((box.yMax - box.yMin) / n);

      for (var i = 0; i < nWindows; i++) {
        boxes.push({
          'xMin': box.xMin,
          'xMax': box.xMax,
          'yMin': box.yMin +     i * size,
          'yMax': box.yMin + (i+1) * size,
          'layer': layer
        });
      }

      // reset yMin to account for used up space
      box.yMin += nWindows * size;
    } else if (orientation == 'vertical') {
      // partition y into the remaining space
      var size = ~~((box.xMax - box.xMin) / n);

      for (var i = 0; i < nWindows; i++) {
        boxes.push({
          'xMin': box.xMin +     i * size,
          'xMax': box.xMin + (i+1) * size,
          'yMin': box.yMin,
          'yMax': box.yMax,
          'layer': layer
        });
      }

      // reset yMin to account for used up space
      box.xMin += nWindows * size;
    }

    layer += 1;
    orientation = orientation == 'horizontal' ? 'vertical' : 'horizontal';
    if (remaining() == 0) break;
  }

  return boxes;
}

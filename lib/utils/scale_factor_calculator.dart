class ScaleFactorCalculator {
  static const GAME_WIDTH = 1440;
  static const GAME_HEIGHT = 900;

  static double calcScaleFactor(var window_width, var window_height) {
    double scaleFactor;

    if (GAME_WIDTH > GAME_HEIGHT) {
      if ((window_width / window_height) > (GAME_WIDTH / GAME_HEIGHT)) {
        scaleFactor = window_width / GAME_WIDTH;
      } else {
        scaleFactor = window_height / GAME_HEIGHT;
      }
    } else {
      if ((window_height / window_width) > (GAME_HEIGHT / GAME_WIDTH)) {
        scaleFactor = window_width / GAME_HEIGHT;
      } else {
        scaleFactor = window_height / GAME_WIDTH;
      }
    }

    scaleFactor = scaleFactor + scaleFactor * 0.02;
    return scaleFactor;
  }
}

class MyHelper {
  static String stringToImage(String input) {
    var name = '';
    switch (input) {
      case 'sn':
        name = 'snow';
        break;
      case 'sl':
        name = 'sleet';
        break;
      case 'h':
        name = 'hail1';
        break;
      case 't':
        name = 'thunderstorm';
        break;
      case 'hr':
        name = 'rain';
        break;
      case 'lr':
        name = 'rain';
        break;
      case 's':
        name = 'showers';
        break;
      case 'hc':
        name = 'heavy_cloud';
        break;
      case 'lc':
        name = 'light_cloud';
        break;
      case 'c':
        name = 'clear';
        break;
      default:
        name = 'clear';
        break;
    }
    return name;
  }
}

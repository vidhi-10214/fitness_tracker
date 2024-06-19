//COMMON CLASS FOR ACCESSING COLORS
class AppColors{

  AppColors._internal();

  factory AppColors(){
    return _appColors;
  }

  get black => getColorHexFromStr("#151718");
  get grey => getColorHexFromStr("#F6F5F8");
  get red => getColorHexFromStr("#DF544E");
  get white => getColorHexFromStr("#FFFFFF");
  get lightPink => getColorHexFromStr("#FBEBEF");

  // FOR CONVERTING HEXADECIMAL COLOR STRING TO INTEGER
  int getColorHexFromStr(String colorStr) {
    colorStr = 'FF$colorStr';
    colorStr = colorStr.replaceAll('#', '');
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException(
            'An error occurred when converting a color');
      }
    }
    return val;
  }

  static final AppColors _appColors = AppColors._internal();

}
// CREATE A GLOBAL INSTANCE OF APP COLORS FOR EASY ACCESS THROUGHOUT THE APPLICATION.

AppColors appColors = AppColors();
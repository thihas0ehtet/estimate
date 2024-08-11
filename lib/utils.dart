import 'package:intl/intl.dart';

abstract class Utils {
  static String currencyFormat(String data) {
    if (data == "0") {
      return data;
    } else {
      var doubleFormat = double.parse(data);
      var formatter = NumberFormat(',###');
      String formatNumber = formatter.format(doubleFormat);
      return formatNumber;
    }
  }
}

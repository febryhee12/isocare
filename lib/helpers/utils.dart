import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Utils {
  static replaceAsterisktoBreak(string) {
    var original = string;
    var find = '*';
    var replaceWith = '\n';
    return original.replaceAll(find, replaceWith);
  }

  static removeTime(string) {
    var parts = string.split('T');
    return DateTime.tryParse(parts[0].trim());
  }

  static localeDate(string) {
    initializeDateFormatting();
    var date = removeTime(string);
    return DateFormat("d MMMM yyyy", "id_ID").format(date);
  }
}

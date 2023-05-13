import 'package:intl/intl.dart';

String timestampToDate(date) {
  return DateFormat.MMMEd().format(date).toString();
}

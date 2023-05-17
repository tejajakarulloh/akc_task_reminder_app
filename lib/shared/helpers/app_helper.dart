import 'package:intl/intl.dart';

String timestampToDate(date) {
  return DateFormat.MMMEd().add_Hm().format(date).toString();
}

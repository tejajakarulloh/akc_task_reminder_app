import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

String timestampToDate(date) {
  return DateFormat.MMMEd().add_Hm().format(date).toString();
}

AndroidOptions getAndroidOptionsStorage() =>
    const AndroidOptions(encryptedSharedPreferences: true);

DateTime timestampToDatetime(date) {
  return DateTime.fromMillisecondsSinceEpoch(date);
}

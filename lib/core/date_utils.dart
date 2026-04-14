import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  try {
    final parsedDate = DateFormat('MMMM d, yyyy').parse(dateStr);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  } catch (e) {
    return dateStr;
  }
}

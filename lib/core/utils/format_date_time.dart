import 'package:intl/intl.dart';

String FormatDateTimeBydMMMYYYY(DateTime dateTime){

  return DateFormat("d MMM, yyyy").format(dateTime);

}
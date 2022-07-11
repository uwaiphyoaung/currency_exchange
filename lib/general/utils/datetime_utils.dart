import 'package:intl/intl.dart';

class DateTimeUtils{
  static String getCurrentDate(){
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  static String chageDate(String date){
  DateFormat formater = new DateFormat("yyyy-MM-dd");
  var inputDate = formater.parse(date);
  var outputFormat = DateFormat('MMMM dd, yyyy');
  return outputFormat.format(inputDate);
  }

  static String getDateFromTimestamp(int data){
    var d = DateTime.fromMillisecondsSinceEpoch(data  * 1000);
    return DateFormat('dd-MMM-yyyy').format(d);
  }

  static bool canCheckRates(int lastSyncTime){
    print("$lastSyncTime");
    DateTime now = DateTime.now();
    Duration difference = now.difference(DateTime.fromMillisecondsSinceEpoch(lastSyncTime  * 1000));
    print("Differ ${difference.inMinutes}");
    if (difference.inMinutes > 30) {
      return true;
    } else {
      return false;
    }
  }
}
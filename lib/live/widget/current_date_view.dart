import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/general/utils/datetime_utils.dart';

class CurrentDateView extends StatefulWidget{
  final DateChangeListener cb;

  CurrentDateView({required this.cb});

  @override
  State<StatefulWidget> createState() => CurrentDateViewState();
}

class CurrentDateViewState extends State<CurrentDateView>{
  String mDate = "Today";
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      child: InkWell(
        onTap: () async{
          DateTime? date = DateTime(1900);

          date = await showDatePicker(
              context: context,
              initialDate:DateTime.now(),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));
          DateFormat formatter = DateFormat("dd/MM/yyyy");
          DateFormat formatter2 = DateFormat("yyyy-MM-dd");
          widget.cb(formatter2.format(date!)==DateTimeUtils.getCurrentDate()? "Today":formatter2.format(date));
          setState((){
            mDate = formatter2.format(date!)==DateTimeUtils.getCurrentDate()? "Today": formatter.format(date);
          });
        },
        child: Container(
          child: Row(
            children: [
              Text(mDate, style: TextStyle(fontSize: 11.sp),),
              SizedBox(width: 3.w,),
              Icon(Icons.calendar_month, color: Colors.yellow.shade800,)
            ],
          ),
        ),
      ),
    );
  }
}

typedef void DateChangeListener(String val);
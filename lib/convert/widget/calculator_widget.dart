import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wm_cc/convert/widget/back_btn.dart';
import 'package:wm_cc/convert/widget/dail_number_view.dart';

import '../../general/constant/constant.dart';
import '../../general/session/session_manager.dart';
import '../presenter/convert_presenter.dart';

class CalculatorWidget extends StatefulWidget{
  final String clickFrom;
  final String otherCurrency;
  final bool isTop;

  CalculatorWidget({required this.clickFrom, required this.otherCurrency, required this.isTop});

  @override
  State<StatefulWidget> createState() => CalculatorWidgetState();
}

class CalculatorWidgetState extends State<CalculatorWidget>{

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5.h,left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    Expanded(
                      child: EditableText(
                        autofocus: false,
                        maxLines: null,
                        backgroundCursorColor: Colors.amber,
                        cursorColor: Colors.green,
                        style: TextStyle(color: Colors.black, fontSize: 25.sp, fontWeight: FontWeight.bold),
                        focusNode:  FocusNode(),
                        controller: controller,
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                            controller.clear();
                        },
                        icon: const Icon(Icons.clear))
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: OrientationBuilder(builder: (context, orientation) {
                    return GridView.builder(
                      itemCount: Constants.title.length,
                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (orientation == Orientation.portrait) ? 3 : 6),
                      itemBuilder: (BuildContext context, int index) {
                        return DailButton(
                          Constants.title.toList()[index],
                          cb: (value){
                            switch (value){
                              case "0":
                                if(controller.text.isNotEmpty){
                                  if(!(controller.text.toString()=="Error")) {
                                    controller.text =
                                        controller.text.toString() + value;
                                  }else{
                                    controller.text = value;
                                  }
                                }
                                break;
                              case ".":
                                if(!controller.text.contains(".")){
                                  if(!(controller.text.toString()=="Error")) {
                                    controller.text =
                                        controller.text.toString() + value;
                                  }else{
                                    controller.text = value;
                                  }
    }
                                break;
                              case "✓":
                                if(controller.text.isNotEmpty && !(controller.text.toString()=="Error")){
                                  print(controller.text);
                                  ConverterPresenter().convertCurrencyByDate(context, true,
                                      from: widget.clickFrom,
                                      to: widget.otherCurrency,
                                      amount: controller.text,
                                      date: SessionManager.getLastConvertDate());
                                  Navigator.pop(context);
                                }else{
                                  controller.text = "Error";
                                }
                                break;
                              default:
                                if(!(controller.text.toString()=="Error")) {
                                  controller.text =
                                      controller.text.toString() + value;
                                }else{
                                  controller.text = value;
                                }
                                break;
                            }
                          },
                        );
                      },
                    );
                  }),
                ),
              ),
              BackBtn()
            ],
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
class Habit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HabitState();
  }
}
class HabitState extends State<Habit>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Container(
          child: Text("生活習慣",
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
          ),
          margin: EdgeInsets.all(10.0),
        ),
        new Container(
          child: new Image.network("https://safenology.idv.tw/ben/habit1.png"),
          margin: EdgeInsets.all(10.0),
        ),
        new Text("最近一週睡眠狀況"),
        new Container(
          child: new Image.network("https://safenology.idv.tw/ben/habit2.png"),
          margin: EdgeInsets.all(10.0),
        ),
        new Text("最近一週喝水水量"),
      ],
    );
  }

}
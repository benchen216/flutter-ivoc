import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:csv/csv.dart';
import 'dart:convert' show utf8;
class Favorite extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FavoriteState();
  }

}
class FavoriteState extends State<Favorite> {
  var csv1 = new List();  //建立陣列
  var csv2 = new List();
  var csv3 = new List();
  var csvT = new List<bool>();
  void fetchCsv () async {
    var response = await get('https://safenology.idv.tw/ben/dict.csv');
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(response.body);
    setState(() {
      //var decoded = utf8.decode(rowsAsListOfValues);
      var d = utf8.decode(response.bodyBytes).split('\r\n');
      for(int i=0;i<d.length;i++){
        csv1.add(d[i].split(',')[0]);
        csv2.add(d[i].split(',')[1]);
        csv3.add(d[i].split(',')[2]);
        csvT.add(true);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Container(
        child: ListView(
          children: buildvoclist(),
        ),
      ),
    );
  }
  List<Widget> buildvoclist(){
    fetchCsv ();
    var list1 = new List<Widget>();
    for(int i = 0; i < csv1.length; i++){
      list1.add(myVoc(i,csv1,csv2,csv3,csvT));
    }
    return list1;
  }
  Widget myVoc(j,x,y,z,k){
    return new GestureDetector(
      onTap: (){
        setState(() {
          csvT[j]=!csvT[j];
        });
      },
      child:
      new Container(
        child: Row(
            children:<Widget>[
              Text(csv1[j]),
              Spacer(),
              Icon(csvT[j]?Icons.favorite_border:Icons.favorite,
                color: csvT[j]?null:Colors.red,
              ),

            ]
        ),
        margin: EdgeInsets.all(10.0),
      ),
    );
  }
}
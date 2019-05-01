import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:csv/csv.dart';
import 'dart:convert' show utf8;
import 'package:ivoc/flutter_tts.dart';
class VData extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VDataState();
  }

}
enum TtsState { playing, stopped }
class VDataState extends State<VData> {
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


  FlutterTts flutterTts;
  dynamic languages=Text("");
  dynamic voices=Text("");
  String language;
  String voice;



  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }
  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }
  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }
  Future _speak(_newVoiceText) async {
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
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
        _speak(csv1[j]);
      },
      child:
      new Container(
        child: Row(
            children:<Widget>[
              Text(csvT[j]?csv1[j]:csv2[j]+csv3[j]),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ]
        ),
        margin: EdgeInsets.all(10.0),
      ),
    );
  }
}
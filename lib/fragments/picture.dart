import 'package:flutter/material.dart';
class picture extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return pictureState();
  }

}
class pictureState extends State<picture>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              child: Text("圖文",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            new GestureDetector(
              child:
              new Container(
                child: Row(
                    children:<Widget>[
                      new Container(
                        child: new Image.network("https://safenology.idv.tw/ben/oldman.png"),
                        margin: EdgeInsets.all(10.0),
                        height: 100,
                        width: 100,
                      ),
                      Text("Old Man"),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ]
                ),
                margin: EdgeInsets.all(10.0),
              ),

            ),

            new GestureDetector(
              child:
              new Container(
                child: Row(
                    children:<Widget>[
                      new Container(
                        child: new Image.network("https://safenology.idv.tw/ben/oldwoman.png"),
                        margin: EdgeInsets.all(10.0),
                        height: 100,
                        width: 100,
                      ),
                      Text("Old Woman"),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ]
                ),
                margin: EdgeInsets.all(10.0),
              ),

            ),

            new GestureDetector(
              onTap: (){
                print("Container clicked");
              },
              child:
              new Container(
                child: Row(
                    children:<Widget>[
                      new Container(
                        child: new Image.network("https://resources.stuff.co.nz/content/dam/images/1/q/w/z/s/v/image.related.StuffLandscapeSixteenByNine.710x400.1qwzry.png/1532287789079.jpg"),
                        margin: EdgeInsets.all(10.0),
                        height: 100,
                        width: 100,
                      ),
                      Text("Air Plane"),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ]
                ),
                margin: EdgeInsets.all(10.0),
              ),
            ),
          ],
        )
    );
  }
  }

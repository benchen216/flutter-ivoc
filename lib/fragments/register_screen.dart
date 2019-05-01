import 'package:flutter/material.dart';
import '../Mixin/validation_mixin.dart';

class RegisterScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> with Validation_mixin{
  final formKey = GlobalKey<FormState>();
  String password;
  String email;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            fnameField(),
            lnameField(),
            unameField(),
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(bottom: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }
  Widget lnameField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: '名',
        hintText: "amy",
      ),
    );
  }
  Widget fnameField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: '姓',
        hintText: "wu",
      ),
    );
  }
  Widget unameField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: '帳號',
      ),
    );
  }
  Widget emailField(){
    return TextFormField(
      keyboardType:  TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: "you@example.com",
      ),
      validator: validateEmail,
      onSaved: (String value){
        email = value;
      },
    );
  }

  Widget passwordField(){
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: '密碼',
          hintText: "密碼",
        ),
      validator: validatePassword,
      onSaved: (String value){
          password = value;
      },
    );
  }

  Widget submitButton(){
    return RaisedButton(
      color: Colors.indigoAccent,
      child: Text("送出"),
      onPressed: (){
        if(formKey.currentState.validate()){
          formKey.currentState.save();
        }
      },
    );
  }
}
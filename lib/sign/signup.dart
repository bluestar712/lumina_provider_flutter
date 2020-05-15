import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumina/models/profile_models/profile.dart';
import 'package:lumina/screens/tab_main.dart';
import 'package:lumina/sign/signIn.dart';


class SignUpPage extends StatefulWidget{
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage>{
  

  String _emailId;
  String _firstname;
  String _lastname;
  String _passwordId;
  String _confirmpasswordId;

  bool passwordVisible;
  bool confirmpasswordVisible;
  bool emailValid;
  bool isLoading = false;

  @override
  void initState() {
    passwordVisible = true;
    confirmpasswordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget Logo(){
      return Container(
        height: 70,
        width: 200,
        child: ClipRRect(
          child: Image.asset('assets/images/startlogo.png'),
        ),
      );
    }


    Widget FirstName(){

      return Theme(
        data: ThemeData(
            primaryColor: Color(0xff88c1ce),
            primaryColorDark: Color(0xff88c1ce),
            hintColor: Colors.black,
            textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.black)
            )
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: new Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (text){
                      _firstname = text;

                    },
                    decoration: new InputDecoration(
                      labelText: "First Name",
                      hintText: "First name",
                      fillColor: Colors.white,
                      filled: true,

                      border: new OutlineInputBorder(

                        borderSide: new BorderSide(),
                      ),
                      enabledBorder: new OutlineInputBorder(

                        borderSide: new BorderSide(color: Color(0xff88c1ce), width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,

                  ),
                ],
              ),
            )
        ),
      );
    }

    Widget LastName(){

      return Theme(
        data: ThemeData(
            primaryColor: Color(0xff88c1ce),
            primaryColorDark: Color(0xff88c1ce),
            hintColor: Colors.black,
            textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.black)
            )
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: new Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (text){
                      _lastname = text;
                    },
                    decoration: new InputDecoration(
                      labelText: "Last Name",
                      hintText: "Last name",
                      fillColor: Colors.white,
                      filled: true,
                      border: new OutlineInputBorder(

                        borderSide: new BorderSide(),
                      ),
                      enabledBorder: new OutlineInputBorder(

                        borderSide: new BorderSide(color: Color(0xff88c1ce), width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,

                  ),
                ],
              ),
            )
        ),
      );
    }


    Widget Email(){

      return Theme(
        data: ThemeData(
          primaryColor: Color(0xff88c1ce),
          primaryColorDark:Color(0xff88c1ce),
          hintColor: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black)
          )
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: new Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (text){
                      _emailId = text;
                      emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailId);
                    },
                    decoration: new InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      fillColor: Colors.white,
                      filled: true,
                      border: new OutlineInputBorder(

                        borderSide: new BorderSide(),
                      ),
                      enabledBorder: new OutlineInputBorder(

                        borderSide: new BorderSide(color: Color(0xff88c1ce), width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,

                  ),
                ],
              ),
            )
        ),
      );
    }

    Widget Password(){
      return Theme(
        data: ThemeData(
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
          hintColor: Colors.white,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.white)
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: new TextFormField(
            onChanged: (text){
              _passwordId = text;
            },
            decoration: new InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                fillColor: Colors.white,
                border: new OutlineInputBorder(

                  borderSide: new BorderSide(),
                ),
                enabledBorder: new OutlineInputBorder(

                  borderSide: new BorderSide(color: Colors.white, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: (){
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                )
            ),
            validator: (val){
              if(val.length == 0){
                return "Password cannot be empty";
              }else{
                return null;
              }
            },
            keyboardType: TextInputType.text,
            obscureText: passwordVisible,

          ),
        ),
      );
    }

    Widget ConfirmPassword(){

      return Theme(
        data: ThemeData(
          primaryColorDark: Colors.white,
          primaryColor: Colors.white,
          hintColor: Colors.white,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.white)
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: new TextFormField(
            onChanged: (text){
              _confirmpasswordId = text;
            },
            decoration: new InputDecoration(
                labelText: "Confirm Password",
                hintText: "Confirm your password",
                fillColor: Colors.white,
                border: new OutlineInputBorder(

                  borderSide: new BorderSide(),
                ),
                enabledBorder: new OutlineInputBorder(

                  borderSide: new BorderSide(color: Colors.white, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    confirmpasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: (){
                    setState(() {
                      confirmpasswordVisible = !confirmpasswordVisible;
                    });
                  },
                )
            ),
            validator: (val){
              if(val.length == 0){
                return "Password cannot be empty";
              }else{
                return null;
              }
            },
            keyboardType: TextInputType.text,
            obscureText: confirmpasswordVisible,
          ),
        ),
      );
    }


    Widget SignUpButton(){
      return Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 20),
        child: Center(
          child: Container(
            width: 250,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                const BorderRadius.all(Radius.circular(25.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(4, 4),
                      blurRadius: 8.0
                  )
                ]
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){
                  move_home();
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16.0
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }


    Widget ConvertSignIn(){
      return Container(
        margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "Already have an account? ",
              style: TextStyle(color: Colors.white),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: Center(
                child: Text(
                    'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 70.0,),
                      Logo(),
                      SizedBox(height: 50.0,),
                      FirstName(),
                      LastName(),
                      Email(),
                      SignUpButton(),

                    ],
                  ),
                ),
              ),

              Positioned(
                child: isLoading
                    ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                    ),
                  ),
                )
                    : Container(),
              )
            ],
          )
      ),
    );
  }

  void move_home(){

    if(_firstname != null){
      Profile.firstName = _firstname;
    }else{
      showAlertDialog(context, "Please input your first name.");
      return;
    }

    if(_lastname != null){
      Profile.lastName = _lastname;
    }else{
      showAlertDialog(context, "Please input your last name.");
      return;
    }

    if(_emailId != null){
      Profile.email = _emailId;
    }else{
      showAlertDialog(context, "Please input your email.");
      return;
    }

    if(!emailValid){
      showAlertDialog(context, "Please input correct email.");
      return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabHome()));
  }

  void showAlertDialog(BuildContext context, String content){
    showDialog(
        context: context,
        child: CupertinoAlertDialog(
          title: Text('Alert'),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
        )
    );
  }

}
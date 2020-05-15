import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumina/Sign/signup.dart';


class SignInPage extends StatefulWidget{
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage>{


  String _emailId;
  String _passwordId;
  bool emailValid;

  bool passwordVisible;
  bool isLoading = false;

  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget Logo(){
      return Container(
        height: 70,
        width: 150,
        child: ClipRRect(
          child: Image.asset('assets/images/logo.png'),
        ),
      );
    }


    Widget Email(){
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: new Form(
            child: Column(
              children: <Widget>[
                Theme(
                  data: ThemeData(
                    primaryColor: Colors.white,
                    primaryColorDark: Colors.white,
                    hintColor: Colors.white,
                      textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white))
                  ),
                  child: TextFormField(
                    onChanged: (text){
                      _emailId = text;
                      emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailId);
                    },
                    decoration: new InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your Email",
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                      ),
                      enabledBorder: new OutlineInputBorder(

                        borderSide: new BorderSide(color: Colors.white, width: 2.0),
                      ),

                    ),
                    keyboardType: TextInputType.emailAddress,

                  ),
                )
              ],
            ),
          )
      );
    }

    Widget Password(){
      return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Theme(
          data: ThemeData(
            primaryColor: Colors.white,
            primaryColorDark: Colors.white,
            hintColor: Colors.white,
            textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white))
          ),
          child: new TextFormField(
            onChanged: (text){
              _passwordId = text;
            },
            decoration: new InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                fillColor: Colors.white,
                enabledBorder: new OutlineInputBorder(

                  borderSide: new BorderSide(color: Colors.white, width: 2.0),
                ),
                border: new OutlineInputBorder(

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
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        )
      );
    }

    Widget SignInButton(){
      return Padding(
        padding: const EdgeInsets.only(top: 16),
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

                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Sign In',
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

    Widget forgotPassword(){
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Container(
          width: 200,
          child: InkWell(
            onTap: (){

            },
            child: Center(
              child: Text(
                'Forgot password?',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            ),
          ),
        )
      );
    }


    Widget ConvertSignup(){
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Don't have an account? ",
              style: TextStyle(color: Colors.white),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Center(
                child: Text(
                  'Sign Up',
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

    return Scaffold(
        backgroundColor: Colors.green,
        body: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 80.0,),
                    Logo(),
                    SizedBox(height: 90.0,),
                    Email(),
                    Password(),
                    SizedBox(height: 30.0,),
                    SignInButton(),
                    forgotPassword(),
                    SizedBox(height: 20.0,),
                    ConvertSignup(),
                    SizedBox(height: 20.0,)

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
    );
  }


}
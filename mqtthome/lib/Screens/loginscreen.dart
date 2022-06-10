import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtthome/Screens/registerscreen.dart';
import 'package:mqtthome/widgets/curved_widget.dart';
import 'package:mqtthome/widgets/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'AuthenticationHelper.dart';
import 'Home.dart';



class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final _formkey=GlobalKey<FormState>();
   String email="yuv",password="";
  String emailip="",passwordip="";
  final auth = FirebaseAuth.instance;
  bool isLoading = false;


  @override
  void initState()  {
    super.initState();
  }



  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CurvedWidget(
                child: Container(
                width:(MediaQuery.of(context).size.width),
                height: 400,
                color: Colors.black87,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light1.png')
                            )
                        ),
                      ),
                    ),
                    Positioned(
                      left: 100,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light2.png')
                            )
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ]
                ),
              ),
            ),
              Container(
                child:SingleChildScrollView(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: "Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autovalidate: true,
                          autocorrect: false,
                          validator: (email) {
                            if (isEmailValid(email)) return null;
                            else
                              return 'Enter a valid email address';
                          },
                          onSaved: (emailip) => email = emailip!,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: "Password",
                          ),
                          validator: (input) {
                          if (input!.length < 6)
                          return 'Provide Minimum 6 Character';
                          },
                          obscureText: true,
                          autovalidate: true,
                          autocorrect: false,
                          onSaved: (input) => password = input!,
                        ),

                        SizedBox(
                          height: 40,

                        ),

                      GradientButton(
                          width: 150,
                          height: 45,

                        onPressed: ()=>logincode(),
                          text: Text(
                            'LogIn',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                          ),
                          icon: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                   // ),
                        Container(
                          margin:const EdgeInsets.only(top: 50, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                               SelectableText(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Roboto',
                                  letterSpacing: 0.5,
                                  fontSize: 20,
                                ),
                                onTap:()=> navigateToSignUp(),

                              ),
                              SizedBox(width: 5),

                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/submitbtn.png')
                                    )
                                ),

                              ),
                        ],
                      ),

                    ),
                  ],
                    ),
                  ),
                ),
              )
          ]),
        )
      ),
    );
  }

  bool isEmailValid(String? email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email!);
  }


 void logincode(){
   AuthenticationHelper()
       .signIn(email: emailController.text, password: passwordController.text)
       .then((result) {
     if (result == null) {
       Navigator.pushReplacement(context,
           MaterialPageRoute(builder: (context) => Home()));
     } else {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text(
           result,
           style: TextStyle(fontSize: 16),
         ),
       ));
     }
   });
 }


}

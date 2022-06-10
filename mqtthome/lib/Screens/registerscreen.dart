
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtthome/widgets/curved_widget.dart';
import 'package:mqtthome/widgets/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'AuthenticationHelper.dart';
import 'Home.dart';


class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register>{

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController_register = TextEditingController();
  TextEditingController nameController_register = TextEditingController();
  TextEditingController passwordController_register = TextEditingController();


  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child:SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                                  child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: nameController_register,
                              decoration: InputDecoration(
                                icon: Icon(Icons.supervised_user_circle_rounded),
                                labelText: "Username",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter User Name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: emailController_register,
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: "Email",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter an Email Address';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: passwordController_register,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: "Password",
                              ),
                              obscureText: true,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password must be atleast 6 characters!';
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 40,

                            ),

                            GradientButton(
                              width: 150,
                              height: 45,
                              onPressed: ()=>registerCode(),
                              text: Text(
                                'Sign Up',
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
                      //),

                          ],
                        ),
                      ),
                    ),

                ]),
          ),
          )
      ),
    );
  }


  void registerCode(){
    AuthenticationHelper()
        .signUp(email: emailController_register.text, password: passwordController_register.text)
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
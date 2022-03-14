import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  // String _userId;
  // String _password;
  // String _email;
  // String _message;

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Auth")),
      body:Container(
        padding:const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(child: Column(children: [
            emailInput(),
            passwordInput(),
            mainButton(),
            secondaryButton(),
            validationMessage()
          ]),)
        ),
      )
    );
  }

  Widget emailInput(){
    return Padding(
      padding: const EdgeInsets.only(top:120),
      child: TextFormField(
        controller: txtEmail,
        keyboardType: TextInputType.emailAddress,
        decoration:const InputDecoration(
          hintText: "Email",
          icon: Icon(Icons.mail)
        ),
        validator: (text)=>text!.isEmpty ? "El email es requerido" : "",
      ),
    );
  }

  Widget passwordInput(){
    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: TextFormField(
        controller: txtPassword,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(Icons.lock)
        ),
        validator: (text)=>text!.isEmpty ? "La contraseña es requerida" : "",
      ),
    );
  }

  Widget mainButton(){
    String buttonText = _isLogin ? "Login" : "Sign up";
    return Padding(
      padding:const EdgeInsets.only(top: 20),
      child: Container(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            elevation: 3
          ),
          child: Text(buttonText),
          onPressed: (){

          },
        ),
      ),
    );
  }
  Widget secondaryButton(){
    String buttonText = _isLogin ? "Create an account" : "Access with your account";
    return TextButton(
      onPressed: (){
        setState(() {
          _isLogin = !_isLogin;
        });
      }, 
      child: Text(buttonText)
    );
  }

  Widget validationMessage(){
    return Text("Error",
      style: const TextStyle(
        fontSize: 14,
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
    );
  }
  
}
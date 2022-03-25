import 'package:flutter/material.dart';
import 'package:maps/screens/map.dart';
import '../shared/authentication.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  late String? _userId;
  late String _password;
  late String _email;
  String _message = "";

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  late Authentication authentication;

  @override
  void initState() {
    authentication = Authentication();
    super.initState();
  }

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
        child: Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              elevation: 3,
            ),
            child: Text(buttonText),
            onPressed: submit,
          ),
        )
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
    return Text(_message,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Future submit() async{
    setState(() {
      _message = "";
    });

    try{
      if(_isLogin){
        _userId = await authentication.login(txtEmail.text, txtPassword.text);
        print("Login for user $_userId");
      }else{
        _userId = await authentication.signUp(txtEmail.text, txtPassword.text);
        print("Sign up for user $_userId");
      }

      if(_userId!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainMap()));
      }
    }catch(error){
      print("Error $error");
      setState(() {
        _message = error.toString();
      });
    }
  }
  
}
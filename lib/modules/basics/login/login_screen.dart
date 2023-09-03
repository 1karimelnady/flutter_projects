import 'package:flutter/material.dart';
import 'package:flutter_project/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool ispassword = false;
  bool obscureText = true;
  IconData iconhidden = Icons.visibility;
  IconData iconvisible = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Email not be empty";
                        }
                      },
                      textEditingController: emailcontroller,
                      textInputType: TextInputType.emailAddress,
                      label: "Password",
                      perfix: Icons.email),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Password not be empty";
                        }
                      },
                      ispassword: true,
                      suffix: ispassword ? Icons.visibility : Icons.visibility,
                      suffixpressed: () {
                        setState(() {
                          ispassword = !ispassword;
                        });
                      },
                      textEditingController: passwordcontroller,
                      textInputType: TextInputType.visiblePassword,
                      label: "Password",
                      perfix: Icons.email),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultbutton(
                      function: () {
                        if (formkey.currentState!.validate()) {
                          print(emailcontroller.text);
                          print(passwordcontroller.text);
                        }
                      },
                      text: "LOGIIN"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\`t have an account? '),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

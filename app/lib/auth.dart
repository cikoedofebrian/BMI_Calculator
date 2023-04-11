import 'package:app/user_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var username = '';
  var password = '';
  List<User> accountList = [];

  bool isRegister = false;
  void toRegister() {
    setState(() {
      isRegister = !isRegister;
    });
  }

  void login() {
    if (accountList.any(
        (user) => user.username == username && user.password == password)) {
      Navigator.pushReplacementNamed(context, '/home', arguments: username);
    } else {
      customDialog("Account does not found");
    }
  }

  void register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (accountList.any((user) => user.username == username)) {
        customDialog("Username already exist");
      } else {
        accountList.add(User(password: password, username: username));
        _formKey.currentState!.reset();
        customDialog("Create account success").then((value) => toRegister());
      }
    }
  }

  Future<dynamic> customDialog(String text) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 30,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isRegister ? 'Register' : 'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Username',
                          ),
                          margin: EdgeInsets.all(8),
                        ),
                        TextFormField(
                          onSaved: (newValue) => username = newValue!,
                          style: TextStyle(fontSize: 14),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username can't be empty";
                            } else if (value.length < 8 || value.length > 15) {
                              return "A Username have minimum and maximum length of 8 and 15";
                            }
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: "Username",
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            suffixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: const Text(
                            'Password',
                          ),
                          margin: EdgeInsets.all(8),
                        ),
                        TextFormField(
                          obscureText: true,
                          onSaved: (newValue) => password = newValue!,
                          style: TextStyle(fontSize: 14),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password can't be empty";
                            } else if (value.length < 8 || value.length > 15) {
                              return "A Username have minimum and maximum length of 8 and 15";
                            }
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            suffixIcon: Icon(Icons.password),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: isRegister ? register : login,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                isRegister ? 'REGISTER' : 'LOGIN',
                                style: TextStyle(
                                    letterSpacing: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isRegister
                                  ? 'Already have an account?'
                                  : 'Does not have an account?',
                              style: TextStyle(fontSize: 14),
                            ),
                            InkWell(
                              onTap: () => toRegister(),
                              child: Text(
                                isRegister ? 'Sign in' : 'Create account',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

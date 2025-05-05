import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/homepage/home.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/login/login_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/appbtn.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/cmn_textfild_widget.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/snackbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

LoginProvider? loginProvider;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  bool isShowPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/konarklogo.png', width: 180, height: 180),
            CommonTextFormField(
              hintText: 'Email',
              controller: loginProvider!.emailController,
            ),
            SizedBox(height: 15),
            CommonTextFormField(
              hintText: 'Password',
              controller: loginProvider!.passwordController,
              obscureText: !isShowPass,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isShowPass = !isShowPass;
                  });
                },
                child: Icon(
                  isShowPass ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            SizedBox(height: 15),
            AppButton(
              height: MediaQuery.of(context).size.height * 0.06,
              btnText: 'Login',
              textSize: 16,
              voidCallBack: () async {
                if (loginProvider!.emailController.text.isEmpty) {
                  setSnackbar("Please Enter Email", context, 2);
                  return;
                } else if (!loginProvider!.emailController.text.contains('@') ||
                    !loginProvider!.emailController.text.contains('.')) {
                  setSnackbar("Please Enter Valid Email", context, 2);
                  return;
                } else if (loginProvider!.passwordController.text.isEmpty) {
                  setSnackbar("Please Enter Password", context, 2);
                  return;
                }
                await loginProvider!.loginUser(context).then((value) {
                  if (value == 'true') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }else if(value == 'false'){
                    setSnackbar("Something went wrong", context, 2);
                  }else {
                    setSnackbar(value, context, 2);}
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

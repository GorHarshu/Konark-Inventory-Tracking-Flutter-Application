import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/homepage/home.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/login/login_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/appbtn.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/circular_desing.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/cmn_textfild_widget.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/genrateTxt.dart';
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  CMNTextInter(
                    text: "Konark",
                    color: Color(0xfffFFFFFF),
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  CommonTextFormField(
                    hintText: 'Enter User Email',
                    controller: loginProvider!.emailController,
                  ),
                  SizedBox(height: 15),
                  CommonTextFormField(
                    hintText: 'Enter Password',
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
                        color: Color(0xfffFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CMNTextInter(
                      text: "Forgot Password?",
                      color: Color(0xfffFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),

                  AppButton(
                    height: MediaQuery.of(context).size.height * 0.06,
                    borderRadius: 16,
                    btnText: 'Login',
                    textSize: 16,
                    voidCallBack: () async {
                      if (loginProvider!.emailController.text.isEmpty) {
                        setSnackbar("Please Enter Email", context, 2);
                        return;
                      } else if (!loginProvider!.emailController.text.contains(
                            '@',
                          ) ||
                          !loginProvider!.emailController.text.contains('.')) {
                        setSnackbar("Please Enter Valid Email", context, 2);
                        return;
                      } else if (loginProvider!
                          .passwordController
                          .text
                          .isEmpty) {
                        setSnackbar("Please Enter Password", context, 2);
                        return;
                      }
                      loginProvider!.isAPICalling = true;
                      setState(() {});
                      await loginProvider!.loginUser(context).then((value) {
                        loginProvider!.isAPICalling = false;
                        setState(() {});
                        if (value == 'true') {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        } else if (value == 'false') {
                          setSnackbar("Something went wrong", context, 2);
                          return;
                        } else {
                          setSnackbar(value, context, 2);
                          return;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          loginProvider!.isAPICalling
              ? getCircularDesingScreen(context)
              : Container(),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/api.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/hive_localstorage.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/snackbar.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  initAllVars() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<String> loginUser(BuildContext context) async {
    print('executed the login user');
    Map<String, String> bodyParms = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      var response = await post(
        Uri.parse('$finalUrl/login'),
        body: json.encode(bodyParms),
        headers: Auth.commonHeader,
      );

      print('auth cmnHeader${Auth.commonHeader}');
      var data = jsonDecode(response.body.toString());

      print(data);

      if (response.statusCode == 200) {
        print('if executed');
        Auth.accestoken = data['token'];

        Auth.userID = data['id'].toString();
        Auth.name = data['name'].toString();
        Auth.email = data['email'].toString();
        Auth.whatsappNumber = data['whatsapp_number'].toString();
        Auth.empCode = data['employee_code'].toString();
        Auth.roleId = data['role']['id'].toString();
        Auth.role = data['role']['name'].toString();

        print("Auth.accestoken${Auth.accestoken}");
        print("Auth.userID${Auth.userID}");
        print("Auth.name${Auth.name}");
        print("Auth.email${Auth.email}");
        print("Auth.whatsappNumber${Auth.whatsappNumber}");
        print("Auth.empCode${Auth.empCode}");
        print("Auth.roleId${Auth.roleId}");
        print("Auth.role${Auth.role}");

        Auth.commonHeader = {
          'Authorization': 'Bearer ${Auth.accestoken}',
          'Accept': 'application/json',
          "Content-Type": "application/json",
          'origin': 'https://mobile.aeonxus.digital',
          "Connection": "application/json",
        };
        await storeUserData(
          Auth.userID!,
          Auth.name!,
          Auth.email!,
          passwordController.text,
          Auth.accestoken!,
          Auth.whatsappNumber!,
          Auth.empCode!,
          Auth.role!,
          Auth.roleId!,
        );

        return 'true';
      } else {
        print('else executed');
        if (response.statusCode != 200) {
          return data;
        } else {
          return 'false';
        }
      }
    } catch (e) {
      print('catch executed');
      setSnackbar(e.toString(), context, 2);
      return 'false';
    }
  }
}

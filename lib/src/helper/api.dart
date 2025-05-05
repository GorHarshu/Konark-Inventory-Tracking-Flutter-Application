//dev url
const String baseUrl = "https://dev-api.konark.aeonx.digital";
//prd url
// const String baseUrl = "https://api.konark.aeonx.digital";

const String subUrl = '/api';
const String finalUrl = '$baseUrl$subUrl';

class Auth {
  static String? userID;
  static String? name;
  static String? email;
  static String? password;
  static String? accestoken;
  static String? whatsappNumber;
  static String? empCode;
  static String? role;
  static String? roleId;

  static Map<String, String>? commonHeader = {
    'Authorization': 'Bearer ${Auth.accestoken}',
    'Accept': 'application/json',
    "Content-Type": "application/json",
    "Connection": "application/json",
  };
}

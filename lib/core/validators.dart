class Validators {

  static String? validateEmail(String value){
    if(value.isEmpty) return "Email cannot be empty";

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if(!regex.hasMatch(value))return "Invalid email format";
    return null;
  }

  static String? validatePassword(String value){
    if(value.isEmpty)return "Password cannot be empty";
    if(value.length < 6)return "Password must be atleast 6 characters";
    return null;
  }

  static String? validateName(String value){
    if(value.isEmpty)return "Name cannot be empty";
    return null;
  } 
}

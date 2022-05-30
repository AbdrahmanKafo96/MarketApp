 import 'dart:core';


class UserModel {
  String _username, _password, _userState, _userEmail, _city, _country;
  int _phoneNumber;

  UserModel(this._username, this._password, this._userState, this._userEmail,
      this._city, this._country, this._phoneNumber);

  int get getPhoneNumber => _phoneNumber;

  set phoneNumber(int value) {
    _phoneNumber = value;
  }

  get country => _country;

  set country(value) {
    _country = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get userEmail => _userEmail;

  set userEmail(value) {
    _userEmail = value;
  }

  get userState => _userState;

  set userState(value) {
    _userState = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  String get username => _username;

  set setUsername(String value) {
    _username = value;
  }

   static String isValidPassword(String password) {
    String isValid = "",
        upperCaseChars = "(.*[A-Z].*)",
        lowerCaseChars = "(.*[a-z].*)",
        numbers = "(.*[0-9].*)",
        specialChars = "(.*[@,#,\$,%,.].*\$)";

    if (password.length > 15 || password.length < 8)
      isValid =
          "يجب أن يكون طول كلمة المرور أقل من 20 وأكثر من 8 خانات ";
    else if (!RegExp(upperCaseChars).hasMatch(password))
      isValid = "يجب أن تحتوي كلمة المرور على حرف واحد كبير على الأقل";
    else if (!RegExp(lowerCaseChars).hasMatch(password))
      isValid = "يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل";
    else if (!RegExp(numbers).hasMatch(password))
      isValid = "يجب أن تحتوي كلمة المرور على رقم واحد على الأقل";
    else if (!RegExp(specialChars).hasMatch(password))
      isValid = "يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل مثال:النقطة";
    else
      isValid = "";
    return isValid;
  }



}

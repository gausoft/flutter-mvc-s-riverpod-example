class FormValidator {
  static String? validateProductLink(String? value) {
    String urlPatttern = r'((http|https)://)(www.)?[a-zA-Z0-9@:%._\\+~#?&//=]'
        '{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%._\\+~#?&//=]*)';
    RegExp regExp = RegExp(urlPatttern);

    if (value!.isEmpty) {
      return 'Please enter the product link';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid product link';
    }

    return null;
  }

  static String? validateProductName(String? value) {
    return value!.isEmpty ? 'Please enter the product name' : null;
  }

  static String? validateProductDescription(String? value) {
    return value!.isEmpty ? 'Please enter the product description' : null;
  }

  static String? validateProductQuantity(String? value) {
    return value!.isEmpty ? 'Please enter product quantity' : null;
  }

  //Authentication
  static String? validateEmail(String? value) {
    String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailPattern);

    if (value!.isEmpty) {
      return 'Please enter your email address';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    return value!.isEmpty ? 'Please enter your password' : null;
  }

  static String? validateFullName(String? value) {
    return value!.isEmpty ? 'Please enter your fullname' : null;
  }

  //validatePasswordConfirmation
  static String? validatePasswordConfirmation(String? value, String password) {
    if (value!.isEmpty) {
      return 'Please enter your password confirmation';
    } else if (value != password) {
      return 'Password confirmation does not match';
    }
    return null;
  }
}

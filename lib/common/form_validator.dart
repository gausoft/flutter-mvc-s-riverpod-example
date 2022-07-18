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
}

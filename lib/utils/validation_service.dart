class ValidationService {
  static String? validateInputIsEmpty(String value) {
    if (value.isEmpty) {
      return 'Please enter some value';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}

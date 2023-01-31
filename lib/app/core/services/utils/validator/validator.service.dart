class ValidatorService {
  static bool isEmailValid(String value) {
    String pattern =
        r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$';
    RegExp regex = RegExp(pattern);

    if (regex.hasMatch(value)) {
      return true;
    }
    return false;
  }
}

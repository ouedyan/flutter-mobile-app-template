validateOperation(dynamic value, String errorMessage,
    {int minCharacterCount = 0}) {
  if (value == null || value.isEmpty || value.length < minCharacterCount) {
    return errorMessage;
  }
  return null;
}

emailValidateOperation(dynamic email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  if (email == null || email.isEmpty || !emailValid) {
    return "Please enter a valid e-mail address!";
  }
  return null;
}

checkUserNameValidation(bool value) {
  if (!value) {
    return "*This username is already in use";
  }
  return null;
}

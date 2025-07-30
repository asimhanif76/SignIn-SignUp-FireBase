class EmailPasswordValidators {
 static String? validateEmail(String? email){
  final emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  if (email!.isEmpty) {
    return 'Email is required';
  } else if (!emailRegExp.hasMatch(email)) {
    return 'Enter a valid email address';
  }
  return null;

}

static String? validatePassword(String? password) {
  final passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
  );

  if (password == null || password.isEmpty) {
    return 'Password is required';
  } else if (!passwordRegExp.hasMatch(password)) {
    return 'Password must be at least 8 characters,\ninclude upper & lower case, number, and special character';
  }
  return null;
}

static String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username is required';
  } else if (value.length < 3) {
    return 'Username must be at least 3 characters';
  } else if (value.length > 20) {
    return 'Username must not exceed 20 characters';
  } else if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(value)) {
    return 'Only letters, numbers, dot and underscore allowed';
  }
  return null;
}


}
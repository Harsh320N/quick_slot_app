class AppFieldValidation {
  static String validateEmail(String email) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (email.isEmpty) {
      return "Email is Required";
    } else if (!regex.hasMatch(email)) {
      return "Enter Valid Email";
    } else {
      return "";
    }
  }

  static String validateMobileNumber(String mobile) {
    String pattern = r'^[0-9]*$';
    RegExp regex = RegExp(pattern);
    if (mobile.isEmpty) {
      return "Mobile Number is Required";
    } else if (mobile.length < 10 ||
        mobile.length > 10 ||
        !regex.hasMatch(mobile)) {
      return "Enter Valid Mobile Number";
    } else {
      return "";
    }
  }

  static String validateBirthDate(String birthDate) {
    RegExp dateRegExp =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');
    if (!dateRegExp.hasMatch(birthDate)) {
      return 'Invalid date format';
    }

    final parts = birthDate.split('/');
    if (parts.length != 3) {
      return 'Invalid date';
    }

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return 'Invalid date';
    }

    final currentDate = DateTime.now();
    final enteredDate = DateTime(year, month, day);

    if (enteredDate.isAfter(currentDate)) {
      return 'Future date is not allowed';
    }

    if (enteredDate.isBefore(DateTime(1000, 1, 1))) {
      return 'Date is too far in the past';
    }

    if (day < 1 || day > 31 || month < 1 || month > 12) {
      return 'Invalid date';
    }

    if (day > 28 && month == 2) {
      // Check for February and handle leap years
      if (!((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))) {
        return 'Invalid date';
      }
    }

    if (day > 30 && (month == 4 || month == 6 || month == 9 || month == 11)) {
      return 'Invalid date';
    }

    return "";
  }

  static String validatePinCode(String mobile) {
    String pattern = r'^[0-9]*$';
    RegExp regex = RegExp(pattern);
    if (mobile.isEmpty) {
      return "Pin Code is Required";
    } else if (mobile.length < 6 ||
        mobile.length > 6 ||
        !regex.hasMatch(mobile)) {
      return "Enter Valid Pin Code";
    } else {
      return "";
    }
  }
}

class AuthValidators {
  AuthValidators._();

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your name';
    if (value.trim().length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your phone number';
    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');
    if (!RegExp(r'^(03\d{9}|3\d{9})$').hasMatch(cleaned)) {
      return 'Enter a valid Pakistani number (03XX-XXXXXXX)';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!value.contains(RegExp(r'[0-9]'))) return 'Include at least one number';
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }
}
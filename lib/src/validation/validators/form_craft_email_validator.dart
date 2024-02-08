part of 'form_craft_validator.dart';

/// A validator implementation for validating email addresses.
///
/// The [validate] method checks if the email is not empty and follows a valid email format.
/// Returns an error message if validation fails, otherwise returns `null`.
class FormCraftEmailValidator implements FormCraftValidator {
  /// The error message to be displayed when the validation fails.
  final String message;

  /// Constructs a [FormCraftEmailValidator] with the specified error [message].
  const FormCraftEmailValidator([
    this.message = 'Email is not valid',
  ]);

  @override
  String? validate(String input) {
    final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(input);

    return emailValid ? null : message;
  }
}

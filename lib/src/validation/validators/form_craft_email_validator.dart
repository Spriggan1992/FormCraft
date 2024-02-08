import 'package:form_craft/src/validation/validators/form_craft_field_validator.dart';

/// A validator implementation for validating email addresses.
///
/// The [validate] method checks if the email is not empty and follows a valid email format.
/// Returns an error message if validation fails, otherwise returns `null`.
final class FormCraftEmailValidator extends FormCraftFieldValidator {
  final String message = 'Email is not valid';

  @override
  String? validate(String? input) {
    final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(input!);

    return emailValid ? null : message;
  }
}

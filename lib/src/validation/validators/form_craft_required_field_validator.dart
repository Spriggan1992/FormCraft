part of 'form_craft_validator.dart';

/// A validator implementation for ensuring a field is not empty.
///
/// The [validate] method checks if the input is empty and returns an error message if true.
/// Returns `null` if the input is not empty.
final class FormCraftRequiredFieldValidator implements FormCraftValidator {
  /// The error message to be displayed when the validation fails.
  final String message;

  /// Constructs a [FormCraftRequiredFieldValidator] with the specified error [message].
  const FormCraftRequiredFieldValidator([this.message = 'Required field']);

  @override
  String? validate(String input) {
    return input.isEmpty ? message : null;
  }
}

import 'form_craft_field_validator.dart';

/// A validator implementation for ensuring a field is not empty.
///
/// The [validate] method checks if the input is empty and returns an error message if true.
/// Returns `null` if the input is not empty.
final class RequiredFieldValidator extends FormCraftFieldValidator {
  final String message = 'Required field';

  @override
  String? validate(String? input) {
    return input?.isEmpty ?? true ? message : null;
  }
}

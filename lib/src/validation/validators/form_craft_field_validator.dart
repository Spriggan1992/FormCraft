/// An abstract class for defining form field validators in the FormCraft framework.
///
/// Extend this class to create custom validators for your form fields.
/// The [validate] method should return an error message if validation fails,
abstract class FormCraftFieldValidator {
  /// Validates the given input and returns an error message if validation fails.
  /// Returns `null` if the input is valid.
  String? validate(String? input);
}

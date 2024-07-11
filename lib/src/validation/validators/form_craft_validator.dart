part 'form_craft_custom_validator.dart';
part 'form_craft_email_validator.dart';
part 'form_craft_required_field_validator.dart';

/// An abstract class for defining form field validators in the FormCraft framework.
///
/// Extend this class to create custom validators for your form fields.
/// The [validate] method should return an error message if validation fails,
class FormCraftValidator {
  const FormCraftValidator();

  /// Validates the given input and returns an error message if validation fails.
  /// Returns `null` if the input is valid.
  String? validate(String input);

  /// A validator for ensuring a field is not empty.
  ///
  /// The [validate] method checks if the input is empty and returns an error message if true (or the default message).
  const factory FormCraftValidator.required([String message]) =
      FormCraftRequiredFieldValidator;

  /// A validator for validating email addresses.
  ///
  /// The [validate] method checks if the email is not empty and follows a valid email format (or the default message).
  const factory FormCraftValidator.email([String message]) =
      FormCraftEmailValidator;

  /// A custom validator for use with the FormCraft form validation framework.
  ///
  /// This class extends [FormCraftValidator] and allows the definition of a custom validation rule
  /// based on a provided predicate function.
  /// The [validate] method should return an error message if validation fails, otherwise returns `null`.
  const factory FormCraftValidator.custom({
    required String message,
    required bool Function(String? input) predicate,
  }) = FormCraftCustomValidator;
}

part of 'form_craft_validator.dart';

/// A custom validator for use with the FormCraft form validation framework.
///
/// This class extends [FormCraftValidator] and allows the definition of a custom validation rule
/// based on a provided predicate function.
class FormCraftCustomValidator implements FormCraftValidator {
  // The error message to be displayed when the validation fails.
  final String message;

  // The predicate function defining the custom validation rule.
  final bool Function(String? input) predicate;

  /// Constructs a [FormCraftCustomValidator] with the specified error [message] and [predicate] function.
  ///
  /// The [message] parameter is the error message to be displayed when the validation fails.
  /// The [predicate] parameter is a function that takes an input value and returns a boolean indicating
  /// whether the input passes the custom validation rule.
  const FormCraftCustomValidator({
    required this.message,
    required this.predicate,
  });

  /// Validates the provided [input] using the custom validation rule.
  ///
  /// The [input] parameter is the value to be validated.
  /// Returns the error message if the validation fails, otherwise returns null.
  @override
  String? validate(String input) {
    // Use the predicate function to determine if the input passes the custom validation rule.
    // If the predicate returns true, the validation is considered successful, and null is returned.
    // Otherwise, the error message is returned.
    return predicate(input) ? null : message;
  }
}

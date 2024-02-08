part of '../form_craft.dart';

/// A class that provides a set of utility methods for managing and interacting with a collection of FormCraftTextField widgets.
base class FormCraftFieldManager {
  /// Map of field keys to corresponding FormCraftTextField widgets.
  Map<String, Widget> get fields => _fields;

  /// Internal map to store FormCraftTextField widgets using their keys.
  final Map<String, Widget> _fields = {};

  /// Map of field keys to their associated global keys for state management.
  final Map<String, GlobalKey<FormCraftTextFieldState>> globalKeys = {};

  FormCraftFieldManager();

  /// Adds a FormCraftTextField widget to the internal map using the specified key.
  ///
  /// The reason to make this method public only for testing purposes.
  void addGlobalKey(String key, GlobalKey<FormCraftTextFieldState> globalKey) {
    globalKeys[key] = globalKey;
  }

  /// Builds a FormCraftTextField widget with the specified key and configuration.
  ///
  /// If a field with the given key already exists, it returns the existing widget to avoid duplicates.
  ///
  /// The [key] parameter is required and must be unique.
  /// The [textField] parameter is required and must be a function that returns a FormCraftTextField widget.
  ///
  /// Returns the created or existing FormCraftTextField widget.
  Widget buildTextField(
    String key,
    Widget Function(
      GlobalKey<FormCraftTextFieldState> globalKey,
    ) textField,
  ) {
    if (fields.keys.contains(key)) {
      return _fields[key]!;
    }

    // Create a new global key for state management
    final globalKey = GlobalKey<FormCraftTextFieldState>();

    // Create the FormCraftTextField widget using the provided function
    var textFieldWidget = textField(globalKey);

    // Add the new widget to the internal map
    _fields[key] = textFieldWidget;

    // Add the new global key to the map for state management
    globalKeys[key] = globalKey;

    // Return the created FormCraftTextField widget
    return textFieldWidget;
  }

  /// Reassigns the input value for a specific field.
  ///
  /// The [key] parameter is required and must be the key of an existing field.
  /// The [value] parameter is required and must be a string.
  /// Updates the input value of the FormCraftTextField associated with the specified key.
  void reassignInputValue(String key, String value) {
    _checkIfKeyExist(key);

    // Call the private method to reassign the input value for the specified field
    globalKeys[key]!.currentState!._reassignInput(value);
  }

  /// Gets [FocusNode] for a specific field.
  ///
  /// The [key] parameter is required and must be the key of an existing field.
  FocusNode getFocusNode(String key) {
    _checkIfKeyExist(key);

    return globalKeys[key]!.currentState!._focusNode;
  }

  /// Submits the values of all FormCraftTextField widgets.
  ///
  /// Returns a map of field keys to their corresponding input values.
  Map<String, String> submitForm() {
    // Map to store the submitted values of each field
    final items = <String, String>{};

    // Iterate through each field and get its input value
    globalKeys.forEach((key, globalKey) {
      items.addAll(
        {key: globalKey.currentState?._getInputValue() ?? ''},
      );
    });

    // Return the map of field keys and their input values
    return items;
  }

  /// Refreshes the state of all FormCraftTextField widgets.
  ///
  /// Calls the _refreshForm method for each FormCraftTextField widget, if available.
  void refreshForm() {
    // Iterate through each field and call the private method to refresh its state
    globalKeys.forEach((key, globalKey) {
      globalKey.currentState?._refreshForm();
    });
  }

  /// Sets a custom error message for a specific field.
  ///
  /// The [key] parameter is required and must be the key of an existing field.
  /// The [errorMessage] parameter is the custom error message to be set.
  /// The [isRedrawState] parameter determines whether to redraw the state after setting the error message.
  void setErrorMessage(
    String key,
    String? errorMessage, {
    bool isRedrawState = true,
  }) {
    _checkIfKeyExist(key);

    // Call the private method to assign a custom error message for the specified field
    globalKeys[key]!.currentState!._assignCustomError(
          errorMessage,
          isRedrawState,
        );
  }

  /// Disposes of all resources and clears the field and global key maps.
  void dispose() {
    // Clear the internal maps to release resources
    _fields.clear();
    globalKeys.clear();
  }

  // Checks if a field with the given key exists in the internal map.
  void _checkIfKeyExist(String key) {
    if (!fields.keys.contains(key)) {
      throw 'The key $key does not exist';
    }
  }
}

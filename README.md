<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# FormCraft
The Flutter FormCraft package simplifies form management in Flutter applications, providing a convenient set of utilities for building and interacting with forms.

## Features

- **Form Management**: Easily manage collections of FormCraftTextField widgets within your Flutter app.
- **Validation**: Validate form fields with customizable validation rules and error messages.
- **Field Interaction**: Access, modify, and submit form field values programmatically.
- **Customization**: Customize form field behavior, appearance, and validation rules to suit your application's needs.

## Why Use FormCraft?
FormCraft streamlines form development in Flutter, offering an intuitive API for creating, validating, and interacting with forms. Whether you're building a simple login form or a complex multi-step wizard, FormCraft simplifies form management, reducing boilerplate code and accelerating development.



## Getting started

To start using FormCraft in your Flutter project, simply add the package to your pubspec.yaml file:

```yaml
dependencies:
  form_craft: ^0.0.1
```

## Usage
### 1. FormCraft:
The FormCraft class is a powerful utility in Flutter designed to streamline the management and interaction with form fields. Its primary goal is to simplify the process of building and validating forms within Flutter applications.
- Create FormCraft:
```dart
final formCraft = FormCraft();

/// You can build your text field like this.
///
/// The first parameter is the key of the text field. It is required to validate the form. By using this key you can get the value of the text field and validate it.And also you can find the focus node of the text field.
/// The second parameter is the builder of the text field. You can use it to build your text field.
/// The builder has only one parameter. It is the global key of the text field. You should provide it to the FormCraftTextField.
_formCraft.buildTextField(
  'new_field',
  (globalKey) => CustomFormTextField(
  globalKey: globalKey,
  ...
  ),
),

/// You can get a focus node like this.
final focusNode = _formCraft.getFocusNode('login');
focusNode.requestFocus();

/// FormCraft gives you the ability to reassign the initial value for your text field. Or by this method, you can change the input text value whenever you want.
_formCraft.reassignInputValue('login', 'Initial value for login');

/// You can clear your form like this.
_formCraft.refreshForm();

/// You can set the validation type for your form. By default, it is FormCraftValidationType.onSubmit.
_formCraft.setValidationType(FormCraftValidationType.onSubmit);

```
- FormCraft provide two ways of validation: FormCraftValidationType.onSubmit and FormCraftValidationType.always. By default is FormCraftValidationType.onSubmit.
1) FormCraftValidationType.onSubmit - validate form when you call method:
```dart
/// Return true if form is valid.
final isValid = _formCraft.validate()
```
2) FormCraftValidationType.always - validate form when you start enter input value. Every field will validate separatly.

You can change type of validation by call method:
```dart
_formCraft.setValidationType( FormCraftValidationType.always);
```
**important:  It is necessary to set the validation type after build widgets to apply the changes. Otherwise the validation type will be not applied.
for example you can do it in initState:
```dart
 @override
  void initState() {
    _formCraft = FormCraft();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formCraft.setValidationType(FormCraftValidationType.always);
    });
    super.initState();
  }
```

### 2. TextField:
1. It is obligatory to use FormCraftTextFild when you use with this package:
```dart
FormCraftTextField(...)
```
2. FormCraft provide a method .buildTextField where you need provade FormCraftTextField or your custom text field.(No worries you can create your own text field based on FormCraftTextField)
```dart
 _formCraft.buildTextField(
  'login',
  (globalKey) => FormCraftTextField(
  /// Global key is required for form validation. If you want to use form validation, you should provide global key like this.
  globalKey: globalKey,

  /// The same method as in TextFormField.
  onChanged: (value) {},

  /// Initial value for your text field.
  initialValue: 'Initial value for login',

  /// Here you can specify your custom(for example error message getting from server etc.) error message.
  customErrorMessage: 'Custom error message for login',
              
  validators: [
    /// You can use built-in validators like this.
    FormCraftValidator.required(),
  ],
  /// If you want to create custom decoration for your text field, you can use decorationBuilder.
  /// Don't forget provide `errorMessage` to show error message.
  decorationBuilder: (errorMessage) => InputDecoration(
    labelText: 'Login',
    errorText: errorMessage,
  ),

  /// rest of the part you cn do the same as in the TextFormField.
    ),
  ),
```
3. Of course you can create custom text field: 
```dart
class CustomFormTextField extends StatelessWidget {
  final Function(String value) onChanged;
  final List<FormCraftFieldValidator>? validators;
  final String? initialValue;
  final Key globalKey;
  const CustomFormTextField({
    required this.onChanged,
    required this.globalKey,
    this.validators,
    this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormCraftTextField(
      globalKey: globalKey,
      onChanged: onChanged,
      initialValue: initialValue,
      validators: validators,
      decorationBuilder: (errorMessage) => InputDecoration(
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        errorText: errorMessage,
      ),
    );
  }
}



```

### 3. Validation:
The FormCraft provide predifiend validators [FormCraftValidator]:
- FormCraftValidator.required() - required text field.
- FormCraftValidator.email() - checks if the email is not empty and follows a valid email format
  
```dart
FormCraftTextField(
              ...,
              validators: [
                FormCraftValidator.required(),
              ],
            ),
          ),
```
- If you want to change error message, just pass message as argument:
```dart
FormCraftTextField(
              ...,
              validators: [
                 FormCraftValidator.email('Please enter a valid email address'),
              ],
            ),
          ),
```
- You can create your own custom validator. FormCraft provide two ways:
1. Use FormCraftValidator.custom
```dart
// Create your custom validator
FormCraftValidator.custom(
    message: 'Password to short',
    predicate: (input) => input!.length > 6,
  );

FormCraftTextField(
  ...,
  validators: [
  FormCraftValidator.custom(
  message: 'Password to short',
  predicate: (input) => input!.length > 6,
      );
    ],
  ),
),

```
2. You can create your own validator:
```dart
class CustomValidator implements FormCraftValidator {
  final String message;

  const CustomValidator({
    required this.message,
  });

  @override
  String? validate(String input) {
    /// The input must be longer than 6 characters.
    /// Returns an error message if the validation fails, otherwise returns `null`.
    return input.length > 6 ? null : message;
  }
}

FormCraftTextField(
  ...,
  validators: [CustomValidator()],
  ),
),

```

### 4. Full example:

```dart
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final FormCraft _formCraft;
  @override
  void initState() {
    _formCraft = FormCraft();
    /// You can change validation type like this.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formCraft.setValidationType(FormCraftValidationType.onSubmit);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Do not forget to despose data.
    _formCraft.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _formCraft.buildTextField(
            'login',
            (globalKey) => FormCraftTextField(
              globalKey: globalKey,
              onChanged: (value) {},
              initialValue: 'Initial value for login',
              customErrorMessage: 'Custom error message for login',
              validators: [
                FormCraftValidator.required(),
              ],
              decorationBuilder: (errorMessage) => InputDecoration(
                labelText: 'Login',
                errorText: errorMessage,
              ),
            ),
          ),
          _formCraft.buildTextField(
            'email',
            (globalKey) => FormCraftTextField(
              globalKey: globalKey,
              onChanged: (value) {},
              validators: [
                FormCraftValidator.email('Please enter the correct email format'),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              final isValid = _formCraft.validate();
              if (isValid) {
                final result = _formCraft.submitForm();
                final loginResult = result['login'];
              }
            },
          )
        ],
      ),
    );
  }
}

```

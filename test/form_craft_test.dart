library form_craft_test;

import 'package:flutter/material.dart';
import 'package:flutter_form_craft/src/form_craft.dart';
import 'package:flutter_form_craft/src/validation/validators/form_craft_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormCraft Integration Tests', () {
    testWidgets('Adding Fields', (WidgetTester tester) async {
      final formCraftFieldManager = FormCraftFieldManager(true);
      final formCraft = FormCraft.test(
        formCraftFieldManager,
        FormCraftValidatorManager(formCraftFieldManager),
      );

      const key = 'field_key';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return formCraftFieldManager.buildTextField(
                  key,
                  (controller) => FormCraftTextField(
                    formController: controller,
                    onChanged: (value) {},
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(formCraftFieldManager.controllers.containsKey(key), true);
    });

    testWidgets('Validation - Valid Input', (WidgetTester tester) async {
      final formCraft = FormCraft();
      const key = 'email_field';
      const email = 'test@example.com';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return formCraft.buildTextField(
                  key,
                  (controller) => FormCraftTextField(
                    formController: controller,
                    onChanged: (value) {},
                    validators: const [
                      FormCraftValidator.email(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      formCraft.reassignInputValue(key, email);
      final isValid = formCraft.validate();

      expect(isValid, true);
    });

    testWidgets('Validation - Invalid Input', (WidgetTester tester) async {
      final formCraft = FormCraft();
      const key = 'required_field';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return formCraft.buildTextField(
                  key,
                  (controller) => FormCraftTextField(
                    formController: controller,
                    onChanged: (value) {},
                    validators: const [
                      FormCraftValidator.required(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Field is empty, should fail validation
      final isValid = formCraft.validate();

      expect(isValid, false);
    });

    testWidgets('Input Reassignment', (WidgetTester tester) async {
      final fieldManager = FormCraftFieldManager(true);
      final validatorManager = FormCraftValidatorManager(fieldManager);

      final formCraft = FormCraft.test(fieldManager, validatorManager);

      const key = 'input_field';
      const initialValue = 'initial';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return formCraft.buildTextField(
                  key,
                  (controller) => FormCraftTextField(
                    formController: controller,
                    onChanged: (value) {},
                    initialValue: initialValue,
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Change the input value
      const newValue = 'changed';

      await tester.pump();

      // Verify that the input value has been updated
      final inputFieldFinder =
          find.byKey(fieldManager.controllers[key]!.globalKey);
      expect(inputFieldFinder, findsOneWidget);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(fieldManager.controllers[key]!.globalKey),
        newValue,
      );
      expect(find.text(newValue), findsOneWidget);
    });
  });
}

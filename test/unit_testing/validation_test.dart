import 'package:final_mobile_project/utils/validation_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValidationService, validateInputIsEmpty', () {
    test('Should return "Please enter some value" Value is null', () {
      String input = '';
      const actualResult = 'Please enter some value';

      final expectResult = ValidationService.validateInputIsEmpty(input);

      expect(expectResult, actualResult);
    });

    test('Should return null" Value is "This is input"', () {
      String input = 'This is input';
      const actualResult = null;

      final expectResult = ValidationService.validateInputIsEmpty(input);

      expect(expectResult, actualResult);
    });
  });
  group('ValidationService, validateEmail', () {
    test('Should return "Please enter a valid email address" Value is "example',
        () {
      String input = 'example';
      const actualResult = 'Please enter a valid email address';

      final expectResult = ValidationService.validateEmail(input);

      expect(expectResult, actualResult);
    });

    test(
        'Should return "Please enter a valid email address" Value is "example@',
        () {
      String input = 'example@';
      const actualResult = 'Please enter a valid email address';

      final expectResult = ValidationService.validateEmail(input);

      expect(expectResult, actualResult);
    });

    test(
        'Should return "Please enter a valid email address" Value is "example@gmail',
        () {
      String input = 'example@gmail';
      const actualResult = 'Please enter a valid email address';

      final expectResult = ValidationService.validateEmail(input);

      expect(expectResult, actualResult);
    });

    test('Should return null Value is "example@gmail.com', () {
      String input = 'example@gmail.com';
      const actualResult = null;

      final expectResult = ValidationService.validateEmail(input);

      expect(expectResult, actualResult);
    });
  });
}

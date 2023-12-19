// ignore_for_file: cast_from_null_always_fails, unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/app/modules/login/controllers/Auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

// Import your controller file

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter binding

  late AuthController authController;
  late MockSharedPreferences mockSharedPreferences;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockFirebaseAuth = MockFirebaseAuth();

    authController = AuthController();
    authController.prefs = mockSharedPreferences;
    authController.auth = mockFirebaseAuth;
  });

  group('AuthController Tests', () {
    test('Test checkLoginStatus when user_token is not null or empty',
        () async {
      // Mocking SharedPreferences behavior
      when(mockSharedPreferences.getString('user_token'))
          .thenReturn('someToken');

      await authController.checkLoginStatus();

      // Assert that isLoggedIn.value is true when user_token is not null or empty
      expect(authController.isLoggedIn.value, true);
    });

    test('Test checkLoginStatus when user_token is null', () async {
      // Mocking SharedPreferences behavior
      when(mockSharedPreferences.getString('user_token')).thenReturn(null);

      await authController.checkLoginStatus();

      // Assert that isLoggedIn.value is false when user_token is null
      expect(authController.isLoggedIn.value, false);
    });

    // test('Test logout', () async {
    //   // Mocking SharedPreferences behavior
    //   when(mockSharedPreferences.remove('user_token'))
    //       .thenAnswer((_) => Future.value());

    //   // Mocking FirebaseAuth behavior
    //   when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});

    //   // Perform the logout action
    //   authController.logout();

    //   // Verify that SharedPreferences.remove was called with the correct argument
    //   verify(mockSharedPreferences.remove('user_token')).called(1);

    //   // Verify that FirebaseAuth.signOut was called
    //   verify(mockFirebaseAuth.signOut()).called(1);

    //   // Assert that isLoggedIn value becomes false after logout
    //   expect(authController.isLoggedIn.value, false);

    //   // Add more assertions based on your expected behavior
    //   // For example, verify navigation or other side effects
    // });

    // test('Test logout', () async {
    //   // Mocking SharedPreferences behavior
    //   when(mockSharedPreferences.remove('user_token'))
    //       .thenAnswer((_) async => true);

    //   // Perform the logout action
    //   await authController.logout();

    //   // Assert that isLoggedIn value becomes false after logout
    //   expect(authController.isLoggedIn.value, false);
    //   // Add more assertions based on your expected behavior
    // });

//     test('Test registerUser', () async {
//   // Mocking FirebaseAuth behavior
//   // Add more assertions based on your expected behavior
// });

//     test('Test loginUser', () async {
//     // Mocking FirebaseAuth behavior
//     when(mockFirebaseAuth.signInWithEmailAndPassword(
//       email: anyNamed('email') as String, // Cast the argument as String
//       password: anyNamed('password') as String, // Cast the argument as String
//     )).thenAnswer((_) async => User(uid: '1', email: 'test@test.com'));

//     // Mocking SharedPreferences behavior
//     when(mockSharedPreferences.setString(any, any))
//         .thenReturn(true as Future<bool>);

//     await authController.loginUser('test@test.com', 'password');

//     // Assert your expected behavior after login
//     expect(authController.isLoading.value, false);
//     expect(authController.isLoggedIn.value, true);
//     // Add more assertions based on your expected behavior
//  });
  });
}

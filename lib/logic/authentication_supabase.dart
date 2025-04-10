import 'package:learn_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationSupabase {
  static Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      return response.user != null;
    } on AuthException catch (e) {
      print('Signup error: ${e.message}');
      return false;
    }
  }
}

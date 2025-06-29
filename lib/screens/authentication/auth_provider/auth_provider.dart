import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final _supabase = Supabase.instance.client;

  bool _loading = false;
  bool get isLoading => _loading;

  void _setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      _setLoading(true);

      await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'io.supabase.flutter://login-callback',
      );

      // ✅ Do NOT insert into `clients` table yet.
      return true;
    } catch (e) {
      debugPrint("Signup error: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return 'error_login_failed';
      }

      if (user.emailConfirmedAt == null) {
        return 'error_email_not_verified';
      }

      final existing =
          await _supabase
              .from('clients')
              .select('id')
              .eq('id', user.id)
              .maybeSingle();

      if (existing == null) {
        await _supabase.from('clients').insert({
          'id': user.id,
          'email': user.email,
          'full_name': user.userMetadata?['username'] ?? 'Anonymous',
          'created_at': DateTime.now().toIso8601String(),
        });
      }

      return null;
    } on AuthException catch (e) {
      if (e.message.contains("Invalid login credentials")) {
        return 'error_invalid_credentials';
      }
      return 'error_auth_generic';
    } catch (e) {
      debugPrint("Login error: $e");
      return 'error_unknown';
    } finally {
      _setLoading(false);
    }
  }
}

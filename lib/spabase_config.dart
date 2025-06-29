import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const supabaseUrl = 'https://fjzdizmnjbpecpgubxwv.supabase.co';
  static const supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZqemRpem1uamJwZWNwZ3VieHd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA4OTc0MTUsImV4cCI6MjA2NjQ3MzQxNX0.VVJZzgywFLGy7qOXRZgHs0CLLPFO5JtOESCQF764f6g';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(autoRefreshToken: true),
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}

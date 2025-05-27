import 'package:supabase_flutter/supabase_flutter.dart';

class BetService {
  final _supabase = Supabase.instance.client;

  Future<void> placeBet({
    required String team1,
    required String team2,
    required String selected,
    required double amount,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final response = await _supabase.from('bets').insert({
      'user_id': user.id,
      'team1': team1,
      'team2': team2,
      'selected': selected,
      'amount': amount,
    });

    if (response != null && response.error != null) {
      throw Exception("Failed to place bet: ${response.error!.message}");
    }
  }
}

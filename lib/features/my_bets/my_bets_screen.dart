import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BetHistoryScreen extends StatefulWidget {
  const BetHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BetHistoryScreen> createState() => _BetHistoryScreenState();
}

class _BetHistoryScreenState extends State<BetHistoryScreen> {
  final supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> _betHistoryFuture;

  @override
  void initState() {
    super.initState();
    _betHistoryFuture = _fetchBetHistory();
  }

  Future<List<Map<String, dynamic>>> _fetchBetHistory() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    try {
      final data = await supabase
          .from('bets')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(data as List);
    } catch (e) {
      debugPrint('Error fetching bet history: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bet History')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _betHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final bets = snapshot.data ?? [];

          if (bets.isEmpty) {
            return const Center(child: Text('No bet history found.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: bets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final bet = bets[index];
              final match = "${bet['team1']} vs ${bet['team2']}";
              final amount = bet['amount'] ?? 0;
              final status = bet['status'] ?? 'pending';
              final createdAt = bet['created_at'];
              String dateStr = '';

              if (createdAt != null) {
                try {
                  dateStr = DateTime.parse(createdAt).toLocal().toString();
                } catch (_) {
                  dateStr = createdAt.toString();
                }
              }

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Match: $match',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('Amount: Ksh $amount'),
                      const SizedBox(height: 4),
                      Text('Status: $status'),
                      const SizedBox(height: 4),
                      Text(
                        'Date: $dateStr',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

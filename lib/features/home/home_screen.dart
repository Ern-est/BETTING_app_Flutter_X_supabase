import 'package:betmate/features/my_bets/my_bets_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'components/match_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("🏆 BetMate")),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, ${user?.email ?? 'User'} 👋",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Balance", style: TextStyle(fontSize: 18)),
                    const Text(
                      "Ksh 0.00",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Added Button here
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BetHistoryScreen(),
                          ),
                        );
                      },
                      child: const Text('Bet History'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Upcoming Matches",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  MatchTile(
                    team1: "Arsenal",
                    team2: "Man City",
                    time: "7:30 PM",
                  ),
                  SizedBox(height: 10),
                  MatchTile(
                    team1: "Chelsea",
                    team2: "Liverpool",
                    time: "9:00 PM",
                  ),
                  SizedBox(height: 10),
                  MatchTile(
                    team1: "Newcastle",
                    team2: "Crystal Palace",
                    time: "10:00 PM",
                  ),
                  SizedBox(height: 10),
                  MatchTile(
                    team1: "Watford",
                    team2: "Brighton",
                    time: "11:00 PM",
                  ),
                  SizedBox(height: 10),
                  MatchTile(
                    team1: "Fulham",
                    team2: "Manchester City",
                    time: "12:00 PM",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

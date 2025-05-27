import 'package:betmate/features/bet/bet_screen.dart';
import 'package:flutter/material.dart';

class MatchTile extends StatelessWidget {
  final String team1;
  final String team2;
  final String time;

  const MatchTile({
    super.key,
    required this.team1,
    required this.team2,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.sports_soccer),
        title: Text("$team1 vs $team2"),
        subtitle: Text("Kick-off: $time"),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BetScreen(team1: team1, team2: team2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Sets background to orange
          ),
          child: const Text(
            "Bet",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

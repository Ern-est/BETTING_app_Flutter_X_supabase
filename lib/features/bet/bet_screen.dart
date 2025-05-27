import 'package:betmate/services/bet_service.dart';
import 'package:flutter/material.dart';

class BetScreen extends StatefulWidget {
  final String team1;
  final String team2;

  const BetScreen({super.key, required this.team1, required this.team2});

  @override
  State<BetScreen> createState() => _BetScreenState();
}

class _BetScreenState extends State<BetScreen> {
  String? selectedOutcome;
  final TextEditingController amountController = TextEditingController();
  void _placeBet() async {
    if (selectedOutcome == null || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an outcome and enter amount"),
        ),
      );
      return;
    }

    try {
      final amount = double.parse(amountController.text);
      await BetService().placeBet(
        team1: widget.team1,
        team2: widget.team2,
        selected: selectedOutcome!,
        amount: amount,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Bet placed successfully")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Place Bet")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.team1} vs ${widget.team2}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            const Text("Select Outcome:"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: Text(widget.team1),
                  selected: selectedOutcome == widget.team1,
                  onSelected:
                      (val) => setState(() => selectedOutcome = widget.team1),
                ),
                ChoiceChip(
                  label: Text(widget.team2),
                  selected: selectedOutcome == widget.team2,
                  onSelected:
                      (val) => setState(() => selectedOutcome = widget.team2),
                ),
                ChoiceChip(
                  label: const Text("Draw"),
                  selected: selectedOutcome == "Draw",
                  onSelected: (val) => setState(() => selectedOutcome = "Draw"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount (Ksh)",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _placeBet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Place Bet",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

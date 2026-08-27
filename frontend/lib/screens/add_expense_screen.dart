import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../core/app_state.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String _amountString = "0";
  String _name = "Netflix";
  String _type = "expense";
  final DateTime _date = DateTime.now();

  void _onNumpadTap(String value) {
    setState(() {
      if (value == "CLEAR") {
        _amountString = "0";
      } else if (value == "BACKSPACE") {
        if (_amountString.length > 1) {
          _amountString = _amountString.substring(0, _amountString.length - 1);
        } else {
          _amountString = "0";
        }
      } else if (value == ".") {
        if (!_amountString.contains(".")) {
          _amountString += value;
        }
      } else {
        if (_amountString == "0") {
          _amountString = value;
        } else {
          // Limit decimal places to 2
          if (_amountString.contains(".")) {
            final parts = _amountString.split(".");
            if (parts[1].length < 2) {
              _amountString += value;
            }
          } else {
            _amountString += value;
          }
        }
      }
    });
  }

  Future<void> _submitExpense() async {
    final amount = double.tryParse(_amountString) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    try {
      final appState = Provider.of<AppState>(context, listen: false);
      await appState.addExpense(amount, _name, _date, _type);
      if (mounted) {
        Navigator.pop(context); // Go back to Home
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add expense: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        title: const Text("Add Expense", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: const [
          Icon(Icons.more_horiz, color: Colors.white),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("NAME", style: TextStyle(color: AppTheme.textGrey, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInputBox(
                      child: Row(
                        children: [
                          Icon(_type == 'expense' ? Icons.video_library : Icons.monetization_on, color: _type == 'expense' ? Colors.red : AppTheme.income),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _name,
                                items: ["Netflix", "Starbucks", "Upwork", "Salary", "Groceries"]
                                    .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))))
                                    .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _name = val;
                                      if (val == "Upwork" || val == "Salary") {
                                        _type = "income";
                                      } else {
                                        _type = "expense";
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("AMOUNT", style: TextStyle(color: AppTheme.textGrey, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInputBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$ $_amountString", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () => _onNumpadTap("CLEAR"),
                            child: const Text("Clear", style: TextStyle(color: AppTheme.textGrey, fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("DATE", style: TextStyle(color: AppTheme.textGrey, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInputBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('E, dd MMM yyyy').format(_date), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          const Icon(Icons.calendar_today, color: AppTheme.textGrey, size: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: appState.isLoading ? null : _submitExpense,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: appState.isLoading 
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    _buildNumpad(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _buildNumpad() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 2.2,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (int i = 1; i <= 9; i++) 
          InkWell(
            onTap: () => _onNumpadTap(i.toString()),
            child: Center(child: Text(i.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500))),
          ),
        InkWell(
          onTap: () => _onNumpadTap("."),
          child: const Center(child: Text(".", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500))),
        ),
        InkWell(
          onTap: () => _onNumpadTap("0"),
          child: const Center(child: Text("0", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500))),
        ),
        InkWell(
          onTap: () => _onNumpadTap("BACKSPACE"),
          child: const Center(child: Icon(Icons.backspace_outlined)),
        ),
      ],
    );
  }
}

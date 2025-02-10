import 'package:flutter/material.dart';

class PriceGrid extends StatelessWidget {
  final Map<String, double> prices;

  const PriceGrid({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: prices.entries.map((entry) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              "${entry.key}: R\$ ${entry.value.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

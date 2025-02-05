import 'package:flutter/material.dart';
import 'package:guia_de_moteis_teste/widgets/price_button.dart';

class PriceGrid extends StatelessWidget {
  final Map<String, double> prices;
  const PriceGrid({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: prices.entries.map((entry) {
        return PriceButton(duration: entry.key, price: entry.value);
      }).toList(),
    );
  }
}

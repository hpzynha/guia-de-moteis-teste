import 'package:flutter/material.dart';
import 'package:guia_de_moteis_teste/widgets/availability_alert.dart';
import 'package:guia_de_moteis_teste/widgets/map_button.dart';
import 'package:guia_de_moteis_teste/widgets/price_grid.dart';
import 'package:guia_de_moteis_teste/widgets/rating_stars.dart';

class MotelCard extends StatelessWidget {
  final String name;
  final String distance;
  final String location;
  final double rating;
  final int reviews;
  final int remaningSuites;
  final Map<String, double> prices;

  const MotelCard(
      {super.key,
      required this.name,
      required this.distance,
      required this.location,
      required this.rating,
      required this.reviews,
      required this.remaningSuites,
      required this.prices});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "$distance - $location",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    RatingStars(rating: rating),
                    Text(
                      "$reviews avaliações ▼",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            AvailabilityAlert(remaining: remaningSuites),
            SizedBox(
              height: 16,
            ),
            PriceGrid(prices: prices),
            SizedBox(
              height: 16,
            ),
            MapButton(),
          ],
        ),
      ),
    );
  }
}

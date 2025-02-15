import 'package:flutter/material.dart';
import 'package:guia_de_moteis_teste/widgets/availability_alert.dart';
import 'package:guia_de_moteis_teste/widgets/price_grid.dart';
import 'package:guia_de_moteis_teste/widgets/rating_stars.dart';

class MotelCard extends StatelessWidget {
  final String name;
  final String distance;
  final String location;
  final double rating;
  final int reviews;
  final int remainingSuites;
  final Map<String, double> prices;
  final String imageUrl;

  const MotelCard({
    super.key,
    required this.name,
    required this.distance,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.remainingSuites,
    required this.prices,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Logo do motel
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$distance - $location",
                        style: TextStyle(color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingStars(rating: rating),
                    const SizedBox(height: 4),
                    Text(
                      "$reviews avaliações",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (remainingSuites > 0)
              AvailabilityAlert(remaining: remainingSuites),
            const SizedBox(height: 16),
            PriceGrid(prices: prices),
          ],
        ),
      ),
    );
  }
}

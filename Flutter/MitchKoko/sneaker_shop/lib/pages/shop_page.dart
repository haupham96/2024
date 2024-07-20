import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_shop/models/shoe.dart';

import '../components/shoe_tile.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // search bar
      Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'search',
              style: TextStyle(color: Colors.grey),
            ),
            Icon(Icons.search, color: Colors.grey),
          ],
        ),
      ),

      // message
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Text(
          'Every one flies... just fly longer than others',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),

      // hot picks
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Hot picks 🔥',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              'See all.',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            )
          ],
        ),
      ),
      const SizedBox(height: 10),
      Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                Shoe shoe = Shoe(
                    name: 'Air Jordan',
                    price: '120',
                    imagePath: 'lib/images/sneaker_1.jpg',
                    description: 'cool shoe');
                return ShoeTile(shoe: shoe);
              }))
    ]);
  }
}

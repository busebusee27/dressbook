import 'package:dressbook/constants.dart';
import 'package:flutter/material.dart';

class DressCard extends StatefulWidget {
  const DressCard({super.key});

  @override
  State<DressCard> createState() => _DressCardState();
}

class _DressCardState extends State<DressCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all()
        ),
        padding: const EdgeInsets.all(4),
        child: Card(
          child: SizedBox(
            height: 0.1*SCREEN_HEIGHT,
            width: 0.33*SCREEN_WIDTH,
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image(
                      fit: BoxFit.contain,
                      image: NetworkImage('https://preview.redd.it/i-got-bored-so-i-decided-to-draw-a-random-image-on-the-v0-4ig97vv85vjb1.png?width=1280&format=png&auto=webp&s=7177756d1f393b6e093596d06e1ba539f723264b'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Placeholder(),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.more_vert_outlined),
                        )
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('date')
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerProductsWidget extends StatelessWidget {
  const ShimmerProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.white,
      child: SizedBox(
        height: size.height,
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: SizedBox(
                            height: 0.3 * size.height,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: const [
                          Icon(Icons.attach_money),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'text',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ok_task/features/product_feature/presentation/bloc/single_product_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../domain/entities/product.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    BlocProvider.of<SingleProductBloc>(context)
        .add(GetSingleProductEvent(widget.product));
    super.initState();
  }

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<SingleProductBloc, SingleProductState>(
      builder: (context, state) {
        if (state is GetSingleProductLoading) {
          return AlertDialog(
            title: alertDialogueTitle(),
            content: SizedBox(
              width: 0.8 * size.width,
              height: 0.5 * size.height,
              child: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.red, size: 50),
              ),
            ),
          );
        }
        if (state is GetSingleProductCompleted) {
          return AlertDialog(
            title: Align(
              alignment: Alignment.center,
              child: Text(
                state.product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SizedBox(
              width: 0.8 * size.width,
              height: 0.5 * size.height,
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: state.product.images.length,
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = state.product.images[index];
                      return showImage(imageUrl, index);
                    },
                    options: CarouselOptions(
                      height: 0.3 * size.height,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) => setState(() {
                        activeIndex = index;
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  if (state.product.images.length > 1) pageIndicator(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(state.product.description),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          );
        }
        if (state is GetSingleProductError) {
          return AlertDialog(
            title: alertDialogueTitle(),
            content: SizedBox(
              width: 0.8 * size.width,
              height: 0.45 * size.height,
              child: const Center(
                child: Text('Server Error!'),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget showImage(String imageUrl, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.grey,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  // Page indicator for dialogue box image slider
  Widget pageIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.product.images.length,
      );

  // Tilte for dialogue box
  Widget alertDialogueTitle() => Align(
        alignment: Alignment.center,
        child: Text(
          widget.product.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

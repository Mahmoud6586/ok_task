import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ok_task/features/product_feature/presentation/bloc/product_bloc.dart';
import 'package:ok_task/features/product_feature/presentation/widgets/product_item.dart';
import 'package:ok_task/features/product_feature/presentation/widgets/shimmer_products_widget.dart';
import 'package:ok_task/locator.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is GetAllProductsLoading) {
                return const ShimmerProductsWidget();
              }
              if (state is GetAllProductsCompleted) {
                return SizedBox(
                  height: size.height,
                  child: ListView.builder(
                      itemCount: state.productsList.length,
                      itemBuilder: (context, index) {
                        return ProductItem(product: state.productsList[index]);
                      }),
                );
              }
              if (state is GetAllProductsError) {
                return Center(
                  child: Column(
                    children: [
                      const Text('Something went wrong. Try again!'),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<ProductBloc>(context)
                              .add(GetAllProductsEvent());
                        },
                        icon: const Icon(Icons.autorenew),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  BlocProvider<ProductBloc> homeBody(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ProductBloc>(),
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is GetAllProductsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetAllProductsCompleted) {
                return ListView.builder(
                    itemCount: state.productsList.length,
                    itemBuilder: (context, index) {
                      return ProductItem(product: state.productsList[index]);
                    });
              }
              if (state is GetAllProductsError) {
                return Center(
                  child: Column(
                    children: [
                      const Text('Something went wrong. Try again!'),
                      IconButton(
                        onPressed: () {
                          // BlocProvider.of<ProductBloc>(context)
                          //     .add(GetAllProductsEvent());
                        },
                        icon: const Icon(Icons.autorenew),
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: Text('success'),
              );
            },
          )),
    );
  }
}

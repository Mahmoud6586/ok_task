import 'dart:convert';

import 'package:ok_task/core/error/failures.dart';

import '../../domain/entities/product.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<Product>> getAllProducts();

  Future<Product> getSingleProduct(int id);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<Product> getSingleProduct(int id) async {
    final response = await http
        .get(Uri.parse('https://api.escuelajs.co/api/v1/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw ServerFailure();
    }
  }
}

import 'package:eshop/features/produits/data/product-model.dart';
import 'package:eshop/features/produits/domain/api-service.dart';
import 'package:eshop/features/produits/presentation/product-details.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> futureProducts;
  late TextEditingController _searchController;
  double _minPrice = 0;
  double _maxPrice = 100; // Valeur maximale arbitraire pour le RangeSlider
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
    _searchController = TextEditingController();
    _currentRangeValues = RangeValues(_minPrice, _maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Shop',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher par nom de produit...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Rafraîchit l'interface pour mettre à jour la liste
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filtrer par prix :'),
                Text('\$${_currentRangeValues.start.toInt()} - \$${_currentRangeValues.end.toInt()}'),
              ],
            ),
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: _minPrice,
            max: _maxPrice,
            divisions: 100,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur : ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Product> filteredProducts = snapshot.data!.where((product) {
                    final matchesSearch = product.title.toLowerCase().contains(_searchController.text.toLowerCase());
                    final matchesPrice = product.price >= _currentRangeValues.start && product.price <= _currentRangeValues.end;
                    return matchesSearch && matchesPrice;
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return Center(child: Text('Aucun produit trouvé'));
                  }

                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      Product product = filteredProducts[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: ListTile(
                          leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(product.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('\$${product.price.toString()}'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Chargement en cours...'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

  
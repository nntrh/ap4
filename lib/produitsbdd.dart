import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'navbar.dart';

class ProduitsBdd extends StatefulWidget {
  @override
  _ProduitsBddState createState() => _ProduitsBddState();
}

class _ProduitsBddState extends State<ProduitsBdd> {
  int _selectedIndex = 1;
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://localhost:4000/api/prod/produit'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liste des produits',
          style: TextStyle(
            color: Colors.white, // Couleur du titre en blanc
          ),
        ),
        backgroundColor: Color.fromRGBO(243, 129, 72, 0.953), // Couleur de fond de l'AppBar
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton( // Ajoutez un bouton d'icône personnalisé pour la flèche de retour
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home'); // Cette ligne permet de revenir à la page précédente
          },
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ProductDetailsDialog(product: snapshot.data![index]),
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            'http://localhost:4000/${snapshot.data![index].img}',
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: 150,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data![index].nom,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${snapshot.data![index].prix.toStringAsFixed(2)} €',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home');
                break;
              case 1:
                Navigator.pushNamed(context, '/produitsbdd');
                break;
              case 2:
                Navigator.pushNamed(context, '/ajouterProduit');
                break;
            }
          });
        },
      ),
    );
  }
}

class Product {
  final int id;
  final String nom;
  final String description;
  final double prix;
  final int quantite;
  final String img;

  Product({
    required this.id,
    required this.nom,
    required this.description,
    required this.prix,
    required this.quantite,
    required this.img,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? '',
      description: json['description'] ?? '',
      prix: json['prix']?.toDouble() ?? 0.0,
      quantite: json['quantite'] ?? 0,
      img: json['img'] ?? '',
    );
  }
}

class ProductDetailsDialog extends StatelessWidget {
  final Product product;

  const ProductDetailsDialog({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Informations sur le produit'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'http://localhost:4000/${product.img}',
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 8),
              Text(
                product.nom,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                product.description,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                '${product.prix.toStringAsFixed(2)} €',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

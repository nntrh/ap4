import 'package:flutter/material.dart';
import 'navbar.dart'; // Importez CustomNavBar à partir de votre fichier navbar.dart

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accueil',
          style: TextStyle(
            color: Colors.white, // Couleur du titre en blanc
          ),
        ),
        backgroundColor: Color.fromRGBO(243, 129, 72, 0.953), // Couleur de fond de l'AppBar
      ),
      body: Center(
        child: Text('Bienvenue sur la page d\'accueil!'),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {
          // Naviguer en fonction de l'élément sélectionné dans la barre de navigation
          if (index == 1) {
            // Si l'élément "Produits" est sélectionné, naviguer vers la page ProduitsBdd
            Navigator.pushReplacementNamed(context, '/produitsbdd');
          } else if (index == 2) {
            // Si l'élément "Ajouter" est sélectionné, naviguer vers la page d'ajout
            Navigator.pushReplacementNamed(context, '/ajouterProduit');
          }
        },
      ),
    );
  }
}

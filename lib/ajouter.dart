import 'package:flutter/material.dart';
import 'navbar.dart'; // Importez CustomNavBar à partir de votre fichier navbar.dart

class AjouterProduitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter un produit',
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
            Navigator.pushReplacementNamed(context, '/home'); 
          },
        ),
      ),
      body: Center(
        child: Text('Formulaire d\'ajout de produit'),
      ),
      bottomNavigationBar: CustomNavBar( // Ajoutez la barre de navigation en bas de la page
        selectedIndex: 2, // Indiquez l'index correspondant à cette page (dans ce cas, "Ajouter")
        onItemTapped: (index) {
          // Gérez la navigation ici si nécessaire
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/produitsbdd');
              break;
            case 2:
              // Cette page est déjà sur "Ajouter", donc rien à faire
              break;
          }
        },
      ),
    );
  }
}

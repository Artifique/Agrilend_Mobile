# Agrilend_Mobile

## Présentation du Projet

Agrilend est une plateforme mobile innovante visant à connecter directement les producteurs agricoles avec des acheteurs du monde entier. Notre objectif est de faciliter la vente de produits agricoles de manière rapide, transparente et efficace, en offrant aux agriculteurs un accès au marché mondial (les frais de transport ne sont pas inclus).

Le processus est le suivant :
1.  **Engagement avec l'Agriculteur** : Nous approchons les agriculteurs pour leur proposer de vendre leurs produits rapidement et de manière transparente.
2.  **Contractualisation et Tokenisation** : Après accord, un contrat est signé avec l'agriculteur pour la fourniture de quantités spécifiques de produits. En fonction de la quantité fournie, des tokens fongibles sont créés sur une blockchain.
3.  **Mécanisme de Paiement pour l'Acheteur** : Pour effectuer un achat, l'acheteur doit injecter des HBAR (la cryptomonnaie de Hedera) dans un pool dédié, pour une durée déterminée.
4.  **Livraison et Vérification** : Les fonds ne sont versés à l'agriculteur qu'après la livraison du produit et la vérification de sa conformité aux termes du contrat.
5.  **Finalisation de la Transaction** : Une fois la conformité confirmée, les tokens sont "brûlés" (retirés de la circulation) et l'agriculteur est rémunéré en HBAR ou en monnaie fiduciaire, selon sa préférence.

## Prérequis

Pour développer et exécuter ce projet, vous aurez besoin des éléments suivants :

*   **Flutter SDK** : Version 3.x.x ou supérieure.
*   **Dart SDK** : Inclus avec Flutter.
*   **Java Development Kit (JDK)** : Version  17 recommandée pour la compilation Android.
*   **Android Studio** : Pour la configuration de l'environnement Android et l'émulateur.
*   **Xcode** (pour iOS) : Nécessaire pour le développement et la compilation iOS sur macOS.
*   **Un éditeur de code** : Visual Studio Code ou Android Studio sont recommandés.
*   **Git** : Pour la gestion de version.

## Installation et Lancement

1.  **Cloner le dépôt** :
    ```bash
git clone [URL_DU_DEPOT]
    cd Agrilend_Mobile
    ```
2.  **Installer les dépendances** :
    ```bash
    flutter pub get
    ```
3.  **Lancer l'application** :
    ```bash
    flutter run
    ```

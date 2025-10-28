import 'package:flutter/material.dart';

 class  RandomUserLoadingMessage {
  // Variável para controlar se o loader está aberto e evitar múltiplos diálogos
  bool _isLoaderOpen = false;

  void showLoader(BuildContext context) {

    if (!_isLoaderOpen &&  context.mounted) {
      _isLoaderOpen = true;
      showDialog(
        context: context,
      
        barrierDismissible: false,
        
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  }

  void hideLoader(BuildContext context) {
    
    if (_isLoaderOpen && context.mounted) {
      _isLoaderOpen = false;
   
    Navigator.pop(context);
    
    }
  }

  void showMessage(String message,BuildContext context , {bool isError = false}) {
   
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
        ),
      );
    }
  }
}
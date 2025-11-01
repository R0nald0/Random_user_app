import 'package:flutter/material.dart';



/// Instância global do observador de rotas
class AppRouteObserver {
  static final RouteObserver<PageRoute> instance = RouteObserver<PageRoute>();
}

/// Extensão para facilitar o acesso ao observer via context
extension RouteObserverExtension on BuildContext {
  RouteObserver<PageRoute> get routeObserver => AppRouteObserver.instance;
}

extension MessageCall on BuildContext {
  
  void showCustomSnackBar( {
    required String message,
    IconData icon = Icons.info,
    Duration duration = const Duration(seconds: 3),
    bool isError = false
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(12),
        duration: duration,
      ),
    );
  }
}

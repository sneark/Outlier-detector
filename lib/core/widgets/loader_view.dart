import 'package:flutter/material.dart';
import 'dart:ui';

class LoaderView extends StatelessWidget {
  final String message;

  const LoaderView({
    super.key,
    this.message = "Przetwarzanie danych...", 
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        ModalBarrier(
          color: Colors.black.withOpacity(0.2),
          dismissible: false,
        ),
        
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                decoration: BoxDecoration(
                  color: isDark 
                      ? Colors.grey[900]!.withOpacity(0.7) 
                      : Colors.white.withOpacity(0.75), 
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark 
                        ? Colors.white.withOpacity(0.1) 
                        : Colors.white.withOpacity(0.4),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20, 
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Transform.scale(
                       scale: 1.2, 
                       child: const CircularProgressIndicator.adaptive(), 
                     ),
                     const SizedBox(height: 20),
                     Text(
                       message, 
                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
                         fontWeight: FontWeight.w600,
                         color: isDark ? Colors.white : Colors.black87,
                       ),
                       textAlign: TextAlign.center, 
                     )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
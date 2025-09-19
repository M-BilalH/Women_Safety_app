import 'package:flutter/material.dart';
import 'package:wsfty_apk/utils/constants.dart';

class livesafecard extends StatelessWidget {
    final IconData icon;
  final String label;
  final String label2;
final void Function(String) onMapFunction;
Color color;
  livesafecard({
    Key? key,
    required this.icon,
    required this.label,
    required this.onMapFunction,
    required this.label2,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
               onMapFunction!(label2);
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Icon(icon,
                  size: 25,
                  color:  color),
                  
                ),
                
              ),
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}
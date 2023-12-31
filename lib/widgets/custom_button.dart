import 'package:flutter/material.dart';



class CustomButon extends StatelessWidget {
  const CustomButon(
      {super.key, required this.onTap, required this.text, this.isLoading = false});
 final VoidCallback? onTap;
  final String text;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 55,
        child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                : Text(text, style:const TextStyle(fontSize: 18 ,color: Colors.black) )),
      ),
    );
  }
}

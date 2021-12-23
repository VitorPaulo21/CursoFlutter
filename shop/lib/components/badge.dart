import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String num;
  final Color? color;
  final Function()? onPressed;
  const Badge({
    required this.child,
    required this.num,
    this.color,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            child,
            (int.tryParse(num) ?? 0) > 0
                ? Positioned(
                    top: 12,
                    right: 0,
                    child: CircleAvatar(
                      radius: 6,
                      foregroundColor: Colors.white,
                      child: Text(
                        num,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor:
                          color ?? Theme.of(context).colorScheme.secondary,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

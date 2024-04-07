import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  const BaseScreen(this.child, {super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: kTextTabBarHeight,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.go('/home');
                    },
                    child: Text(
                      'Pizza Admin',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: widget.child)
        ],
      ),
    );
  }
}

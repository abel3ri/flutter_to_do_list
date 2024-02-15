import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Menu",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
            ),
            const Divider(color: Colors.white, thickness: 0.3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Use dark theme",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Switch(
                  value: false,
                  onChanged: (value) => {},
                  activeColor: Colors.white,
                  activeTrackColor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

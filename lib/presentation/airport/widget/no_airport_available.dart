import 'package:flutter/material.dart';

class NoAirportAvailable extends StatelessWidget {
  final VoidCallback onTryAgain;

  const NoAirportAvailable({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/not_found.png'),
        const SizedBox(height: 10),
        Text(
          'No airport is available here!',
          style: TextStyle(
            fontSize: deviceSize.width * 0.05,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: deviceSize.width * 0.7,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(Theme.of(context).primaryColor),
              padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 15)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: onTryAgain,
            child: const Text(
              'Try Again',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

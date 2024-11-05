import 'package:flutter/material.dart';

class Alerts {
  static final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void hideSnackBar() {
    rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }

  static void successSnackBar(String message, {SnackBarAction? action}) {
    rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                maxLines: 4,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff4FB59E),
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Alerts.hideSnackBar();
              },
              icon: const Icon(
                Icons.close,
                size: 24,
                color: Color(0xffE4003B),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xffEEF8F6),
        duration: const Duration(seconds: 2),
        action: action,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static void errorSnackBar(
    String message, {
    SnackBarAction? action,
    Widget? suffix,
    Duration? duration,
  }) {
    rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 4,
                style: const TextStyle(
                  color: Color(0xffE4003B),
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            suffix ??
                IconButton(
                  onPressed: () {
                    Alerts.hideSnackBar();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 24,
                    color: Color(0xffE4003B),
                  ),
                ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xffFDF2F5),
        duration: duration ?? const Duration(seconds: 2),
        action: action,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static void warningSnackBar(
    String message, {
    SnackBarAction? action,
    Widget? suffix,
    Duration? duration,
  }) {
    rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 4,
                style: const TextStyle(
                  color: Color(0xffFFC107),
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            suffix ??
                IconButton(
                  onPressed: () {
                    Alerts.hideSnackBar();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 24,
                    color: Color(0xffE4003B),
                  ),
                ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xffFDF2F5),
        duration: duration ?? const Duration(seconds: 2),
        action: action,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

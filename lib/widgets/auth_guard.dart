import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

/// Ensures that the user is authenticated before opening a protected screen.
Future<bool> ensureLoggedIn(BuildContext context) async {
  // If already logged in, allow access immediately.
  if (context.read<AuthState>().isLoggedIn) {
    return true;
  }

  // Otherwise, show LoginScreen.
  final loggedIn = await Navigator.push<bool>(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );

  return loggedIn ?? false;
}

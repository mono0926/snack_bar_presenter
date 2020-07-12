import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'router.dart';

void run() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => GlobalKey<NavigatorState>()),
        Provider(create: (context) => Router()),
      ],
      child: const App(),
    ),
  );
}

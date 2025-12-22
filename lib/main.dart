import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'data/database/isar_service.dart';
import 'data/database/json_loader.dart';
import 'features/login/login_screen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  await isarService.openDB();

  final loader = JsonLoader(isarService);

  // PAKSA import ONCE untuk development/debug.
  // Setelah import berhasil, ubah ke false atau hapus baris ini.
  await loader.loadMateri(force: true);

  runApp(MyApp(isarService: isarService));
}

class MyApp extends StatelessWidget {
  final IsarService isarService;
  const MyApp({super.key, required this.isarService});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.appName,
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(isarService: isarService),
    );
  }
}

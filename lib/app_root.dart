import 'package:flutter/material.dart';
// home_screen.dart ഫയലിനെ ഇംപോർട്ട് ചെയ്യുന്നു
import 'home_screen.dart'; 

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSD_003_eg',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // ഇവിടെയുണ്ടായിരുന്ന 'const' ഒഴിവാക്കി. ഇതാണ് എറർ മാറാൻ കാരണം.
      home: HomeScreen(title: 'ലളിതമായ കൗണ്ടർ'),
    );
  }
}

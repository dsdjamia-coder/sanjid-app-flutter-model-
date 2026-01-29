import 'package:flutter/material.dart';
// നമ്മൾ ഉണ്ടാക്കാൻ പോകുന്ന കൗണ്ടർ സ്ക്രീനിനെ ഇവിടെ ഇംപോർട്ട് ചെയ്യുന്നു
import 'screens/home_screen.dart'; 

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp ആണ് ഫ്ലട്ടർ ആപ്പിന്റെ അടിസ്ഥാനം
    return MaterialApp(
      // ആപ്പിന്റെ പേര് (Recent apps list-ൽ കാണുന്നത്)
      title: 'DSD_003_eg',
      
      // ഡീബഗ് ബാനർ ഒഴിവാക്കാൻ
      debugShowCheckedModeBanner: false,

      // ആപ്പിന്റെ തീം (നിറങ്ങൾ) സെറ്റ് ചെയ്യുന്നു
      theme: ThemeData(
        // പ്രധാന നിറം നീലയായി സെറ്റ് ചെയ്യുന്നു
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // പുതിയ ഡിസൈൻ സ്റ്റൈൽ
      ),

      // ആപ്പ് തുറക്കുമ്പോൾ ആദ്യം കാണിക്കേണ്ട പേജ് (Home Page)
      home: const HomeScreen(title: 'ലളിതമായ കൗണ്ടർ'),
    );
  }
}

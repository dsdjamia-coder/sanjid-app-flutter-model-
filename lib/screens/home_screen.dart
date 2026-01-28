import 'package:flutter/material.dart';

// ഇത് ഒരു StatefulWidget ആണ്. കാരണം സ്ക്രീനിലെ നമ്പർ മാറിക്കൊണ്ടിരിക്കണം.
class HomeScreen extends StatefulWidget {
  // പുറത്ത് നിന്ന് ലഭിക്കുന്ന തലക്കെട്ട് (Title) സൂക്ഷിക്കാൻ
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // കൗണ്ടർ നമ്പറിനെ ഓർത്തു വെക്കാനുള്ള വേരിയബിൾ. തുടക്കം 0.
  int _counter = 0;

  // നമ്പർ കൂട്ടാനുള്ള ഫംഗ്‌ഷൻ
  void _incrementCounter() {
    // setState എന്ന് വിളിച്ചാൽ മാത്രമേ സ്ക്രീൻ പുതുക്കുകയുള്ളൂ (Refresh).
    setState(() {
      _counter++; // കൗണ്ടർ 1 വെച്ച് കൂട്ടുന്നു
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold എന്നത് ഒരു പേജിന്റെ അടിസ്ഥാന ഘടനയാണ് (AppBar, Body, etc.)
    return Scaffold(
      // മുകളിലെ നീല ബാർ (AppBar)
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), // മുകളിൽ സെറ്റ് ചെയ്ത തലക്കെട്ട് ഇവിടെ കാണിക്കും
      ),
      
      // പേജിന്റെ ഉള്ളടക്കം (Body)
      body: Center(
        // വരിവരിയായി കാണിക്കാൻ Column ഉപയോഗിക്കുന്നു
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // നടുവിലേക്ക് ആക്കാൻ
          children: <Widget>[
            const Text(
              'നിങ്ങൾ ബട്ടൺ അമർത്തിയ തവണ:',
              style: TextStyle(fontSize: 18), // അക്ഷരത്തിന്റെ വലിപ്പം
            ),
            // നമ്മുടെ കൗണ്ടർ നമ്പർ ഇവിടെ കാണിക്കുന്നു
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium, // വലിയ അക്ഷരത്തിൽ
            ),
          ],
        ),
      ),
      
      // താഴെ കാണുന്ന + ചിഹ്നമുള്ള ബട്ടൺ
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // അമർത്തുമ്പോൾ നമ്പർ കൂട്ടാനുള്ള ഫംഗ്‌ഷൻ വിളിക്കുന്നു
        tooltip: 'കൂട്ടുക', // അമർത്തിപ്പിടിച്ചാൽ കാണിക്കുന്ന പേര്
        child: const Icon(Icons.add), // + ഐക്കൺ
      ),
    );
  }
}

import 'package:flutter/material.dart';
// നമ്മൾ വേറെ ഫയലിൽ ഉണ്ടാക്കിയ AppRoot-നെ ഇവിടെ വിളിക്കുന്നു
import 'app_root.dart'; 

// ഇതാണ് ആപ്പിന്റെ മെയിൻ ഫംഗ്‌ഷൻ. ഇവിടെ നിന്നാണ് ആപ്പ് റൺ ആകുന്നത്.
void main() {
  // const AppRoot() എന്നത് നമ്മൾ താഴെ ഉണ്ടാക്കാൻ പോകുന്ന ക്ലാസ്സ് ആണ്.
  runApp(const AppRoot());
}

import '../settings.dart';

void runExercise5() {
  print("\n--- Exercise 5: Factory Constructors & Cache ---");

  Settings appConfigA = Settings(theme: 'dark', notificationsEnabled: true);
  Settings appConfigB = Settings(theme: 'light', notificationsEnabled: false);

  print("   Config A Theme: ${appConfigA.theme}");
  print("   Config B Theme: ${appConfigB.theme} (Retrieved cached instance)");

  bool isSameObject = identical(appConfigA, appConfigB);
  print("   Are both instances identical in memory? -> $isSameObject");
}
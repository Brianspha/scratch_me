import 'package:get_it/get_it.dart';
import 'package:scratch_me/classes/app_storage.dart';
import 'package:scratch_me/classes/token_manager.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(AppStorage(), signalsReady: true);
  locator.registerSingleton(TokenManager(), signalsReady: true);

}

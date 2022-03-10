import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// @dev contains method signatures that write to secure storage
///
abstract class IAPPStorage {
  //@dev gets the currently init instance
  FlutterSecureStorage get appStorageInstance;
  //@dev initialised before calling any other function
  Future<void>  init();
  /*
  *@dev gets all app storage values
  * @returns a Mapping which contains all the values with their keys
   */
  Future<Map<String, String>> getAllStorageValues(String key);

  /// @dev gets a value associated with the give key
  /// @param key - The key to be used to search for the associated value
  /// @returns the value associated with the key in String format
  Future<String?>  getStorageValue(String key);

  /// @dev deletes a value associated with the current key
  /// @param key- The key to be used to delete the associated key-value
  void deleteStorageValue(String key);

  /// @dev writes to the current storage instance
  /// @param key - The key to be used to associate the value with
  /// @param value the value to be stored
  Future<void>  writeStorageValue(String key, String value);

  /// @dev deletes all key-values from the current storage instance
  void resetStorage();
}

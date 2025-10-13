class Constant {
  static const _isProduction = false;
  static const _isEmulator = false;

  static const _devApiEmulator = 'http://localhost:8080/api/v1';
  static const _devApiDevice = 'http://192.168.2.110:8080/api/v1';
  static const _prodApi = 'https://yourapp.onrender.com/api/v1';

  static String get api {
    if (_isProduction) return _prodApi;
    return _isEmulator ? _devApiEmulator : _devApiDevice;
  }

  static String get barcode => '$api/public/barcodes';
}


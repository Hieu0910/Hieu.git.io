import '../services/api_service.dart';

class forgotRepository {
  final Apiservice api = Apiservice();
  Future<bool> forgotPassword(String email) async {
    final response = await api.forgotPassword(email);
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }
}

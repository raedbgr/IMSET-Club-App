import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    // Add other dependencies if needed
  }
}

import 'package:get/get.dart';
import 'package:krishna_gaushala/app/Network/services/dashboard_service/dashboard_service.dart';
import 'package:krishna_gaushala/app/Screens/dashboard_screen/dashboard_model/get_types_model.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;

  List<Data> tabsList = [];

  @override
  void onInit() async {
    super.onInit();
    await getTypesApi();
  }

  Future<void> getTypesApi() async {
    try {
      isLoading(true);
      final response = await DashboardService().getTypesApiService();
      if (response?.code == '200') {
        tabsList = response?.data ?? [];
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}

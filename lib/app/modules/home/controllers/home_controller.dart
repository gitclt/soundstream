import 'package:get/get.dart';

class HomeController extends GetxController {

 var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }
 
  final List<String> option = [
    'All',
    'Speeches',
    ' Songs',
   
  ];
}

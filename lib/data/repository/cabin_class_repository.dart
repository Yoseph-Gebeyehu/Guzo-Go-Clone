import 'package:guzo_go_clone/data/model/cabin_class.dart';

abstract class CabinClassRepository {
  Future<void> addCabinClass(CabinClass cabinClass);
  Future<void> updateCabinClass(String cabin, CabinClass cabinClass);
  Future<List<CabinClass>> getCabinClasses();
}

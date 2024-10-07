import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/cabin_class.dart';
import 'package:guzo_go_clone/data/repository/cabin_class_repository.dart';
import '../../local/cabin_class_service.dart';

class CabinClassRepositoryImpl implements CabinClassRepository {
  CabinClassService cabinClassService = CabinClassService();
  BuildContext context;
  CabinClassRepositoryImpl({
    required this.context,
  });

  @override
  Future<void> addCabinClass(CabinClass cabinClass) async {
    await cabinClassService.addCabinClassToDB(cabinClass);
  }

  @override
  Future<void> updateCabinClass(String cabin, CabinClass cabinClass) async {
    await cabinClassService.updateCabinClassInDB(cabin, cabinClass);
  }

  @override
  Future<List<CabinClass>> getCabinClasses() async {
    return await cabinClassService.getCabinClassFromDB();
  }
}

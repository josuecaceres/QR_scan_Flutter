import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provaider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    //Asingna el id de la base de datos al modelo
    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async {
    List<ScanModel>? scansQuery = await DBProvider.db.getAllScans();
    scans = [...scansQuery!];
    notifyListeners();
  }

  cargarScasnPorTipo(String tipo) async {
    List<ScanModel>? scansQuery = await DBProvider.db.getScansByType(tipo);
    scans = [...scansQuery!];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  Future<int> borrarTodos() async {
    int deleteNo = await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();

    return deleteNo;
  }

  borrarScasnPorId(int id) async {
    await DBProvider.db.deleteScanById(id);
  }
}

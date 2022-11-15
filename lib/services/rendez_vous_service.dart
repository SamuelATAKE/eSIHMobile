import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/RendezVous.dart';

Future<List<RendezVous>> getRdvs() async {
  ApiManager api = ApiManager.instance;
  List<RendezVous> patientrdvs = await api.getRendezVous();
  return patientrdvs;
}

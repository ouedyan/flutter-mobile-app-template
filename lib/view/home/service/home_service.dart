import 'package:vexana/vexana.dart';

abstract class IHomeService {
  final INetworkManager networkManager;
  IHomeService(this.networkManager);
}

class HomeService extends IHomeService {
  HomeService(super.networkManager);
}

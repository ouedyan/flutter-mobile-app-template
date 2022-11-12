import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_template/view/home/bloc/home_bloc.dart';
import 'package:flutter_mobile_template/view/home/service/home_service.dart';
import 'package:provider/provider.dart';
import 'package:vexana/vexana.dart';

import 'init/network/vexana_manager.dart';

class DependencyInjector {
  static DependencyInjector? _instance;

  static DependencyInjector get instance {
    _instance ??= DependencyInjector._init();
    return _instance!;
  }

  late final INetworkManager networkManager;
  late final IHomeService homeService;
  late final HomeBloc homeBloc;

  DependencyInjector._init() {
    networkManager = VexanaManager.instance.networkManager;
  }

  List<RepositoryProvider> get repositoryProviders => [
        RepositoryProvider<IHomeService>(create: (context) => homeService),
      ];

  List<BlocProvider<Bloc>> get globalBlocProviders => [
        BlocProvider<HomeBloc>(create: (context) => homeBloc),
      ];

  List<ChangeNotifierProvider<ChangeNotifier>> get otherProviders => [];
}

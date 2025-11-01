import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_user_bus_2_teste/app/core/app_constants/app_constants.dart';
import 'package:random_user_bus_2_teste/app/core/ui/extensions/ui.extensions.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_page_state.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = ModalRoute.of(context);
      if (route is PageRoute) {
        context.routeObserver.subscribe(this, route);
      }
    });
  }


  @override
  void didPopNext() {
    super.didPopNext();
    context.read<HomeViewModel>()
    ..fetchPerson()
    ..startTicker();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    final homePageViewModel = context.read<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Home page')),
      body: BlocConsumer<HomeViewModel, HomePageState>(
        listener: (context, state) {
          if (state.status == HomePageStatus.error) {
            context.showCustomSnackBar(
              message: "Erro ao buscar Usúario",
              isError: true,
            );
          }
          return;
        },
        builder: (context, child) {
          final HomePageState(:users, :message, :status, :resultUser) =
              homePageViewModel.state;
          return switch (status) {
            HomePageStatus.initial => Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Buscando dados...'),
                ],
              ),
            ),
            _ => SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.pictures[1]),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          onTap: () {
                            homePageViewModel.stopTicker();
                            navigator.pushNamed(AppConstants.ROUTER_DETAIL_USER, arguments: user);
                          },
                        );
                      },
                    ),
                  ),
                  Offstage(
                    offstage: status != HomePageStatus.loading,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          };
        },
      ),
      floatingActionButton: BlocBuilder<HomeViewModel, HomePageState>(
        builder: (context, state) {
          return Offstage(
            offstage: state.status != HomePageStatus.success,
            child: FloatingActionButton(
              onPressed: () {
                homePageViewModel.stopTicker();
                navigator.pushNamed(AppConstants.ROUTER_USER_PERSISTED);
              },
              child: FaIcon(FontAwesomeIcons.database),
            ),
          );
        },
      ),
    );
  }
}

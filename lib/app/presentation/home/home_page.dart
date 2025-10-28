import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_user_bus_2_teste/app/core/ui/theme/app_theme.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_page_state.dart';
import 'package:random_user_bus_2_teste/app/presentation/home/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async { });
  }

  @override
  void dispose() {
    context.read<HomeViewModel>().dispose();
    log("Disposer chamado");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final homePageViewModel =  context.read<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Home page')),
      body:BlocBuilder<HomeViewModel,HomePageState>(
        bloc: homePageViewModel,
        builder: (context, child) {
          final HomePageState(:users, :message, :status, :resultUser) =
              homePageViewModel.state;
          return switch (status) {
            HomePageStatus.initial => Center(child: Text('Buscando dados')),

            HomePageStatus.error => Center(
              child: Text(message ?? 'Error ao buscar dados'),
            ),
            _ => SafeArea(
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: resultUser != null ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: resultUser != null
                        ? CardPerson(userResult: resultUser)
                        : SizedBox.shrink(),
                  ),
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
                            Navigator.of(
                              context,
                            ).pushNamed('/detail', arguments: user);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homePageViewModel.stopTicker();
          Navigator.of(context).pushNamed('/perstisteds');
        },
        child: FaIcon(FontAwesomeIcons.database),
      ),
    );
  }
}

class CardPerson extends StatelessWidget {
  final User userResult;
  const CardPerson({super.key, required this.userResult});

  @override
  Widget build(BuildContext context) {
    final TextTheme(:labelMedium) = AppTheme.theme.textTheme;
    final User(:name, :email, :pictures) = userResult;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  backgroundImage: NetworkImage(pictures[1]),
                ),
              ),
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  Text(name, style: labelMedium),
                ],
              ),
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.email),
                  Text(userResult.email, style: labelMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_user_bus_2_teste/app/data/datasource/rest_client.dart';
import 'package:random_user_bus_2_teste/app/data/repository/person_repository.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_page_state.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_view_model.dart';

class PersistedUsersPage extends StatefulWidget {
  const PersistedUsersPage({super.key});

  @override
  State<PersistedUsersPage> createState() => _PersistedUsersPageState();
}

class _PersistedUsersPageState extends State<PersistedUsersPage> {
   late RestClient restClient;
  late PersonRepository repositrory;
  late PersistedViewModel _persistedViewModel;
  

  @override
  void initState() {
    restClient = RestClient();
    repositrory = PersonRepository(restClient: restClient);
    _persistedViewModel = PersistedViewModel(personRepository: repositrory);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _persistedViewModel.fetchPerson();
    });
  }

  @override
  void dispose() {
    _persistedViewModel.dispose();
 
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
      

    return Scaffold(
      appBar: AppBar(title: const Text('Home page')),
      body: ListenableBuilder(
        listenable: _persistedViewModel,
        builder: (context, child) {
          final PersistedPageState(:users, :message, :status, ) = _persistedViewModel.state;
          return switch (status) {
            PersistedPageStatus.initial => Center(child: Text('Buscando dados')),

            PersistedPageStatus.error => Center(
              child: Text(message ?? 'Error ao buscar dados'),
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
                          trailing: IconButton(onPressed: (){
                            showConfirmDeleteUserDialog(context);
                          }, icon: FaIcon(FontAwesomeIcons.trashArrowUp)),
                          onTap: () {
                            
                            Navigator.of(
                              context,
                            ).pushNamed('/detail', arguments: user);
                          },
                        );
                      },
                    ),
                  ),
                  Offstage(
                    offstage: status != PersistedPageStatus.loading,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          };
        },
      ),
      
    );
  }

Future<bool?> showConfirmDeleteUserDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Remover usuário'),
        content: const Text('Tem certeza de que deseja remover o usuário?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remover'),
          ),
        ],
      );
    },
  );
}

}

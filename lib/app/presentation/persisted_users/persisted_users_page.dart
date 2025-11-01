import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_user_bus_2_teste/app/core/app_constants/app_constants.dart';
import 'package:random_user_bus_2_teste/app/core/ui/extensions/ui.extensions.dart';
import 'package:random_user_bus_2_teste/app/core/ui/theme/app_theme.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_page_state.dart';
import 'package:random_user_bus_2_teste/app/presentation/persisted_users/persisted_view_model.dart';

class PersistedUsersPage extends StatelessWidget {
  const PersistedUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final persistedVm = context.read<PersistedViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('User Persisteds')),
      body: BlocConsumer<PersistedViewModel,PersistedPageState>(
        listener: (context, state) {
          if (state.status == PersistedPageStatus.error) {
            context.showCustomSnackBar(
              message: "Erro ao buscar Usúario no banco ",
              isError: true
              );
          }
          return;
        },
      
        builder: (context, state) {
          final PersistedPageState(:users, :message, :status) =state;
          return switch (status) {
            PersistedPageStatus.loading ||
            PersistedPageStatus.initial => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  CircularProgressIndicator(),
                  Text('Buscando dados', style :AppTheme.theme.textTheme.bodySmall),
                ],
              ),
            ),
            _ => SafeArea(
              child: Visibility(
                replacement: Center(child: Text('Nenhum Usuário Persistido',style: AppTheme.theme.textTheme.labelMedium,)),
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
                      trailing: IconButton(
                        onPressed: () {
                          showConfirmDeleteUserDialog(context,user);
                        },
                        icon: FaIcon(FontAwesomeIcons.trashArrowUp),
                      ),
                      onTap: () async{
                      final removedUser = await navigator.pushNamed(AppConstants.ROUTER_DETAIL_USER, arguments: user) as User?;
                       if (removedUser !=null) {
                          persistedVm.findAll();
                       }
                      },
                    );
                  },
                ),
              ),
            ),
          };
        },
      ),
    );
  }

  Future<bool?> showConfirmDeleteUserDialog(BuildContext context,User user) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
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
              onPressed: () {
                context.read<PersistedViewModel>().removeUser(user);
                 Navigator.of(context).pop(true);
              },
              child: const Text('Remover'),
            ),
          ],
        );
      },
    );
  }
}

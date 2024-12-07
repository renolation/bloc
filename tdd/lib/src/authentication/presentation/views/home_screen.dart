import 'package:bloc_demo/main.dart';
import 'package:bloc_demo/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_demo/src/authentication/presentation/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(listener: (context, state) {
      if (state is AuthenticationError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is UserCreated) {
        getUsers();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: state is GettingUsers
            ? const LoadingColumn(message: 'Getting users ...')
            : state is CreatingUser
                ? const LoadingColumn(message: 'Creating user ...')
                : state is UsersLoaded
                    ? Center(child: ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index){
            final user = state.users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.createdAt),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar),
              ),
            );
          },
        ))
                    : const SizedBox.shrink(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context
                .read<AuthenticationCubit>()
                .createUser(createdAt: DateTime.now().toString(), name: 'name', avatar: 'avatar');
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}

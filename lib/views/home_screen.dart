import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_cubit/app_cubit.dart';
import 'package:todo/controller/cubit/cubit.dart';
import 'package:todo/controller/cubit/states.dart';
import 'package:todo/views/add_task_screen.dart';
import 'package:todo/views/drawer_screen.dart';
import 'package:todo/views/update_screen.dart';

// so now let's get these text from here... if there
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('My task'.tr()),
            elevation: 1,
            backgroundColor: Colors.deepOrange.shade200,
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<AppCubit>(context).changeThemeMode();
                },
                icon: Icon(
                  BlocProvider.of<AppCubit>(context).isDark ?
                  Icons.dark_mode : Icons.light_mode,
                ),
              ),
            ],
          ),
          drawer: const Drawer(
            child: DrawerScreen(),
          ),
          body: ConditionalBuilder(
            condition: state is! LoadingGetDataFromDatabaseState,
            fallback: (BuildContext context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (BuildContext context) {
              return (cubit.tasks.isNotEmpty)
                  ? ListView.builder(
                itemCount: cubit.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return UpdateTaskScreen(
                              id: cubit.tasks[index]['id'],
                              title: cubit.tasks[index]['title'],
                              date: cubit.tasks[index]['date'],
                              time: cubit.tasks[index]['time'],
                              des: cubit.tasks[index]['description'],
                            );
                          }));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.tasks[index]['title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge,
                                ),
                                Text(
                                  cubit.tasks[index]['time'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.deleteDataFromDatabase(
                                          id: cubit.tasks[index]['id']);
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                            Text(
                              cubit.tasks[index]['description'],
                              style:
                              Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.hourglass_empty),
                    Text(
                      'There is no tasks here'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.deepOrange),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return AddTaskScreen();
                  }));
            },
            // We finished now our Localization now ... thank you...
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
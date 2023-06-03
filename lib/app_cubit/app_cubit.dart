import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  bool isDark = false;
  static AppCubit get(context) => BlocProvider.of(context);
  AppCubit() : super(InitialAppState());

  void changeThemeMode({bool? darkMode}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (darkMode != null) {
      isDark = darkMode;
    } else {
      isDark = !isDark;
      sharedPreferences.setBool("isDark", isDark);
    }
    emit(ChangeAppModeState());
  }
}

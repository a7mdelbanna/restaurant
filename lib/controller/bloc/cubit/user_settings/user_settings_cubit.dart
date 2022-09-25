// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
//
// import '../../../config/theme.dart';
// import '../../../data/localservices/cache_local_services.dart';
//
// part 'user_settings_state.dart';
//
// class UserSettingsCubit extends Cubit<UserSettingsLoadedState> {
//   UserSettingsCubit()
//       : super(
//           UserSettingsLoadedState(
//             userTheme: CustomTheme.lightTheme,
//             itemShape: false,
//           ),
//         );
//
//   void getUserSettings() {
//     String? userTheme = CasheHelper.getData(key: 'userTheme');
//     if (userTheme == null) {
//       emit(state.copyWith(userTheme: CustomTheme.lightTheme));
//     }
//     if (userTheme == 'darkTheme') {
//       emit(state.copyWith(userTheme: CustomTheme.darkTheme));
//     } else {
//       emit(state.copyWith(userTheme: CustomTheme.lightTheme));
//     }
//   }
//
//   void setUserSettings() {}
//   void toggleTheme(ThemeData newTheme) {
//     if (newTheme == CustomTheme.darkTheme) {
//       CasheHelper.putData(key: 'userTheme', value: 'darkTheme');
//     } else {
//       CasheHelper.putData(key: 'userTheme', value: 'lightTheme');
//     }
//
//     emit(state.copyWith(userTheme: newTheme));
//   }
//
//   void toggleItemShape(bool shape) {
//     emit(state.copyWith(
//       itemShape: shape,
//     ));
//   }
// }

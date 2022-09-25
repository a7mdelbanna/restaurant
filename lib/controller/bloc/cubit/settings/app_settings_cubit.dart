// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//
// import '../../../data/model/settings_model.dart';
// import '../../../data/repositories/settings_repository.dart';
//
// part 'app_settings_state.dart';
//
// class AppSettingsCubit extends Cubit<AppSettingsState> {
//   Map<String, String> groupsVal = {
//     'noGroups': '0',
//     'groupedByCategory': '1',
//     'groupedByCompany': '2',
//   };
//   Map<String, String> showImageVal = {
//     'showImage': '0',
//     'noImage': '1',
//   };
//   Map<String, String> showItemBalanceVal = {
//     'showBalance': '0',
//     'noBalance': '1',
//   };
//   Map<String, String> useItemTaxVal = {
//     'useTax': '0',
//     'noTax': '1',
//   };
//   Map<String, String> useItemVatVal = {
//     'useVat': '0',
//     'noVat': '1',
//   };
//   Map<String, String> acceptGreaterQuantityThanBalanceVal = {
//     'accept': '0',
//     'decline': '1',
//   };
//   Map<String, String> showItemsWithBalanceOnlyVal = {
//     'itemsWithBalanceOnly': '1',
//     'allItems': '0',
//   };
//   Map<String, String> showCartPricesVal = {
//     'showPrices': '0',
//     'noPrices': '1',
//   };
//   Map<String, String> useUserPricesVal = {
//     'useUserPrices': '1',
//     'normalPrices': '0',
//   };
//   late final SettingsRepository settingsRepository;
//   AppSettingsCubit(this.settingsRepository) : super(AppSettingsInitial());
//   late List<SettingsConfig> settings = [];
//   void getAllSettings() async {
//     try {
//       settings = await settingsRepository.getAllSettings();
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   groupedBy() {
//
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '120');
//     print(settingsConfig.configValue);
//     settingsConfig.configValue == groupsVal['noGroups']
//         ? emit(NoGroupsState())
//         : settingsConfig.configValue == groupsVal['groupedByCategory']
//             ? emit(GroupedByCategoryState())
//             : emit(GroupedByCompanyState());
//   }
//
//   showImage() {
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '230');
//     return settingsConfig.configValue == showImageVal['showImage']
//         ? true
//         : false;
//   }
//
//   useItemTax() {
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '220');
//     return settingsConfig.configValue == useItemTaxVal['useTax'] ? true : false;
//   }
//
//   useItemVat() {
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '210');
//     return settingsConfig.configValue == useItemVatVal['useVat'] ? true : false;
//   }
//
//   showItemBalance() {
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '150');
//     return settingsConfig.configValue == showItemBalanceVal['showBalance']
//         ? true
//         : false;
//   }
//
//   showCartPrices() {
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '200');
//     return settingsConfig.configValue == showItemBalanceVal['showPrices']
//         ? true
//         : false;
//   }
//
//   acceptAnyQuantity() {
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '140');
//     return settingsConfig.configValue ==
//             acceptGreaterQuantityThanBalanceVal['accept']
//         ? true
//         : false;
//   }
//
//   useUserPrices() {
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '110');
//     return settingsConfig.configValue == useUserPricesVal['useUserPrices']
//         ? true
//         : false;
//   }
//
//   showItemsWithBalanceOnly() {
//     SettingsConfig settingsConfig;
//     settingsConfig =
//         settings.firstWhere((element) => element.configSerial == '140');
//     return settingsConfig.configValue ==
//             showItemsWithBalanceOnlyVal['itemsWithBalanceOnly']
//         ? true
//         : false;
//   }
// }

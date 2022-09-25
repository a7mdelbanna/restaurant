// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:wholesaleproject/data/repositories/offers_repository.dart';
//
// import '../../../data/model/item_model.dart';
// import '../../../data/model/offer_model.dart';
//
// part 'offers_state.dart';
//
// class OffersCubit extends Cubit<OffersState> {
//   final OffersRepository offersRepository;
//   late List<Offer> offers = [
//     Offer(
//         desc: 'عرض رمضان',
//         endDate: '10/03/2022',
//         startDate: '10/03/2022',
//         offerType: 1,
//         active: true,
//         offerItems: [
//           OfferItem(
//               itemCode: '02154879623258',
//               itemDisc: 4,
//               itemPrice: 20,
//               quantity: 3,
//               itemUnit: ItemUnit(1, '17', 'قطعة', 20 + 0.0)),
//           OfferItem(
//               itemCode: '0248625478365',
//               itemDisc: 3,
//               itemPrice: 20,
//               quantity: 2,
//               itemUnit: ItemUnit(1, '17', 'قطعة', 40 + 0.0))
//         ],
//         id: 'asdasdasd',
//         title: 'asdsadadas')
//   ];
//   OffersCubit(this.offersRepository) : super(OffersInitial());
//   void getAllOffers() {
//     try {
//       emit(OffersLoadingState());
//
//       offersRepository.getAllOffers().then((offers) {
//         emit(OffersLoadedState(this.offers));
//         // this.offers = offers;
//       });
//     } catch (e) {
//       emit(OffersErrorState(e.toString()));
//     }
//   }
//
//   double checkIfItemExistInOffer(String itemCode) {
//     for (Offer element in offers) {
//       print(element.offerItems.length);
//       print(itemCode);
//       print(element.offerItems.first.itemCode);
//       if (element.active!) {
//         for (OfferItem offerItem in element.offerItems) {
//           if (offerItem.itemCode == itemCode) {
//             print('itemCodeTrueInsideIfItemInOfferCubit');
//             print(offerItem.itemDisc);
//             return offerItem.itemDisc;
//           }
//         }
//       }
//     }
//     return 0.0;
//   }
//
//   List<String> getOffersItemsCodes() {
//     List<String> offerItemsCodes = [];
//     for (Offer offer in offers) {
//       if (offer.active!) {
//         for (OfferItem offerItem in offer.offerItems) {
//           offerItemsCodes.add(offerItem.itemCode);
//           print(offerItem.itemCode);
//         }
//       }
//     }
//     return offerItemsCodes;
//   }
// }

import '../model/offer_model.dart';
import '../webservices/offers_web_services.dart';

class OffersRepository {
  OffersWebServices offersWebServices;

  OffersRepository(this.offersWebServices);

  Future<List<Offer>> getAllOffers() async {
    try {
      final offers = await offersWebServices.getAllOffersFirebaseSDK();

      List<Offer> loadedOffers = [];
      List<OfferItem> offerItems = [];
      OfferItem offerItem;
      Offer tempOffer;
      if (offers == null) {
        return [];
      }
      offers.forEach((offerId, offer) {
        offer.forEach((key, value) {
          if (key == "offerItems") {
            offerItem = OfferItem.fromJson(value);
            offerItems.add(offerItem);
          }
        });
        tempOffer = Offer(
            offerType: 1,
            id: offerId,
            active: offer['active'],
            startDate: offer['starts'],
            title: offer['offerTitle'],
            endDate: offer['ends'],
            desc: offer['offerDesc'],
            offerItems: offerItems);

        loadedOffers.add(tempOffer);
      });
      return loadedOffers;
    } catch (e) {
      print('errrororororo');
      return [];
    }
  }
}

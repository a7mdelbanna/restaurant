class CustomTopping {
  late String toppingTitle;
  late String toppingId;
  late String toppingImageUrl;
  late List<ToppingSize> toppingSizes;
  CustomTopping({
    required this.toppingTitle,
    required this.toppingSizes,
    required this.toppingId,
    required this.toppingImageUrl,
  });
  CustomTopping.fromJson(Map<dynamic, dynamic> json) {
    toppingImageUrl = json['toppaingImageUrl'];
    toppingTitle = json['toppaingTitle'];
    toppingSizes = formatSizes(json['toppingSizes']);
    toppingId = json['toppingId'];
  }
}

class ToppingSize {
  ToppingSize({
    required this.sizeId,
    required this.sizeName,
    required this.sizePrice,
  });

  late String sizeId;
  late String sizeName;
  late double sizePrice;
  ToppingSize.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    sizeName = json['sizeName'];
    sizePrice = json['sizePrice'];
  }
}

List<ToppingSize> formatSizes(value) {
  List<ToppingSize> toppingSizes = [];
  if (value != null) {
    value.forEach((unitName, unit) {
      ToppingSize toppingSize = ToppingSize(
          sizeId: unit['sizeId'],
          sizeName: unit['sizeName'],
          sizePrice: unit['sizePrice']);

      toppingSizes.add(toppingSize);
    });
  }

  // print(units.length.toString());
  return toppingSizes;
}

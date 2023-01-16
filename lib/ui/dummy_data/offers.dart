class Offers {
  final int id;
  final String name;
  final String image;
  final String discount;
  final String oldPrice;
  final String newPrice;

  const Offers({required this.id, required this.name, required this.image, required this.discount, required this.oldPrice, required this.newPrice});
}

class OffersList {
  static List<Offers> list() {
    const data = <Offers> [
      Offers(
        id: 1,
        name: 'Hair cut',
        image: 'assets/images/services/1.png',
        discount: '20',
        oldPrice: '200',
        newPrice: '160',
      ),
      Offers(
          id: 2,
          name: 'Facial',
          image: 'assets/images/services/2.png',
          discount: '20',
        oldPrice: '200',
        newPrice: '160',
      ),
      Offers(
          id: 3,
          name: 'hair Treatment',
          image: 'assets/images/services/3.png',
          discount: '15',
        oldPrice: '100',
        newPrice: '85',
      ),
      Offers(
          id: 4,
          name: 'Makeup',
          image: 'assets/images/services/4.png',
          discount: '30',
        oldPrice: '100',
        newPrice: '70',
      ),
      Offers(
          id: 5,
          name: 'Spa',
          image: 'assets/images/services/3.png',
          discount: '10',
        oldPrice: '50',
        newPrice: '45',
      ),
      Offers(
          id: 6,
          name: 'Body Message',
          image: 'assets/images/services/4.png',
          discount: '50',
        oldPrice: '150',
        newPrice: '75',
      ),
    ];
    return data;
}
}
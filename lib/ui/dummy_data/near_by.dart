class NearBy {
  final int id;
  final String name;
  final String image;
  final String location;
  final String rating;
  final String status;

  const NearBy({required this.id,required  this.name, required this.image, required this.location, required this.rating, required this.status});
}

class NearByList {
  static List<NearBy> list() {
    const data = <NearBy> [
      NearBy(
        id: 1,
        name: 'Modern Beauty Parlour',
        image: 'assets/images/nearby/1.png',
        location: 'Captown City',
        rating: '4.0',
        status: 'open'
      ),
      NearBy(
        id: 2,
        name: 'Beauty Girls',
        image: 'assets/images/nearby/2.png',
        location: 'Montan Plaza',
        rating: '4.5',
        status: 'close'
      ),
    ];
    return data;
}
}
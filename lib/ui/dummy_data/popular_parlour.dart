class PopularParlour {
  final int id;
  final String name;
  final String image;
  final String location;
  final String rating;
  final String reviews;
  final String status;
  final String open;

  const PopularParlour({required this.id, required this.name, required this.image, required this.location, required this.rating, required this.reviews,
    required   this.status,required  this.open});

}

class PopularParlourList {
  static List<PopularParlour> list() {
    const data = <PopularParlour> [
      PopularParlour(
        id: 1,
        name: 'سيارة قديمة بعرض الطريق',
        image: 'assets/images/popular_parlour/1.png',
        location: 'الطرق العامة',
        rating: '5.0',
        reviews: '120',
        status: 'open',
        open: '9.00am - 7.00pm'
      ),
      PopularParlour(
        id: 2,
        name: 'نفايات متراكمه منذ شهر',
        image: 'assets/images/popular_parlour/2.png',
        location: 'النظافة العامة',
        rating: '4.5',
          reviews: '25',
        status: 'open',
          open: '8.00am - 10.00pm'
      ),
      PopularParlour(
        id: 3,
        name: 'صوت عالي ومزعج',
        image: 'assets/images/popular_parlour/3.png',
        location: 'السلوكيات العامة',
        rating: '5.0',
          reviews: '547',
        status: 'Close',
          open: '10.00am - 6.00pm'
      ),
    ];
    return data;
}
}
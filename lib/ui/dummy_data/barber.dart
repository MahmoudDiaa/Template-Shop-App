class Barber {
  final int id;
  final String name;
  final String image;
  final String specialist;
  final String rating;
  final String reviews;

  const Barber({required this.id, required this.name, required this.image, required this.specialist, required this.rating, required this.reviews});
}

class BarberList {
  static List<Barber> list() {
    const data = <Barber> [
      Barber(
        id: 1,
        name: 'Robert Jonson',
        image: 'assets/images/barber/1.png',
        specialist: 'Spa & Skin Specialist',
        rating: '4.0',
        reviews: '120'
      ),
      Barber(
          id: 2,
          name: 'Markal Hums',
          image: 'assets/images/barber/2.png',
          specialist: 'Body & Skin Specialist',
          rating: '5.0',
          reviews: '120'
      ),
      Barber(
          id: 3,
          name: 'Lifsa Zuli',
          image: 'assets/images/barber/3.png',
          specialist: 'Hair Specialist',
          rating: '4.0',
          reviews: '120'
      ),
      Barber(
          id: 4,
          name: 'Washin Tomas',
          image: 'assets/images/barber/4.png',
          specialist: 'Message Specialist',
          rating: '5.0',
          reviews: '52'
      ),
    ];
    return data;
}
}
class ManCategoryList {
  static List<Barber> list() {
    const data = <Barber> [
      Barber(
          id: 1,
          name: 'cat1',
          image: 'assets/images/barber/1.png',
          specialist: 'حفر الشوارع',
          rating: '4.0',
          reviews: '120'
      ),
      // Barber(
      //     id: 2,
      //     name: 'Markal Hums',
      //     image: 'assets/images/barber/2.png',
      //     specialist: 'Body & Skin Specialist',
      //     rating: '5.0',
      //     reviews: '120'
      // ),
      // Barber(
      //     id: 3,
      //     name: 'Lifsa Zuli',
      //     image: 'assets/images/barber/3.png',
      //     specialist: 'Hair Specialist',
      //     rating: '4.0',
      //     reviews: '120'
      // ),
      // Barber(
      //     id: 4,
      //     name: 'Washin Tomas',
      //     image: 'assets/images/barber/4.png',
      //     specialist: 'Message Specialist',
      //     rating: '5.0',
      //     reviews: '52'
      // ),
    ];
    return data;
  }
}
class Review {
  final int id;
  final String name;
  final String image;
  final String time;
  final String rating;
  final String comment;

  const Review({required this.id,required  this.name, required this.image, required this.time,required  this.rating,required  this.comment});
}

class ReviewList {
  static List<Review> list() {
    const data = <Review> [
      Review(
        id: 1,
        name: 'Jonson Wiliam',
        image: 'assets/images/barber/1.png',
        time: '1',
        rating: '5',
        comment: 'Contrary to popular besimp and world class lyrandom text. It has roots',
      ),
      Review(
          id: 2,
          name: 'Shikha Melaine',
          image: 'assets/images/barber/2.png',
          time: '2',
        rating: '4',
        comment: 'Contrary to popular besimp and world class lyrandom text. It has roots',
      ),
      Review(
          id: 3,
          name: 'Fiza Kubila',
          image: 'assets/images/barber/3.png',
          time: '7',
        rating: '5',
        comment: 'Contrary to popular besimp and world class lyrandom text. It has roots',
      ),
    ];
    return data;
}
}
class PopularCategory {
  final int id;
  final String name;
  final String image;
  final String places;

  const PopularCategory({required this.id, required this.name,required  this.image,required  this.places});
}

class PopularCategoryList {
  static List<PopularCategory> list() {
    const data = <PopularCategory> [
      PopularCategory(
        id: 1,
        name: 'النظافة العامة',
        image: 'assets/images/popular_category/1.png',
        places: '78',
      ),
      PopularCategory(
        id: 2,
        name: 'الطرق العامة',
        image: 'assets/images/popular_category/2.png',
        places: '82',
      ),
      PopularCategory(
        id: 3,
        name: 'الضوضاء',
        image: 'assets/images/popular_category/3.png',
        places: '52',
      ),

    ];
    return data;
}
}
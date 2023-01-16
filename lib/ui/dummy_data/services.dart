class Services {
  final int id;
  final String name;
  final String image;
  final String service;
  final List<String> serviceList;

  const Services({required this.id,required  this.name,required  this.image,required  this.service,required  this.serviceList});
}

class ServicesList {
  static List<Services> list() {
    const data = <Services> [
      Services(
        id: 1,
        name: 'Hair cut',
        image: 'assets/images/services/1.png',
        service: '20',
        serviceList: ['Styles', 'Trending', 'Modern', 'Casual'],

      ),
      Services(
          id: 2,
          name: 'Facial',
          image: 'assets/images/services/2.png',
          service: '20',
        serviceList: ['Style', 'Trendings', 'Modern', 'Casual'],
      ),
      Services(
          id: 3,
          name: 'hair Treatment',
          image: 'assets/images/services/3.png',
          service: '15',
        serviceList: ['Style', 'Trending', 'Moderns', 'Casual'],
      ),
      Services(
          id: 4,
          name: 'Makeup',
          image: 'assets/images/services/4.png',
          service: '30',
        serviceList: ['Style', 'Trending', 'Modern', 'Casuals'],
      ),
      Services(
          id: 5,
          name: 'Spa',
          image: 'assets/images/services/3.png',
          service: '7',
        serviceList: ['Styles', 'Trending', 'Modern', 'Casual'],
      ),
      Services(
          id: 6,
          name: 'Body Message',
          image: 'assets/images/services/4.png',
          service: '9',
        serviceList: ['Style', 'Trendings', 'Modern', 'Casual'],
      ),
    ];
    return data;
}
}
class SubCategoryList {
  static List<Services> list() {
    const data = <Services> [
      Services(
        id: 1,
        name: 'sub cat 1',
        image: 'assets/images/services/1.png',
        service: '20',
        serviceList: ['Style', 'Trending', 'Modern', 'Casuals'],

      ),
      // Services(
      //   id: 2,
      //   name: 'Facial',
      //   image: 'assets/images/services/2.png',
      //   service: '20',
      //   serviceList: ['Style', 'Trendings', 'Modern', 'Casual'],
      // ),
      // Services(
      //   id: 3,
      //   name: 'hair Treatment',
      //   image: 'assets/images/services/3.png',
      //   service: '15',
      //   serviceList: ['Style', 'Trending', 'Moderns', 'Casual'],
      // ),
      // Services(
      //   id: 4,
      //   name: 'Makeup',
      //   image: 'assets/images/services/4.png',
      //   service: '30',
      //   serviceList: ['Style', 'Trending', 'Modern', 'Casuals'],
      // ),
      // Services(
      //   id: 5,
      //   name: 'Spa',
      //   image: 'assets/images/services/3.png',
      //   service: '7',
      //   serviceList: ['Styles', 'Trending', 'Modern', 'Casual'],
      // ),
      // Services(
      //   id: 6,
      //   name: 'Body Message',
      //   image: 'assets/images/services/4.png',
      //   service: '9',
      //   serviceList: ['Style', 'Trendings', 'Modern', 'Casual'],
      // ),
    ];
    return data;
  }
}
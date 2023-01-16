class Slot {
  final int id;
  final String time;
  final bool isAvailable;

  const Slot({required this.id, required this.time,required  this.isAvailable});

}

class SlotList {
  static List<Slot> list() {
    const data = <Slot> [
      Slot(
        id: 1,
        time: '8:00 am',
        isAvailable: true
      ),
      Slot(
          id: 2,
          time: '9:00 am',
          isAvailable: false
      ),
      Slot(
          id: 3,
          time: '10:00 am',
          isAvailable: false
      ),
      Slot(
          id: 4,
          time: '11:00 am',
          isAvailable: false
      ),
      Slot(
          id: 5,
          time: '12:00 pm',
          isAvailable: true
      ),
      Slot(
          id: 6,
          time: '1:00 pm',
          isAvailable: false
      ),
      Slot(
          id: 7,
          time: '2:00 pm',
          isAvailable: true
      ),
      Slot(
          id: 8,
          time: '3:00 pm',
          isAvailable: false
      ),
      Slot(
          id: 9,
          time: '4:00 pm',
          isAvailable: false
      ),
      Slot(
          id: 10,
          time: '5:00 pm',
          isAvailable: false
      ),
      Slot(
          id: 11,
          time: '6:00 pm',
          isAvailable: true
      ),
      Slot(
          id: 12,
          time: '7:00 pm',
          isAvailable: false
      ),
    ];
    return data;
  }

}
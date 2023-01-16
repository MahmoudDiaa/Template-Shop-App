class Message {
  final int id;
  final String type;
  final String name;
  final String text;
  final String time;

  const Message(
      {required this.id,
      required this.type,
      required this.name,
      required this.text,
      required this.time});
}

class MessageList {
  static List<Message> list() {
    const data = <Message>[
      Message(
          id: 1,
          text: 'hi',
          type: 'sender',
          name: 'Harison Max',
          time: '5.10 pm'),
      Message(
          id: 2,
          text: 'hello',
          type: 'receiver',
          time: '5.10 pm',
          name: 'name!'),
      Message(
          id: 3,
          text: 'Hi! Sir we accept your request for your services.',
          type: 'sender',
          name: 'Harison Max',
          time: '5.20 pm'),
      Message(id: 4, text: 'Thanks', type: 'receiver', time: '5.20 pm',name: 'name!'),
      Message(
          id: 5,
          text:
              'Hello! Yes I get invoice form your salon , I will come next day.',
          type: 'sender',
          name: 'Harison Max',
          time: '5.30 pm'),
      Message(
          id: 6,
          text: 'Thanks sir you have a good day ',
          type: 'receiver',
          time: '5.33 pm',name: 'name!'),
      Message(
          id: 7,
          text: 'Come to here Again',
          type: 'sender',
          name: 'Harison Max',
          time: '5.45 pm'),
      Message(id: 8, text: 'Sure', type: 'receiver', time: '5.47 pm',name: 'name!'),
    ];
    return data;
  }
}

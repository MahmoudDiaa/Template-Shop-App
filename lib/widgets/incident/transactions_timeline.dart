import 'package:boilerplate/constants/enums.dart';
import 'package:boilerplate/models/incident/transaction/incident_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

import '../../models/incident/incident.dart';
import '../../stores/language/language_store.dart';

const kTileHeight = 50.0;

class IncidentTransactionTimeline extends StatelessWidget {
  final Incident incident;

  IncidentTransactionTimeline({required this.incident});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          final data = _data(index + 1, incident);
          return Center(
            child: Container(
              width: 360.0,
              child: Card(
                //margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text(
                            //'Delivery #${orderInfo.id}',
                            'Created:',

                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${data.incident.createDate!.day}/${data.incident.createDate!.month}/${data.incident.createDate!.year}',
                            style: TextStyle(
                              color: Color(0xffb6b2b2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1.0),
                    _DeliveryProcesses(
                        transactions: data.incident.transactions),
                    Divider(height: 1.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _OnTimeBar(
                          driver: data.driverInfo, incident: incident),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrderTitle extends StatelessWidget {
  const _OrderTitle({
    Key? key,
    required this.orderInfo,
  }) : super(key: key);

  final _OrderInfo orderInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Delivery #${orderInfo.id}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          '${orderInfo.date.day}/${orderInfo.date.month}/${orderInfo.date.year}',
          style: TextStyle(
            color: Color(0xffb6b2b2),
          ),
        ),
      ],
    );
  }
}

class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    required this.messages,
  });

  final List<_DeliveryMessage> messages;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == messages.length + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                thickness: 1.0,
              ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                size: 10.0,
                position: 0.5,
              ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
              !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
          startConnectorBuilder: (_, index) => Connector.solidLine(),
          endConnectorBuilder: (_, index) => Connector.solidLine(),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(messages[index - 1].toString()),
            );
          },
          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
          nodeItemOverlapBuilder: (_, index) =>
              isEdgeIndex(index) ? true : null,
          itemCount: messages.length + 2,
        ),
      ),
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  _DeliveryProcesses({Key? key, required this.transactions}) : super(key: key);

  List<IncidentTransaction> transactions;
  late LanguageStore _languageStore;

  @override
  Widget build(BuildContext context) {
    _languageStore = Provider.of<LanguageStore>(context);

    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Color(0xff989898),
            indicatorTheme: IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: transactions.length,
            contentsBuilder: (_, index) {
              //if (processes[index].isCompleted) return null;

              return Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      transactions[index].localizedIncidentStatusName(
                              _languageStore.locale) ??
                          '',
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18.0,
                          ),
                    ),
                    // Text(
                    //   processes[index].createdDate.toString(),
                    //   style: DefaultTextStyle.of(context).style.copyWith(
                    //         fontSize: 18.0,
                    //       ),
                    // ),
                    _InnerTimeline(messages: [
                      _DeliveryMessage(transactions[index].createdDate!, ''),
                      _DeliveryMessage(
                          transactions[index].userFullName ?? '--', '')
                    ]),
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (transactions[index]
                      .localizedIncidentStatusName(_languageStore.locale) ==
                  "Solved") {
                return DotIndicator(
                  color: Color(0xff66c97f),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              } else {
                return OutlinedDotIndicator(
                  borderWidth: 2.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: transactions[index]
                          .localizedIncidentStatusName(_languageStore.locale) ==
                      "Solved Initially"
                  ? Color(0xff66c97f)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _OnTimeBar extends StatelessWidget {
  final Incident incident;

  _OnTimeBar({Key? key, required this.driver, required this.incident})
      : super(key: key);

  final _DriverInfo driver;
  late LanguageStore _languageStore;

  @override
  Widget build(BuildContext context) {
    _languageStore = Provider.of<LanguageStore>(context);

    return Row(
      children: [
        MaterialButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('On-time!'),
              ),
            );
          },
          elevation: 0,
          shape: StadiumBorder(),
          color: Color(0xff66c97f),
          textColor: Colors.white,
          child: Text(
            incident.transactions.last
                    .localizedIncidentStatusName(_languageStore.locale) ??
                '',
            style: TextStyle(fontSize: 10),
          ),
        ),
        Spacer(),
        Text(
          '${'Last'}\n${driver.name}',
          textAlign: TextAlign.center,
        ),
        SizedBox(width: 12.0),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                driver.thumbnailUrl,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

_OrderInfo _data(int id, Incident incident) => _OrderInfo(
      id: id,
      date: DateTime.now(),
      incident: incident,
      driverInfo: _DriverInfo(
        name: incident.transactions.last.userFullName ?? '--',
        thumbnailUrl:
            'https://img.icons8.com/ios-glyphs/344/user-male-circle.png',
      ),
      deliveryProcesses: [
        _DeliveryProcess(
          'Package Process',
          messages: [
            _DeliveryMessage('8:30am', 'Package received by driver'),
            _DeliveryMessage('11:30am', 'Reached halfway mark'),
          ],
        ),
        _DeliveryProcess(
          'In Transit',
          messages: [
            _DeliveryMessage('13:00pm', 'Driver arrived at destination'),
            _DeliveryMessage('11:35am', 'Package delivered by m.vassiliades'),
          ],
        ),
        _DeliveryProcess.complete(),
      ],
    );

class _OrderInfo {
  final Incident incident;

  const _OrderInfo({
    required this.incident,
    required this.id,
    required this.date,
    required this.driverInfo,
    required this.deliveryProcesses,
  });

  final int id;
  final DateTime date;
  final _DriverInfo driverInfo;
  final List<_DeliveryProcess> deliveryProcesses;
}

class _DriverInfo {
  const _DriverInfo({
    required this.name,
    required this.thumbnailUrl,
  });

  final String name;
  final String thumbnailUrl;
}

class _DeliveryProcess {
  const _DeliveryProcess(
    this.name, {
    this.messages = const [],
  });

  const _DeliveryProcess.complete()
      : this.name = 'Done',
        this.messages = const [];

  final String name;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => name == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message);

  final String createdAt; // final DateTime createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt \n $message';
  }
}

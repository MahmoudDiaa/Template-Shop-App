import 'package:boilerplate/models/incident/incident.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../constants/enums.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../stores/incident_form/incident_form_store.dart';
import '../../ui/sdad/incident_sdad_screen.dart';
import '../../utils/locale/app_localization.dart';

class MqawelActionButtons extends StatefulWidget {
  final Incident incident;

  // void Function()? onSdadTab;
  void Function(bool)? onSdadDone;

  MqawelActionButtons({
    Key? key,
    required this.incident,
    // this.onSdadTab,
    this.onSdadDone,
  }) : super(key: key);

  @override
  State<MqawelActionButtons> createState() => _MqawelActionButtonsState();
}

class _MqawelActionButtonsState extends State<MqawelActionButtons> {
  late IncidentFormStore _incidentFormStore;
  SharedPreferenceHelper? sharedPreferenceHelper;

  @override
  void didChangeDependencies() {
    _incidentFormStore = Provider.of<IncidentFormStore>(context);
    sharedPreferenceHelper = GetIt.instance<SharedPreferenceHelper>();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return (sharedPreferenceHelper?.authUser?.user?.isMqawel == true &&

        (widget.incident.incidentStatusId == IncidentStatusEnum.Assigned.id ||
        widget.incident.incidentStatusId == IncidentStatusEnum.Upped.id)

    )


        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  _incidentFormStore.incident = widget.incident;
                  _incidentFormStore.incident.notes = '';

                  var result =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => IncidentSdadScreen(),
                  ));

                  if (result == true && widget.onSdadDone != null)
                    widget.onSdadDone!(result);
                },
                child: Text(
                    '${AppLocalizations.of(context).translate('incidentSdsd')}'),
              ),
            ],
          )
        : Container();
  }
}

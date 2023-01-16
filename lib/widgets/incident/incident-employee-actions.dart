import 'package:boilerplate/models/incident/incident.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../constants/enums.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../stores/incident_form/incident_form_store.dart';
import '../../ui/sdad/incident_finally_sdad_screen.dart';
import '../../ui/sdad/incident_sdad_screen.dart';
import '../../ui/sdad/incident_upping_sdad_screen.dart';
import '../../utils/locale/app_localization.dart';

class EmplyeeActionButtons extends StatefulWidget {
  final Incident incident;

  // void Function()? onSdadTab;
  void Function(bool)? onFinallySdadDone;
  void Function(bool)? onUppingSdadDone;

  EmplyeeActionButtons({
    Key? key,
    required this.incident,
    // this.onSdadTab,
    this.onFinallySdadDone,
    this.onUppingSdadDone,
  }) : super(key: key);

  @override
  State<EmplyeeActionButtons> createState() => _EmplyeeActionButtonsState();
}

class _EmplyeeActionButtonsState extends State<EmplyeeActionButtons> {
  late IncidentFormStore _incidentFormStore;
  SharedPreferenceHelper? sharedPreferenceHelper;

  @override
  void didChangeDependencies() {
    sharedPreferenceHelper = GetIt.instance<SharedPreferenceHelper>();
    _incidentFormStore = Provider.of<IncidentFormStore>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return (sharedPreferenceHelper?.authUser?.user?.isIncidentEmployee ==
                true &&
            widget.incident.incidentStatusId ==
                IncidentStatusEnum.SolvedInitially.id)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  _incidentFormStore.incident = widget.incident;
                  _incidentFormStore.incident.notes = '';

                  var result =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => IncidentFinallySdadScreen(),
                  ));

                  if (result == true && widget.onFinallySdadDone != null)
                    widget.onFinallySdadDone!(result);
                },
                child: Text(
                    '${AppLocalizations.of(context).translate('incidentFinish')}'),
              ),
              TextButton(
                onPressed: () async {
                  _incidentFormStore.incident = widget.incident;
                  _incidentFormStore.incident.notes = '';
                  var result =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => IncidentUppingSdadScreen(),
                  ));

                  if (result == true && widget.onUppingSdadDone != null)
                    widget.onUppingSdadDone!(result);
                },
                child: Text(
                    '${AppLocalizations.of(context).translate('incidentUpping')}'),
              ),
            ],
          )
        : Container();
  }
}

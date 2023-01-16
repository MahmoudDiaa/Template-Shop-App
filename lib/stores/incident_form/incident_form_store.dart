import 'package:boilerplate/models/incident/incident.dart';
import 'package:boilerplate/models/subcategory/subcategory.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../../constants/enums.dart';
import '../../data/respository/incident_repository.dart';
import '../../models/category/category.dart';

part 'incident_form_store.g.dart';

class IncidentFormStore = _IncidentFormStore with _$IncidentFormStore;

abstract class _IncidentFormStore with Store {
  // store for handling form errors
  final IncidentFormErrorStore formErrorStore = IncidentFormErrorStore();

  // repository instance
  final IncidentRepository _incidentrepository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _IncidentFormStore(this._incidentrepository) {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => incident, validateIncident),
      reaction((_) => incident, validateIncidentTakeAction),

      // reaction((_) => password, validatePassword),
      // reaction((_) => confirmPassword, validateConfirmPassword)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  Incident incident = Incident();

  @computed
  bool get isStep1IsOk => incident.categoryId != null;

  @observable
  bool saved = false;

  @observable
  bool loading = false;

  @computed
  bool get canSubmit => !formErrorStore.hasErrorsInSubmit;

  @computed
  bool get canSubmitTakeAction => !formErrorStore.hasErrorsInSubmitAction;

  // actions:-------------------------------------------------------------------
  @action
  void setIncidentValue(Incident value) {
    incident = value;
    validateIncident(incident);
  }

  @action
  void setTakeActionIncidentValue(Incident value) {
    incident = value;
    validateIncidentTakeAction(incident);
  }

  //
  // @action
  // void setPassword(String value) {
  //   password = value;
  // }
  //
  // @action
  // void setConfirmPassword(String value) {
  //   confirmPassword = value;
  // }

  @action
  void validateIncident(Incident value) {
    if (value.categoryId == null) {
      formErrorStore.incidentErrorMessage = "Category is mandatory";
    } else if (value.subCategoryId == null) {
      formErrorStore.incidentErrorMessage = 'Sub category is mandatory';
    } else if (value.amountValue == null) {
      formErrorStore.incidentErrorMessage = 'Amount value is mandatory';
    } else if (value.notes == null || value.notes!.isEmpty) {
      formErrorStore.incidentErrorMessage = 'Notes is mandatory';
    } else if (value.priority == null) {
      formErrorStore.incidentErrorMessage = 'Priority is mandatory';
    } else {
      formErrorStore.incidentErrorMessage = null;
    }
  }

  @action
  void validateIncidentTakeAction(Incident value) {
    if (value.notes == null || value.notes?.isEmpty == true) {
      formErrorStore.incidentTakeActionErrorMessage = "Notes is mandatory.";
    } else {
      formErrorStore.incidentTakeActionErrorMessage = null;
    }
    if (value.xFiles.isEmpty) {
      formErrorStore.incidentTakeActionErrorMessage = "Images is must please.";
    } else {
      formErrorStore.incidentTakeActionErrorMessage = null;
    }
  }

  @observable
  ObservableFuture<bool?> saveFuture = ObservableFuture.value(null);

  @computed
  bool get isLoading => saveFuture.status == FutureStatus.pending;

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  @action
  Future save() async {
    loading = true;
    final future = _incidentrepository.save(this.incident);
    saveFuture = ObservableFuture(future);
    await future.then((value) async {
      this.loading = false;
      if (value != null) {
        this.saved = true;
      } else {
        this.saved = false;

        errorStore.errorMessage = "failed to save";
        print('failed to save');
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.saved = false;
      loading = false;

      errorStore.errorMessage =
          // e.toString().contains("ERROR_USER_NOT_FOUND")
          //     ? "Username and password doesn't match":
          "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  @action
  Future workFlowStepSave(IncidentStatusEnum incidentStatusEnum) async {
    loading = true;
    await Future.delayed(Duration(seconds: 4));
    final future = incidentStatusEnum == IncidentStatusEnum.SolvedInitially
        ? _incidentrepository.sdadWorkflowStepSubmit(this.incident)
        : incidentStatusEnum == IncidentStatusEnum.Solved
            ? _incidentrepository.FinalSdadWorkflowStepSubmit(this.incident)
            : incidentStatusEnum == IncidentStatusEnum.Upped
                ? _incidentrepository.UppingSdadWorkflowStepSubmit(
                    this.incident)
                : ObservableFuture.value(null);

    saveFuture = ObservableFuture(future);
    await future.then((value) async {
      this.loading = false;
      if (value != null) {
        this.saved = true;
      } else {
        this.saved = false;

        errorStore.errorMessage = "failed to take workflow step";
        print('failed to take workflow step');
      }
    }).catchError((e) {
      print(e);

      this.saved = false;
      loading = false;

      errorStore.errorMessage =
          // e.toString().contains("ERROR_USER_NOT_FOUND")
          //     ? "Username and password doesn't match":
          "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateIncident(incident);
  }
}

class IncidentFormErrorStore = _IncidentFormErrorStore
    with _$IncidentFormErrorStore;

abstract class _IncidentFormErrorStore with Store {
  @observable
  String? incidentErrorMessage;

  @observable
  String? incidentTakeActionErrorMessage;

  @computed
  bool get hasErrorsInSubmit => incidentErrorMessage != null;

  @computed
  bool get hasErrorsInSubmitAction => incidentTakeActionErrorMessage != null;
}

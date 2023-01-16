import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../constants/enums.dart';
import '../data/repository.dart';
import '../di/components/service_locator.dart';
import '../models/subcategory/subcategory.dart';
import '../models/subcategory/subcategory_query_params.dart';
import '../stores/subcategory/subcategory_store.dart';
import '../ui/constants/custom_style.dart';
import '../ui/constants/dimensions.dart';
import '../ui/constants/strings.dart';
import '../ui/incident/incident_list_screen.dart';
import 'image/cache_image_widget.dart';
import 'progress_indicator/progress_indicator_text_widget.dart';

class _SubCategoryListWidget extends StatefulWidget {
  void Function(SubCategory?)? onSelectedSubCategoryChanged;
  SubCategoryListViewMode subcategoryListView;

  int? initialSelectedId;

  bool categoryIdIsMandatory;

  bool refreshDataBeforeGetting;

  bool? autoSelectFirstItem;

  double gridAndListHeight;
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());

  _SubCategoryListWidget(
      {this.onSelectedSubCategoryChanged,
      this.subcategoryListView = SubCategoryListViewMode.Radiobutton,
      this.initialSelectedId,
      this.categoryId,
      this.categoryIdIsMandatory = false,
      this.refreshDataBeforeGetting = false,
      this.autoSelectFirstItem = false,
      required this.gridAndListHeight});

  int? categoryId;

  @override
  _SubCategoryListWidgetState createState() => _SubCategoryListWidgetState();
}

class _SubCategoryListWidgetState extends State<_SubCategoryListWidget> {
  //stores:---------------------------------------------------------------------
  late SubCategoryStore _subcategoryStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _subcategoryStore = Provider.of<SubCategoryStore>(context);

    super.didChangeDependencies();
  }

  void loadData() {
    if (!_subcategoryStore.loading) {
      if ((widget.categoryIdIsMandatory && widget.categoryId != null) ||
          !widget.categoryIdIsMandatory) {
        _subcategoryStore.getSubCategories(
            subCategoryQueryParams:
                SubCategoryQueryParams(categoryId: widget.categoryId),
            refreshDataBeforeGetting: widget.refreshDataBeforeGetting);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedSubCategoryStreamController = BehaviorSubject<SubCategory?>();
    //is mandatory , main category id , initialed
    loadData();
    return _buildBody();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  bool initialed = false;

  setInitialSelectedSubCategory() {
    if (initialed) return;
    if (_selectedSubCategory == null && widget.initialSelectedId != null) {
      if (_subcategoryStore.subcategoryList?.subcategories != null) {
        if (_subcategoryStore.subcategoryList!.subcategories!
                .any((element) => element.id == widget.initialSelectedId) ==
            true) {
          _selectedSubCategory = _subcategoryStore
              .subcategoryList!.subcategories!
              .firstWhere((element) => element.id == widget.initialSelectedId);
          widget.initialSelectedId = null;
          Future.delayed(Duration(seconds: 1), () {
            _onSubCategoryTap(_selectedSubCategory);
          });
        }
      }
    } else if (widget.autoSelectFirstItem == true &&
        _subcategoryStore.subcategoryList?.subcategories != null) {
      Future.delayed(Duration(seconds: 0), () {
        _onSubCategoryTap(_subcategoryStore.subcategoryList!.subcategories![0]);
      });
    }
    initialed = true;
  }

  Widget _buildMainContent() {
    if (widget.categoryIdIsMandatory == true && widget.categoryId == null)
      return Center(
        child: Text(
            '${AppLocalizations.of(context).translate('categoryIsMandatory')}'),
      );
    return Observer(
      builder: (context) {
        return _subcategoryStore.loading
            ? CustomProgressIndicatorTextWidget(
                message: AppLocalizations.of(context)
                    .translate('loadingSubCategories'),
              )
            : Material(
                child: StreamBuilder(
                stream: _selectedSubCategoryStreamController.stream,
                builder: (context, snaphot) {
                  return _subcategoryView();
                },
              ));
      },
    );
  }

  @override
  void dispose() {
    _selectedSubCategoryStreamController.close();
    super.dispose();
  }

  Widget _subcategoryView() {
    setInitialSelectedSubCategory();
    return widget.subcategoryListView == SubCategoryListViewMode.ImageList
        ? _buildImageListView()
        : widget.subcategoryListView == SubCategoryListViewMode.Radiobutton
            ? _buildRadiobuttonListView()
            : widget.subcategoryListView == SubCategoryListViewMode.ImageGrid
                ? _buildImageGridView()
                : widget.subcategoryListView ==
                        SubCategoryListViewMode.ImageGridGrouped
                    ? _buildImageGridViewGrouped()
                    : Center(
                        child: Text('There is no selected view type!'),
                      );
  }

  Widget _buildImageListView() {
    var subCategories = _subcategoryStore.subcategoryList!.subcategories;
    var columnWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: Dimensions.marginSize),
          child: Text(
            AppLocalizations.of(context).translate('selectSubCategory'),
            style: TextStyle(
                fontSize: Dimensions.extraLargeTextSize,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: widget.gridAndListHeight,
          //color: Colors.green,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: subCategories?.length,
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                //subCategories[index].imageUrl = '';
                return InkWell(
                  onTap: () {
                    _onSubCategoryTap(_subcategoryStore
                        .subcategoryList?.subcategories?[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                      bottom: Dimensions.heightSize,
                    ),
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFF8F8F8),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CachedNetworkImage(
                                imageUrl: '${subCategories?[index].icon}',
                                fit: BoxFit.cover,
                                // width: 90,
                                height: 90,
                                color: Colors.black.withOpacity(0.5),
                                colorBlendMode: BlendMode.softLight,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, err) =>
                                    Center(child: Text('فشل جلب الصورة'))),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: Dimensions.widthSize,
                                  left: Dimensions.widthSize),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: new Container(
                                      padding: new EdgeInsets.only(right: 13.0),
                                      child: new Text(
                                        '${subCategories?[index].localizedName(_languageStore.locale)}',
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                          color: new Color(0xFF212121),
                                          fontWeight:
                                              subCategories?[index]?.id ==
                                                      _selectedSubCategory?.id
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.heightSize * 0.5,
                                  ),
                                  Text(
                                      '${subCategories?[index].localizedCategoryName(_languageStore.locale)}',
                                      style: CustomStyle.textStyle),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
    return _subcategoryStore.subcategoryList != null
        ? columnWidget
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildImageGridView() {
    var subCategories = _subcategoryStore.subcategoryList?.subcategories ?? [];
    var columnwidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(height: 200, child: Expanded(child: IncidentsMap())),
        Padding(
          padding: const EdgeInsets.only(
              right: Dimensions.marginSize, bottom: Dimensions.marginSize),
          child: Text(
            AppLocalizations.of(context).translate('myIncidentsBySubCategory'),
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold),
          ),
        ),
        // SizedBox(height: Dimensions.heightSize),
        Container(
          height: widget.gridAndListHeight,
          child: gridView(subCategories),
        )
      ],
    );
    return _subcategoryStore.subcategoryList != null
        ? columnwidget
        : Center(
            child: EmptyWidget(
            image: null,
            packageImage: PackageImage.Image_1,
            title:
                '${AppLocalizations.of(context).translate('home_tv_no_post_found')}',
            // subTitle:
            // '${AppLocalizations.of(context).translate('home_tv_no_post_found_line2')}',
            titleTextStyle: TextStyle(
              fontSize: 22,
              color: Color(0xff9da9c7),
              fontWeight: FontWeight.w500,
            ),
            subtitleTextStyle: TextStyle(
              fontSize: 14,
              color: Color(0xffabb8d6),
            ),
          )

            // Text(
            //   AppLocalizations.of(context).translate('home_tv_no_post_found'),
            // ),
            );
  }

  Widget _buildImageGridViewGrouped() {
    var subCategories = _subcategoryStore.subcategoryList?.subcategories ?? [];
    var columnwidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(height: 200, child: Expanded(child: IncidentsMap())),
        Padding(
          padding: const EdgeInsets.only(
              right: Dimensions.marginSize, bottom: Dimensions.marginSize),
          child: Text(
            AppLocalizations.of(context).translate('myIncidentsBySubCategory'),
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold),
          ),
        ),
        // SizedBox(height: Dimensions.heightSize),
        Container(
          height: widget.gridAndListHeight,
          child: gridView(subCategories),
        )
      ],
    );
    return _subcategoryStore.subcategoryList != null
        ? columnwidget
        : Center(
            child: EmptyWidget(
            image: null,
            packageImage: PackageImage.Image_1,
            title:
                '${AppLocalizations.of(context).translate('home_tv_no_post_found')}',
            // subTitle:
            // '${AppLocalizations.of(context).translate('home_tv_no_post_found_line2')}',
            titleTextStyle: TextStyle(
              fontSize: 22,
              color: Color(0xff9da9c7),
              fontWeight: FontWeight.w500,
            ),
            subtitleTextStyle: TextStyle(
              fontSize: 14,
              color: Color(0xffabb8d6),
            ),
          )

            // Text(
            //   AppLocalizations.of(context).translate('home_tv_no_post_found'),
            // ),
            );
  }

  GridView gridView(List<SubCategory>? subCategories) {
    return GridView.builder(
      itemCount: subCategories!.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            _onSubCategoryTap(subCategories[index]);
            _selectedSubCategoryStreamController =
                BehaviorSubject<SubCategory?>();
          },
          child: gridItem(subCategories, index)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
    );
  }

  Widget gridItem(List<SubCategory> subCategories, int index) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            //I assumed you want to occupy the entire space of the card

            image: NetworkImage(
              subCategories![index]!.icon!,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 2,
              right: 1,
              left: 1,
              child: Container(
                height: 25,
                color: CustomColor.accentColor.withOpacity(0.8),
                child: Center(
                  child: Text(
                    '${subCategories![index]!.localizedName(_languageStore.locale)}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: new TextStyle(
                      //backgroundColor: CustomColor.accentColor.withOpacity(0.7),
                      fontSize: 13.0,
                      fontFamily: 'Roboto',
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadiobuttonListView() {
    return _subcategoryStore.subcategoryList != null
        ? Container(
            height: 30.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _subcategoryStore.subcategoryList!.subcategories!
                  .map((e) => _buildRadioItem(e))
                  .toList(),
            ),
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  SubCategory? _selectedSubCategory;
  late StreamController<SubCategory?> _selectedSubCategoryStreamController;

  _onSubCategoryTap(SubCategory? subcategory) {

    _selectedSubCategory = subcategory;
    if (widget.onSelectedSubCategoryChanged != null)
      widget.onSelectedSubCategoryChanged!(subcategory);
    _selectedSubCategoryStreamController.add(subcategory);

    // });
  }

  Widget _buildRadioItem(SubCategory subcategory) {
    var dd = InkWell(
      onTap: () {
        _onSubCategoryTap(subcategory);
      },
      child: Row(
        children: [
          Radio<SubCategory>(
            value: subcategory,
            toggleable: true,
            autofocus: true,
            groupValue: _selectedSubCategory,
            onChanged: (SubCategory? value) {
              _onSubCategoryTap(value);
            },
          ),
          Text(
            '${subcategory.localizedName(_languageStore.locale)}',
            style: CustomStyle.textStyle,
          ),
          SizedBox(
            width: Dimensions.widthSize,
          ),
        ],
      ),
    );
    return dd;
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.cloud_circle),
      title: Text(
        '${_subcategoryStore.subcategoryList?.subcategories?[position].localizedName(_languageStore.locale)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style:
            _subcategoryStore.subcategoryList?.subcategories?[position]?.id ==
                    _selectedSubCategory?.id
                ? Theme.of(context).textTheme.subtitle1
                : Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        '${_subcategoryStore.subcategoryList?.subcategories?[position].localizedName(_languageStore.locale)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
      onTap: () {
        _onSubCategoryTap(
            _subcategoryStore.subcategoryList?.subcategories?[position]);
      },
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_subcategoryStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_subcategoryStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}

class SubCategoryFormField extends FormField<SubCategory> {
  SubCategoryListViewMode subcategoryListView;
  Function(SubCategory?)? onChange;
  StreamController<SubCategory?>? stream;

  SubCategoryFormField(
      {required FormFieldSetter<SubCategory> onSaved,
      required FormFieldValidator<SubCategory> validator,
      int? initialSelectedId,
      int? categoryId,
      //Category? initialValue,
      AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
      this.subcategoryListView = SubCategoryListViewMode.Radiobutton,
      this.onChange,
      this.stream,
      bool categoryIdIsMandatory = false,
      bool refreshDataBeforeGetting = false,
      bool autoSelectFirstItem = false,
      required double gridAndListHeight})
      : super(
            onSaved: onSaved,
            validator: validator,
            //initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<SubCategory> state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _SubCategoryListWidget(
                        gridAndListHeight: gridAndListHeight,
                        autoSelectFirstItem: autoSelectFirstItem,
                        refreshDataBeforeGetting: refreshDataBeforeGetting,
                        categoryIdIsMandatory: categoryIdIsMandatory,
                        categoryId: categoryId,
                        initialSelectedId: initialSelectedId,
                        onSelectedSubCategoryChanged: (subcategory) {
                          if (onChange != null) {
                            onChange(subcategory);
                          }
                          //state.didChange(subcategory);
                          if (stream != null) stream.add(subcategory);
                        },
                        subcategoryListView: subcategoryListView),
                    state.hasError
                        ? Text(
                            '${state.errorText}',
                            style: TextStyle(color: Colors.red),
                          )
                        : Container()
                  ],
                ),
              );
            });
}

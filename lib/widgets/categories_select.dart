import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/stores/category/category_store.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/category/category.dart';
import '../constants/enums.dart';
import '../models/subcategory/subcategory.dart';
import '../ui/constants/colors.dart';
import '../ui/constants/custom_style.dart';
import '../ui/constants/dimensions.dart';
import 'progress_indicator/progress_indicator_text_widget.dart';
import 'progress_indicator/progress_indicator_widget.dart';

class _CategoryListWidget extends StatefulWidget {
  double gridAndListHeight;
  void Function(Category?)? onSelectedCategoryChanged;
  void Function(SubCategory?)? onSelectedSubCategoryChanged;

  CategoryListViewMode categoryListViewMode;

  int? initialSelectedId;

  bool autoSelectFirstItem;

  _CategoryListWidget(
      {this.onSelectedCategoryChanged,
      this.onSelectedSubCategoryChanged,
      this.categoryListViewMode = CategoryListViewMode.Radiobutton,
      this.initialSelectedId,
      this.autoSelectFirstItem = false,
      required this.gridAndListHeight});

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<_CategoryListWidget> {
  //stores:---------------------------------------------------------------------
  late CategoryStore _categoryStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _categoryStore = Provider.of<CategoryStore>(context);

    // check to see if already called api
    if (!_categoryStore.loading) {
      _categoryStore.getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedCategoryStreamController = BehaviorSubject<Category?>();
    _selectedSubCategoryStreamController = BehaviorSubject<SubCategory?>();

    return _buildBody();
  }

  @override
  void dispose() {
    _selectedCategoryStreamController.close();
    _selectedSubCategoryStreamController.close();

    super.dispose();
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

  setInitialSelectedCategory() {
    if (initialed) return;
    if (_selectedCategory == null && widget.initialSelectedId != null) {
      if (_categoryStore.categoryList?.categories != null) {
        if (_categoryStore.categoryList!.categories!
                .any((element) => element.id == widget.initialSelectedId) ==
            true) {
          Future.delayed(Duration(seconds: 0), () {
            _onCategoryTap(_categoryStore.categoryList!.categories!.firstWhere(
                (element) => element.id == widget.initialSelectedId));
          });
          widget.initialSelectedId = null;
        }
      }
    } else if (widget.autoSelectFirstItem == true &&
        _categoryStore.categoryList?.categories != null) {
      Future.delayed(Duration(seconds: 0), () {
        _onCategoryTap(_categoryStore.categoryList!.categories![0]);
      });
    }
    // if (_selectedCategory != null)
    //   Future.delayed(Duration(seconds: 0), () {
    //     _onCategoryTap(_selectedCategory);
    //   });

    initialed = true;
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _categoryStore.loading
            ? CustomProgressIndicatorTextWidget(
                message:
                    AppLocalizations.of(context).translate('loadingCategories'),
              )
            : Material(child: _categoryView());
      },
    );
  }

  Widget _categoryView() {
    setInitialSelectedCategory();
    return widget.categoryListViewMode == CategoryListViewMode.List
        ? _buildListView()
        : widget.categoryListViewMode == CategoryListViewMode.Radiobutton
            ? _buildRadiobuttonListView()
            : widget.categoryListViewMode ==
                    CategoryListViewMode.SubCategoriesGroupedImageGrid
                ? _buildSubCategoriesImageGridViewGrouped()
                : Center(
                    child: Text('There is no selected view type!'),
                  );
  }

  Widget _buildListView() {
    return _categoryStore.categoryList != null
        ? ListView(
            scrollDirection: Axis.horizontal,
            children: _categoryStore.categoryList!.categories!
                .map((e) => _buildRadioItem(e))
                .toList(),
            // itemCount: _categoryStore.categoryList!.categories!.length,
            // separatorBuilder: (context, position) {
            //   return Divider();
            // },
            // itemBuilder: (context, position) {
            //   return _buildListItem(position);
            // },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildSubCategoriesImageGridViewGrouped() {
    var subCategories = _categoryStore.categoryList?.categories ?? [];
    // var columnwidget = Container(
    //   height: widget.gridAndListHeight,
    //   child: suCategoriesgridView(subCategories),
    // );
    var columnwidget2 = Container(
      // color: CustomColor.primaryColor,
      height: widget.gridAndListHeight,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: subCategories.length,
        itemBuilder: (ss, i) {
          return ListTile(
            //leading: const Icon(Icons.add),
            title: Text(
              '${subCategories[i].localizedName(_languageStore.locale)}',
              style: TextStyle(
                fontSize: Dimensions.largeTextSize,
                color: CustomColor.primaryColor,
              ),
              // textScaleFactor: 1.5,
            ),
            //trailing: const Icon(Icons.done),
            subtitle: Column(
              children: [
                suCategoriesgridView(subCategories[i].subCategories),
              ],
            ),
            //selected: true,
            onTap: () {},
          );
        },
      ),
    );

    return _categoryStore.categoryList != null
        ? columnwidget2
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

  late StreamController<Category?> _selectedCategoryStreamController;
  late StreamController<SubCategory?> _selectedSubCategoryStreamController;

  Widget suCategoriesgridView(List<SubCategory>? categories) {
    //return Text('aaaa');
    return Container(
      height: 170,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories!.length,
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              _onSubCategoryTap(categories[index]);
              _selectedSubCategoryStreamController =
                  BehaviorSubject<SubCategory?>();
            },
            child: gridItem(categories, index)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
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
              'https://orbitsdc.com/Uploads/SubCategories/${subCategories![index]!.icon ?? ''}',
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
    return _categoryStore.categoryList != null
        ? Container(
            height: 30.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _categoryStore.categoryList!.categories!
                  .map((e) => _buildRadioItem(e))
                  .toList(),
              // itemCount: _subcategoryStore.subcategoryList!.subcategories!.length,
              // separatorBuilder: (context, position) {
              //   return Divider();
              // },
              // itemBuilder: (context, position) {
              //   return _buildRadioItem(position);
              // },
            ),
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Category? _selectedCategory;
  SubCategory? _selectedSubCategory;

  _onCategoryTap(Category? category) {
    setState(() {
      if (_selectedCategory?.id == category?.id) {
        _selectedCategory = null;
        if (widget.onSelectedCategoryChanged != null)
          widget.onSelectedCategoryChanged!(null);
      } else {
        _selectedCategory = category;
        if (widget.onSelectedCategoryChanged != null)
          widget.onSelectedCategoryChanged!(category);
      }
    });
    _selectedCategoryStreamController.add(category);
  }

  _onSubCategoryTap(SubCategory? subCategory) {
    setState(() {
      if (_selectedSubCategory?.id == subCategory?.id) {
        _selectedSubCategory = null;
        if (widget.onSelectedSubCategoryChanged != null)
          widget.onSelectedSubCategoryChanged!(null);
      } else {
        _selectedSubCategory = subCategory;
        if (widget.onSelectedSubCategoryChanged != null)
          widget.onSelectedSubCategoryChanged!(subCategory);
      }
    });
    _selectedSubCategoryStreamController.add(subCategory);
  }

  Widget _buildRadioItem(Category category) {
    var dd = InkWell(
      onTap: () {
        _onCategoryTap(category);
      },
      child: Row(
        children: [
          Radio<Category>(
            value: category,
            toggleable: true,
            autofocus: true,
            groupValue: _selectedCategory,
            onChanged: (Category? value) {
              _onCategoryTap(value);
            },
          ),
          Text(
            '${category.localizedName(_languageStore.locale)}',
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
        '${_categoryStore.categoryList?.categories?[position].arabicName}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: _categoryStore.categoryList?.categories?[position]?.id ==
                _selectedCategory?.id
            ? Theme.of(context).textTheme.subtitle1
            : Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        '${_categoryStore.categoryList?.categories?[position].arabicName}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
      onTap: () {
        _onCategoryTap(_categoryStore.categoryList?.categories?[position]);
      },
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_categoryStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_categoryStore.errorStore.errorMessage);
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

class CategoryFormField extends FormField<Category> {
  CategoryListViewMode categoryListView;
  Function(Category?)? onCategoryChange;
  StreamController<Category?>? categoryStream;
  StreamController<SubCategory?>? subCategoryStream;

  Function(SubCategory?)? onSubCategoryChange;

  CategoryFormField(
      {required FormFieldSetter<Category> onSaved,
      required FormFieldValidator<Category> validator,
      int? initialSelectedId,
      //Category? initialValue,
      AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
      this.categoryListView = CategoryListViewMode.Radiobutton,
      this.onCategoryChange,
      this.onSubCategoryChange,
      this.categoryStream,
      this.subCategoryStream,
      bool autoSelectFirstItem = false,
      required double gridAndListHeight})
      : assert(initialSelectedId == null || autoSelectFirstItem == false),
        super(
            onSaved: onSaved,
            validator: validator,
            //initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<Category> state) {
              return Stack(
                children: [
                  _CategoryListWidget(
                      gridAndListHeight: gridAndListHeight,
                      autoSelectFirstItem: autoSelectFirstItem,
                      initialSelectedId: initialSelectedId,
                      onSelectedCategoryChanged: (category) {
                        if (onCategoryChange != null) {
                          onCategoryChange(category);
                        }
                        state.didChange(category);
                        if (categoryStream != null)
                          categoryStream.add(category);
                      },
                      onSelectedSubCategoryChanged: (subCategory) {
                        if (onSubCategoryChange != null) {
                          onSubCategoryChange(subCategory);
                        }
                        //state.didChange(subCategory);
                        if (subCategoryStream != null)
                          subCategoryStream.add(subCategory);
                      },
                      categoryListViewMode: categoryListView),
                  state.hasError
                      ? Text(
                          '${state.errorText}',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container()
                ],
              );
            });
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../model/categories_model.dart';
import '../../model/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              productsBuilder(cubit.homeModel!, cubit.categoriesModel!, cubit),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is ShopErrorFavoritesDataState) {
          showToast(message: state.error, states: ToastStates.ERROR);
        }
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categoriesModel, ShopCubit cubit) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
              items: model.data!.banners!
                  .map((e) => Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 120.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) =>
                        buildCategoryItem(categoriesModel.data!.data![index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoriesModel.data!.data!.length,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.grey[100],
            child: GridView.count(
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 5.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.56,
              children: List.generate(
                model.data!.products!.length,
                (index) =>
                    buildGridProduct(model.data!.products![index], cubit),
              ),
            ),
          ),
        ]),
      );

  Widget buildGridProduct(
    ProductsModel model,
    ShopCubit cubit,
  ) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    color: Colors.red,
                    child: Text(
                      'discount'.toUpperCase(),
                      style: const TextStyle(fontSize: 9.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          model.price!.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              color: defaultColor,
                              fontSize: 14.0,
                              height: 1.3,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            model.oldPrice!.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14.0,
                                height: 1.3,
                                fontWeight: FontWeight.bold),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: cubit.favorites[model.id]!
                              ? defaultColor
                              : Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              cubit.postFavorites(model.id!);
                            },
                            icon: const Icon(
                              Icons.favorite_outline_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget buildCategoryItem(Categories categories) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(categories.image!),
            width: 120.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 120,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                categories.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ))
        ],
      );
}

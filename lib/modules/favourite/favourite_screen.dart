import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../model/favorite_model_entity.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            fallback:(context)=> const Center(child: CircularProgressIndicator()),
            condition: state is! ShopLoadingGetFavoritesDataState,
            builder: (context) =>
                ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        buildFavoriteItem(
                            cubit.favoriteModel!.data!.data![index].product!,
                            cubit),
                    separatorBuilder: (context, index) => divider(),
                    itemCount: cubit.favoriteModel!.data!.data!.length),
          );
        });
  }

  Widget buildFavoriteItem(FavoriteModelDataDataProduct product,
      ShopCubit cubit) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(product.image!),
              height: 120,
              width: 120,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          product.price!.toString(),
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
                        if (product.discount != 0)
                          Text(
                            product.oldPrice!.toString(),
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
                          backgroundColor:
                          cubit.favorites[product.id]!
                              ? defaultColor : Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              cubit.postFavorites(product.id!);
                            },
                            icon: const Icon(
                              Icons.favorite_outline_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

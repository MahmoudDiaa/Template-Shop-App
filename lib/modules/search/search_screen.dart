import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../model/search_products_model_entity.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class SearchScreen extends StatelessWidget {
  final fromKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        builder: (BuildContext context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: fromKey,
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: searchController,
                      textInputType: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search_rounded,
                      textInputAction: TextInputAction.search,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please entre search data';
                        } else {
                          return null;
                        }
                      },
                      onSubmit: (value) {
                        cubit.postSearchData(value);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is ShopLoadingSearchDataState)
                      const LinearProgressIndicator(),
                    if (state is ShopSuccessSearchDataState)
                      Expanded(
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) =>
                                  buildFavoriteItem(
                                      cubit.searchProductsModel!.data!
                                          .data![index],
                                      cubit),
                              separatorBuilder: (context, index) => divider(),
                              itemCount: cubit
                                  .searchProductsModel!.data!.data!.length))
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }

  Widget buildFavoriteItem(ProductData product, SearchCubit cubit) => Padding(
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


                        const Spacer(),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: product.inFavorites!
                              ? defaultColor
                              : Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              // cubit.postFavorites(product.id!);
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

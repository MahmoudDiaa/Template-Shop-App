import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/components.dart';
import '../modules/search/search_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text('Salla'),
              actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());

              }, icon: const Icon(Icons.search))

              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home' ),
        BottomNavigationBarItem(icon: Icon(Icons.apps),label:'Categories' ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label:'Favourite' ),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label:'Settings' ),

        ],
        currentIndex: cubit.currentIndex,
        onTap: (index){
        cubit.changeBottom(index);

        },
        )
        ,
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

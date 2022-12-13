import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';

import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
    final formKey = GlobalKey<FormState>();
    var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
        listener: (context, state){} ,
      builder: (context , state) {
          var list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter a search term',
                      border: OutlineInputBorder(),
                      prefixIcon:Icon(Icons.search),
                    ),
                    onSubmitted: (value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildArticalItem(list[index],context),
                      separatorBuilder: (context, index) => const Divider(
                          endIndent: 10.0,
                          indent: 10.0,
                          thickness: 0.5,
                          color: Colors.grey),
                      itemCount: list.length
                  ),
                ),

                // Expanded(child: BuildArticalItem(list , context)),


                ],
            ),
          );

      },
    );
  }
}
// https://newsapi.org/v2/everything?q=s&apiKey=14fafbc6062d44a8acd0044d2e43ca32
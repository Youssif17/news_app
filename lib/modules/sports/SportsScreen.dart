import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
          listener: (context , state){},
          builder: (context, state)
          {
            var list = NewsCubit.get(context).sports;

            return  ConditionalBuilder(
              condition: list.length > 0,
              builder: (context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildArticalItem(list[index],context),
                  separatorBuilder: (context, index) => const Divider(
                      endIndent: 10.0,
                      indent: 10.0,
                      thickness: 0.5,
                      color: Colors.grey),
                  itemCount: 10),
              fallback: (context) => const Center(
                  child: CircularProgressIndicator()
              ),

            );
          }
      );
  }
}

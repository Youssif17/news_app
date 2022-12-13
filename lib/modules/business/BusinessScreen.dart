import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import '../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          return ConditionalBuilder(
            condition: list.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildArticalItem(list[index], context),
                separatorBuilder: (context, index) => const Divider(
                    endIndent: 10.0,
                    indent: 10.0,
                    thickness: 0.5,
                    color: Colors.grey),
                itemCount: list.length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }
}

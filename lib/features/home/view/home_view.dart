import 'package:chat_app/core/widgets/widgets.dart';
import 'package:chat_app/features/home/domain/data_cubit/data_cubit.dart';
import 'package:chat_app/features/message/view/message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllUsersDataCubitFunction(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(elevation: 2),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: HomeCubit.get(context).usersData.length,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (c) => MessageView(
                                    receiver:
                                        HomeCubit.get(
                                          context,
                                        ).usersData[index]['uid'],
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: defaultText(
                              text:
                                  HomeCubit.get(
                                    context,
                                  ).usersData[index]['name'],
                              fontSize: 17,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}

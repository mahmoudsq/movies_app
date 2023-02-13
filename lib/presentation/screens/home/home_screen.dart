import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bussiness_logic/home_cubit/cubit.dart';
import '../../../data/repository/movies_repository.dart';
import '../../component_widgets/base_list.dart';
import '../../component_widgets/default_button.dart';
import 'widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
        create: (context) => HomeCubit(MoviesRepository())..getAllMoviesLocal(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

            return Scaffold(
                appBar: AppBar(),
                body: cubit.moviesLocalList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DefaultButton(
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.07,
                                    text: 'Refresh ',
                                    radius: 10,
                                    fontSize: screenWidth * 0.04,
                                    function: () => cubit.refreshAllMoviesLocal(),
                                  )
                                ]),
                            state is MoviesLoaded
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : BaseList(
                                    gridWidget: [
                                      ...List.generate(
                                          cubit.moviesLocalList.length,
                                          (index) => MovieCardWidget(
                                              movieDetails: cubit.moviesLocalList[index]))
                                    ],
                                    mainAxisSpacing: screenWidth * 0.06,
                                    childAspectRatio: 0.7,
                                    crossAxisSpacing: 0,
                                    crossAxisCount: 2,
                                    isListView: false,
                                    shrinkWrap: true,
                                  ),
                          ],
                        ),
                      ));
          },
        ));
  }
}

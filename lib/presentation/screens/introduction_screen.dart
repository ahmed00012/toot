import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/cubits/auth_cubit/auth_cubit.dart';
import 'package:toot/presentation/widgets/onboarding_preview.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).fetchIntroductionImages();
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
          builder: (BuildContext context, state) {
        if (state is ImagesLoaded) {
          final images = state.images;
          return ImagesSlider(
            imagesPreview: images,
          );
        } else {
          return Center(
            child: Image.asset(
              "assets/images/Group 1547.png",
              fit: BoxFit.contain,
              height: 0.23.sh,
              width: 0.5.sw,
            ),
          );
        }
      }),
    );
  }
}

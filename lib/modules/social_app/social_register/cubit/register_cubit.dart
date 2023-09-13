import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/social_model/social_user_model.dart';
import 'package:flutter_project/modules/social_app/social_register/cubit/register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        cover:
            'https://img.freepik.com/free-photo/young-attractive-handsome-guy-feels-delighted-gladden-amazed_295783-535.jpg?w=900&t=st=1694604198~exp=1694604798~hmac=114b97d9dec1e44eccffec68e2b653bbdae198151e8fea624b8869a2f029597d',
        image:
            'https://img.freepik.com/free-photo/young-attractive-handsome-guy-feels-delighted-gladden-amazed_295783-535.jpg?w=900&t=st=1694604198~exp=1694604798~hmac=114b97d9dec1e44eccffec68e2b653bbdae198151e8fea624b8869a2f029597d',
        bio: 'write your bio ...');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  void changePassword() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(SocialRegisterChangeVisibilityState());
  }
}

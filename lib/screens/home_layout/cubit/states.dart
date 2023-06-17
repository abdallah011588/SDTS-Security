

abstract class AppStates{}
class InitialState extends AppStates{}
class ShowPasswordState extends AppStates{}
class AgreeTermsState extends AppStates{}
class LoginLoadingState extends AppStates{}
class LoginSuccessState extends AppStates{
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends AppStates{
  final String error;
  LoginErrorState(this.error);
}


class CreateUserSuccessState extends AppStates{
  final String uId;
  CreateUserSuccessState(this.uId);
}
class CreateUserErrorState extends AppStates{
  final String error;
  CreateUserErrorState(this.error);
}


class RegisterLoadingState extends AppStates{}
class RegisterErrorState extends AppStates{
  final String error;
  RegisterErrorState(this.error);
}


class SendNotificationSuccessState extends AppStates{}
class SendNotificationErrorState extends AppStates{
  final String error;
  SendNotificationErrorState(this.error);
}

class ResetPassLoadingState extends AppStates{}
class ResetPassSuccessState extends AppStates{}
class ResetPassErrorState extends AppStates{
  final String error;
  ResetPassErrorState(this.error);
}

class GetUserDataLoadingState extends AppStates{}
class GetUserDataSuccessState extends AppStates{}
class GetUserDataErrorState extends AppStates{}

class ChangeScreenState extends AppStates{}
class ChangeGenderState extends AppStates{}
class ChangeCategoryState extends AppStates{}

class StepCancelState extends AppStates{}
class StepContinueState extends AppStates{}
class StepTappedState extends AppStates{}

class UpdateUserLoadingState extends AppStates{}
class UpdateUserSuccessState extends AppStates{}
class UpdateUserErrorState extends AppStates{
  final String error;
  UpdateUserErrorState(this.error);
}

class PickedProfileImageSuccessState extends AppStates{}
class PickedProfileImageErrorState extends AppStates{}

class PickedProductImagesSuccessState extends AppStates{}
class PickedProductImagesErrorState extends AppStates{}


class UploadProfileImageLoadingState extends AppStates{}
class UploadProfileImageSuccessState extends AppStates{}
class UploadProfileImageErrorState extends AppStates{}


class UploadProductImagesLoadingState extends AppStates{}
class UploadProductImagesSuccessState extends AppStates{}
class UploadProductImagesErrorState extends AppStates{}


class postProductLoadingState extends AppStates{}
class postProductSuccessState extends AppStates{}
class postProductErrorState extends AppStates{
  final String error;
  postProductErrorState(this.error);
}


class GetImageSuccessState extends AppStates{}
class GetImageErrorState extends AppStates{}


class LogOutSuccessState extends AppStates{}
class LogOutErrorState extends AppStates{}


class UploadImLoadingState extends AppStates{}
class UploadImSuccessState extends AppStates{}
class UploadImErrorState extends AppStates{}


class AddCameraLoadingState extends AppStates{}
class AddCameraSuccessState extends AppStates{}
class AddCameraErrorState extends AppStates{
  final String error;
  AddCameraErrorState(this.error);
}


class GetCameraLoadingState extends AppStates{}
class GetCameraSuccessState extends AppStates{}
class GetCameraErrorState extends AppStates{
  final String error;
  GetCameraErrorState(this.error);
}


class RemoveCameraSuccessState extends AppStates{}
class RemoveCameraErrorState extends AppStates{}

class AddReportLoadingState extends AppStates{}
class AddReportSuccessState extends AppStates{}
class AddReportErrorState extends AppStates{
  final String error;
  AddReportErrorState(this.error);
}

class GetReportLoadingState extends AppStates{}
class GetReportSuccessState extends AppStates{}
class GetReportErrorState extends AppStates{
  final String error;
  GetReportErrorState(this.error);
}

class RemoveReportSuccessState extends AppStates{}
class RemoveReportErrorState extends AppStates{}

class RemoveAllReportsSuccessState extends AppStates{}
class RemoveAllReportsErrorState extends AppStates{}

class ChangeLanguageState extends AppStates{}
class ChangeThemState extends AppStates{}


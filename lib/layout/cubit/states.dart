class SocialStates {}
class SocialInitialState extends SocialStates {}
class SocialGetDataLoadingState extends SocialStates {}
class SocialGetDataSuccessState extends SocialStates {}
class SocialGetDataFailedState extends SocialStates {}
class SocialChangeBottomNav extends SocialStates{}
class SocialNewPostState extends SocialStates{}
class SocialPickImageSuccessState extends SocialStates{}
class SocialPickImageFailedState extends SocialStates{}
class SocialPickCoverSuccessState extends SocialStates{}
class SocialPickCoverFailedState extends SocialStates{}
class SocialPickPostImageSuccessState extends SocialStates{}
class SocialPickPostImageFailedState extends SocialStates{}
class SocialUploadImageSuccessState extends SocialStates{}
class SocialUploadImageFailedState extends SocialStates{}
class SocialUploadCoverSuccessState extends SocialStates{}
class SocialUploadCoverFailedState extends SocialStates{}
class SocailUserUpdateError extends SocialStates{}
class SocailUserUpdateLoading extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialRemovePostImage extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  String Error ;
  SocialGetPostsErrorState(this.Error);
}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsLoadingState extends SocialStates{}
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{}
class SocialGetUsersErrorState extends SocialStates{
  String Error ;
  SocialGetUsersErrorState(this.Error);
}
class SocialGetUsersSuccessState extends SocialStates{}
class SocialGetUsersLoadingState extends SocialStates{}
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageFailedState extends SocialStates{}
class  SocialGetMessageSuccessState extends SocialStates{}

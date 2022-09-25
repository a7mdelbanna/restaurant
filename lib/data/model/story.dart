class StoryData {
  late final String avatarUrl;
  late final String storyUrl;
  late final String storyText;
  StoryData(
      {required this.avatarUrl,
      required this.storyUrl,
      required this.storyText});
}

class Stories {
  List<StoryData> _myStories = [
    StoryData(
      avatarUrl: 'assets/images/pizza4.jpg',
      storyUrl: 'assets/images/pizza2.jpg',
      storyText:
          'jkhkj kjg kjg k kk l l kg jhg jh gjh  dyt y ft kj gkjg jkh k hlkhlkh uigiugu yt uy ',
    ),
    StoryData(
        storyText:
            'jkhkj kjg kjg k kk l l kg jhg jh gjh  dyt y ft kj gkjg jkh k hlkhlkh uigiugu yt uy ',
        avatarUrl: 'assets/images/burger.jpg',
        storyUrl: 'assets/images/burger2.jpg'),
    StoryData(
        storyText:
            'jkhkj kjg kjg k kk l l kg jhg jh gjh  dyt y ft kj gkjg jkh k hlkhlkh uigiugu yt uy ',
        avatarUrl: 'assets/images/fajita.jpg',
        storyUrl: 'assets/images/fajita2.jpg'),
    StoryData(
        storyText:
            'jkhkj kjg kjg k kk l l kg jhg jh gjh  dyt y ft kj gkjg jkh k hlkhlkh uigiugu yt uy ',
        avatarUrl: 'assets/images/pasta.jpg',
        storyUrl: 'assets/images/pasta2.jpg'),
    StoryData(
        storyText:
            'jkhkj kjg kjg k kk l l kg jhg jh gjh  dyt y ft kj gkjg jkh k hlkhlkh uigiugu yt uy ',
        avatarUrl: 'assets/images/shawarma.jpg',
        storyUrl: 'assets/images/shawarma2.jpg'),
  ];
  List<StoryData> get myStories {
    return [..._myStories];
  }
}

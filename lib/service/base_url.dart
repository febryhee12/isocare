class BaseUrl {
  // test server
  // static String baseUrl = "http://103.41.205.67/dev/vivamedika-panel/public";
  // static String baseUrl = "http://103.41.205.67/test/vivamedika-panel/public";
  // test server

  static const String baseUrl = 'https://app.vivamedika.co.id'; //live
  // static const String baseUrl = 'https://staging.vivamedika.co.id'; //staging

  static String profileUrl = "/api/member/profile";
  static String categoryNewsUrl = "/api/news-category/list?table=true";
  static String listNewsUrl = "/api/news/list?filters[news_category_id]=";
  static String homelistNewsUrl = "/api/news/list?";
  static String categoryPodcastUrl = "/api/podcast-category/list?table=true";
  static String listPodcastUrl =
      "/api/podcast/list?table=true&filters[podcast_category_id]=";
  static String newsDetail = "/api/news/list?list=true&id=";
  static String medicalHistory = "/api/member/medical-history";
  static String listDoctor = "/api/doctor/list?list=true";
  static String listInbox = "/api/member/inbox";
  static String listBanner = "/api/banner/list?table=true&sort[id]=desc";
  static String listVideo = "/api/youtube/list?table=true&sort[id]=desc";
  static String listPodcast =
      "api/youtube-category/list?table=true&sort[id]=desc";
  // static String appVersion = "/api/app-version?device=";
  static String token = "/api/login";
  static String register = "/api/member/register";
  static String forgot = "/api/forgot-password";
  static String dateFormat = "dd-MMMM-yyyy";
  static String startChat = "/api/chat/generate";
  static String supportChat = "/api/chat-admin/generate";
  static String endChat = "/api/chat/close/";
  static String uploadImg = "/api/update-image";
  static String updateData = "/api/update-data";
  static String imageUrl = "http://103.41.205.67/";
  static String getKey = "/api/setting/show";
  static String codeVcall = "/api/video-call/member-view";
  static String appointment = "/api/appointment";
  static String family = "/api/member/profile-family";

  static String updateAddress = "/api/update-address";
  static String urlVideoCall = "/api/chat/generate-url";

  static String getVoucher = '/api/member/claim-consultation-voucher';
}

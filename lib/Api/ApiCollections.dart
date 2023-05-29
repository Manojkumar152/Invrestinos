class ApiCollections{
  static String imageicon = 'https://www.cryptocompare.com';
  static String API_KEY = 'b1a464700079be4d4c03749aa4ce2fc61d160bc84f31dae6e1b3b5b7917e76ba';
  static String BaseURL = 'min-api.cryptocompare.com'; // Base Url
  static String BaseURLbinance = 'api3.binance.com'; // Base Url
  static String TradeUrl = 'node.investinos.com'; // Base Url
  static String livedatafetch = "/data/pricemultifull";
  static String currencyget = "/list-crypto/get";

  static String livedatafetchPrice = "/api/v3/ticker/price";
  //static String LBM_BaseURL = 'demo.finexchanges.com';
  static String LBM_BaseURL = 'demo.investinos.com';
  static String NODELBM_BaseURL = 'node.investinos.com';
  static String P2pBaseUrl = 'demo.investinos.com';

  static String listedcoinServer="server.zonox.io";


  ///Favourite>>>>>>>>>>>>>
 static String addtofav = '/backend/public/api/favourite/create';
  static String getaddtofav = '/favpair/get';
  static String deladdtofav = '/backend/public/api/favourite/delete/';

  ///Login
  static String LBM_login = '/backend/public/api/login';
  static String LBM_emailverify = '/backend/public/api/validateotp';
  static String LBM_verify = '/backend/public/api/register/verify';
  static String LBM_phoneverify = '/backend/public/api/register/verify';    //api_for_login
  static String LBM_forgetpassword = 'backend/public/api/forgotpassword';
  static String logout = 'backend/public/api/logout';
  static String hardlogout = '/backend/public/api/hardlogout';

  static String LBM_register = '/backend/public/api/register'; /* **  Done ** */
  static String LBM_emailotp = '/backend/public/api/register/verify'; /* **  Done ** */
  static String LBM_phoneotp = '/backend/public/api/validateotp/mobile/';
  static String LBM_resendotp = '/backend/public/api/resendotp/';


  ///buy/sell
  static String buy = '/orders/place-order';
  /// P2P OrderDetails
  static String p2pOrderDetails = '/backend/public/api/p2p/getOrderdetails/';
  static String p2pbuyerDetails = '/backend/public/api/p2p/buyer_details/';
  ///P@P showMatching
  static String p2pshow_matching = '/backend/public/api/p2p/show_matching/';
  static String p2pcancel_order = '/backend/public/api/p2p/cancel_order/';
  static String p2pmatching_orders = '/backend/public/api/p2p/matching_orders/';

  /// P2P Buy/sell
  static String p2pcreate = '/backend/public/api/p2p/create';
  ///History
  static String OpenData='/orders/get';
  static String CompleteData='/backend/public/api/orders/get';
  static String WalletTranData='/backend/public/api/wallet-trans/get';
  static String EditOrder='/backend/public/api/order/update/';
  static String cancelorder='/backend/public/api/order/cancelOrder/';
  static String getcrypto='/user-crypto/get';

///Settings
  static String fees='/backend/public/api/fee_by_lbm/update';
  static String logGet='/backend/public/api/log/get';
  static String kycupdate='/backend/public/api/userkyc/create';
  static String getbankdetail='/backend/public/api/userbanks/get';
  static String addbankdetail='/backend/public/api/userbanks/create';
  static String getCategory="/backend/public/api/ticket_type/get";


  static String changePassword="/backend/public/api/user/change_password";
  static String TwoFAuth="/backend/public/api/2fa/get";
  static String TwoFAuthUpdate="/backend/public/api/2fa/update";
  static String getuser ="/user/get";


  //Country???????????????????????????
static String getCountry="/dashboard/get-country";
static String getstate="/dashboard/get-state";
static String tradingreport="/backend/public/api/order/tradingreport";
static String tickettype="/backend/public/api/ticket_type/get";
static String ticketcreate="/backend/public/api/ticket/create";
static String ticketget="/backend/public/api/ticket/get";
static String ticketreply="/backend/public/api/ticket/get";
static String ticketcomment="/backend/public/api/ticket_comment/create";



static String user="/backend/public/api/user";
static String deleteBankAccount="/backend/public/api/userbanks/delete/";
static String WithdrawHistory="/backend/public/api/wallet-trans/get";
static String depositHistory="/backend/public/api/deposit/get";
static String validToken="/backend/public/api/password/valid";
static String reset="/backend/public/api/password/reset";


}
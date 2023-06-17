// ignore_for_file: constant_identifier_names, non_constant_identifier_names

//TESTING API
// const BASE_URL = "http://10.0.2.2:8000/api/";
// const BASE_URL = "http://127.0.0.1:8000/api/";
// const BASE_URL = "http://192.168.43.171:8000/api/";
//PRODUCTION
const BASE_URL = "https://pergijalan.patricksantino.com/api/";

//USER
const REGISTER_USER = "register";

const LOGIN_USER = "login";

const LOGOUT_USER = "logout";

const GET_USER = "user";

GET_USER_BY_EMAIL(email) => "email/user?q=$email";

UPDATE_USER(id) => "user/$id";

const GET_USER_BY_ID = "user/";

//OwnerBusiness
const REGISTER_OWNERBUSINESS = "owner/register";

const LOGIN_OWNERBUSINESS = "owner/login";

const LOGOUT_OWNERBUSINESS = "owner/logout";

const GET_OWNER_BY_ID = "owner/";

UPDATE_OWNER(id) => "owner/$id";

//ENDPOINT
//destinasi
const GET_DESTINASI = "destinasi";

GET_DESTINASI_ID(id) => "destinasi/$id";

GET_DESTINASI_IDOWNER(id) => "destinasi/byowner/$id";

const POST_DESTINASI = "destinasi/store";

PUT_DESTINASI(id) => "destinasi/update/$id?";

DELETE_DESTINASI(id) => "destinasi/destroy/$id";

GET_DESTINASI_QUERY(String q) => "search/destinasi?q=$q";

GET_DESTINASI_CITY(String q) => "city/destinasi?q=$q";

GET_DESTINASI_CATEGORY(String q) => "category/destinasi?q=$q";

//review
const GET_REVIEW = "review";

GET_REVIEW_ID(id) => "review/$id";

const POST_REVIEW = "review";

//average rating
GET_AVG_RATING_ID(id) => "rating/$id";

GET_AVG_RATING_BYOWNER(id) => "rating/byowner/$id";

//ticket
const GET_TICKET = "ticket";

GET_TICKET_ID(id) => "ticket/$id";

const POST_TICKET = "ticket";

DELETE_TICKET(idDestinasi) => "ticket/destroy/$idDestinasi";

PUT_TICKET(idDestinasi) => "ticket/update/$idDestinasi?";

GET_TICKETSOLD_OWNER(id) => "ticketsold/owner?id_owner=$id";

GET_TICKETSOLD_DESTINASI(id) => "ticketsold?id_destinasi=$id";

GET_TICKETSOLD_DESTINASI_YEAR(id) => "ticketsold/ownerinyear?id_destinasi=$id&year=";

GET_TICKETSOLD_DESTINASI_MONTH(id, year, month) => "ticketsold/ownerinmonth?id_destinasi=$id&year=$year&month=$month";

GET_TICKETSOLD_DESTINASI_WEEK(id, date) => "ticketsold/ownerinweek?id_destinasi=$id&date=$date";

GET_MOSTSALES_TICKET_BYOWNER(id) => "ticket/mostsales/owner?id_owner=$id";

//eticket
const GET_ETICKET = "eticket";

GET_ETICKET_ID(id) => "eticket/$id";

GET_ETICKET_OWNER(id) => "eticket/byowner/$id";

GET_ETICKET_USER(id) => "eticket/byuser/$id";

GET_ETICKET_TICKET(id) => "eticket/byticket/$id";

GET_ETICKET_BYOWNER_LASTYEAR(id) => "eticket/byowner/year/$id?year=";

GET_ETICKET_BYOWNER_MONTH(id, year, month) =>
    "eticket/byowner/month/$id?year=$year&month=$month";

GET_ETICKET_BYOWNER_WEEK(id, date) => "eticket/byowner/week/$id?date=$date";

const POST_ETICKET = "eticket";

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

//TESTING API
// const BASE_URL = "http://10.0.2.2:8000/api/";
// const BASE_URL = "http://127.0.0.1:8000/api/";
// const BASE_URL = "http://192.168.43.171:8000/api/";
//PRODUCTION
const BASE_URL = "https://pergijalan.patricksantino.com/api/";


//ENDPOINT
//destinasi
const GET_DESTINASI = "destinasi";

GET_DESTINASI_ID(id) => "destinasi/$id";

const POST_DESTINASI = "destinasi/store";

PUT_DESTINASI(id) => "destinasi/update/$id";

DELETE_DESTINASI(id) => "destinasi/destroy/$id";

GET_DESTINASI_QUERY(String q) => "search/destinasi?q=$q";

GET_DESTINASI_CITY(String q) => "city/destinasi?q=$q";

GET_DESTINASI_CATEGORY(String q) => "category/destinasi?q=$q";

//review
const GET_REVIEW = "review";

GET_REVIEW_ID(id) => "review/$id";

const POST_REVIEW = "review";

//ticket
const GET_TICKET = "ticket";

GET_TICKET_ID(id) => "ticket/$id";

const POST_TICKET = "ticket";

DELETE_TICKET(id) => "ticket/destroy/$id";








//PRODUCTION
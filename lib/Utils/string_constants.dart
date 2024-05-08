// ignore_for_file: unnecessary_brace_in_string_interps, camel_case_types

import 'package:get/get.dart';

/// *************** Url *************** ///

// const baseUrl = 'http://192.168.40.153:5004'; // local

const baseUrl = 'http://157.245.107.181:5004/'; // Live
// const baseUrl = 'https://backend.houseofpianosuae.com/'; // client Live

const adminUrl = '${baseUrl}admin/';
const userUrl = '${baseUrl}users/';
const imageUrl = '${baseUrl}public/images/';

/// *************** Global Variables *************** ///

RxBool isInternetAvailable = false.obs;

/// *************** Get storage keys *************** ///

const userData = 'userData';
const authToken = 'authToken';
const isVerifyEmail = 'isVerifyEmail';
const isuserRole = 'userRole';
const payment = 'true';

/// *************** assets images *************** ///

const globalIconPath = 'assets/icon/';

// authentication screen

var logo = '${globalIconPath}Logo.png';
var appleLogo = '${globalIconPath}apple_logo.png';
var googleLogo = '${globalIconPath}google_logo.png';
var whatsapp = '${globalIconPath}whatsapp.png';
var telegram = '${globalIconPath}telegram.png';
// background image

var backgroundImage = '${globalIconPath}Pattern.png';
var authBackgroundImage = '${globalIconPath}authpattern.png';
var noImage = '${globalIconPath}noimage.png';
var packageBanner = '${globalIconPath}package banner.png';
var noInternet = '${globalIconPath}no-internet.png';

// piano rentals screen

var pianoRentals = '${globalIconPath}pianorental.png';
// var piano = '${globalIconPath}piano.png';
var piano = '${globalIconPath}pianomain.png';

// studio rentals & studio details screen

// var studio = '${globalIconPath}studio.png';

var price = '${globalIconPath}Price.png';
var plan = '${globalIconPath}plan.png';
var studioRentals = '${globalIconPath}studiorental.png';

// concert hall screen

var concert = '${globalIconPath}concert.png';
var concertHall = '${globalIconPath}concerthall.png';

//event screen

var event = '${globalIconPath}event.png';
var event1 = '${globalIconPath}event1.png';
var event2 = '${globalIconPath}event2.png';
var eventdate = '${globalIconPath}eventdate.png';
var eventtime = '${globalIconPath}eventtime.png';
var eventname = '${globalIconPath}eventname.png';
var eventtic = '${globalIconPath}eventtic.png';
var eventartist = '${globalIconPath}eventartist.png';
var eventtic1 = '${globalIconPath}ticketcet.png';
var paytabsImage = '${globalIconPath}paytabs.png';
var eventConcert = '${globalIconPath}event.png';
var entryTime = '${globalIconPath}EntryTime.png';

//piano teacher screen

var pianoTeach = '${globalIconPath}pianotech.png';
var done = '${globalIconPath}done.png';
var pianoTeacher = '${globalIconPath}pianoteacher.png';

// piano services

var pianoServices = '${globalIconPath}pianoservices.png';

// authentication screen

var person = '${globalIconPath}person.png';
var call = '${globalIconPath}call.png';
var email = '${globalIconPath}email.png';
var lock = '${globalIconPath}lock.png';
var address = '${globalIconPath}address.png';

//  welcome screen

var homeIcon = '${globalIconPath}home.png';
var faqIcon = '${globalIconPath}faq.png';
var myActivityIcon = '${globalIconPath}myactivity.png';
var profileIcon = '${globalIconPath}profile.png';
var notification = '${globalIconPath}notification.png';
var logout = '${globalIconPath}logout.png';

//  faq screen

var houseFaq = '${globalIconPath}houseofpiano.png';

// local icon

var backIcon = '${globalIconPath}backicon.png';
var menuBackIcon = '${globalIconPath}menuback.png';
var dropdown = '${globalIconPath}dropdown.png';
var uparrow = '${globalIconPath}uparrow.png';
var desc = '${globalIconPath}description_icon.png';
var terms = '${globalIconPath}terms.png';
var bookhistory = '${globalIconPath}bookhistory.png';
var amount = '${globalIconPath}totalamount.png';

//Failed screen screen

var failed = '${globalIconPath}failed.png';

//successful screen

var successful = '${globalIconPath}successful.png';

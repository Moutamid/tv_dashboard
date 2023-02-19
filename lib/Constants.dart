import 'package:flutter/material.dart';

TextStyle textStyleNormal() {
  return TextStyle(color: Colors.black, fontSize: 12, decoration: TextDecoration.none);
}

TextStyle textStyleBold() {
  return TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, decoration: TextDecoration.none);
}

const String CHILD_USERS = 'USERS';
const String CHILD_TOKENS = 'TOKENS';
const String CHILD_CHANNELS = 'CHANNELS';
const String CHILD_EVENTS = 'EVENTS';
const String CHILD_CHANNEL_COUNTRIES = 'CHANNEL_COUNTRIES';
const String CHILD_CHANNEL_CATEGORIES = 'CHANNEL_CATEGORIES';
const String CHILD_EVENT_COUNTRIES = 'EVENT_COUNTRIES';
const String CHILD_EVENT_CATEGORIES = 'EVENT_CATEGORIES';

const String TEXT_USERS = 'Users';
const String TEXT_TOKENS = 'Tokens';
const String TEXT_CHANNELS = 'Channels';
const String TEXT_VIEW_ALL_CHANNELS = 'View All Channels';
const String TEXT_CHANNEL_COUNTRIES = 'Channel Countries';
const String TEXT_CHANNEL_CATEGORIES = 'Channel Categories';
const String TEXT_EVENTS = 'Events';
const String TEXT_VIEW_ALL_EVENTS = 'View All Events';
const String TEXT_EVENT_COUNTRIES = 'Events Countries';
const String TEXT_EVENT_CATEGORIES = 'Events Categories';
const String TEXT_SCRAPING = 'Scraping';

/*enum CurrentText {
  TEXT_USERS,
  TEXT_TOKENS,
  TEXT_CHANNELS,
  TEXT_VIEW_ALL_CHANNELS,
  TEXT_CHANNEL_COUNTRIES,
  TEXT_CHANNEL_CATEGORIES,
  TEXT_EVENTS,
  TEXT_VIEW_ALL_EVENTS,
  TEXT_EVENT_COUNTRIES,
  TEXT_EVENT_CATEGORIES,
  TEXT_SCRAPING
}*/

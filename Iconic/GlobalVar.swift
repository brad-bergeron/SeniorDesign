//
//  GlobalVar.swift
//  Iconic
//
//  Created by admin on 5/3/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation
import UIKit



var filteredEvents = [SingleEvent]() //Holds the events that were filtered
var filtered : Bool = false //If it is filtered use the constantFilteredEvents instead of the events
var seenEvents = [SingleEvent]() //The events that show up on page always
var toggleFilter : Bool = false //false means it starts in the off postion
var movieFilter : Bool = false // the movie filter should start off
var comedyFilter : Bool = false //the comedy filter should start off
var twentyOneFilter : Bool = false //the 21+ filter should start off
var musicFilter : Bool = false // the music filter should start off
var familyFilter : Bool = false // the family filter should start off
var educationFilter : Bool = false // the education filter should start off

var favorites = [SingleEvent]() //Holds the favorited events
var searchedFavorites = [SingleEvent]() //Holds the Searched favorited Events
var linkedIntoEvent : Bool = false //If the User links in from a shared Event we want to go to the event page  right away
var EventLinked = String() //Name of event Linking in from ur;

let ourGreen = UIColor(red: 48/255.0, green: 180/255.0, blue: 74/255.0, alpha: 1.0)
let ourOrange = UIColor(red: 243/255.0, green: 114/255.0, blue: 50/255.0, alpha: 1.0)
let lightBlueColor = UIColor(colorLiteralRed: 84/255.0, green: 199/255.0, blue: 252/255.0, alpha: 1.0)


let poorString = "to be implemented"

let helpHome = "Swipe left for filters \n Swipe right for favorites \n Swipe right in a cell to favorite or unfavorite an event, favorited events are outlined in Iconic orange\n Click on a cell to view more details about the event"

let helpFav = "Once an event is favorited, it will appear here \n Click on the image to view more details about the event \n Favorite or unfavorite an event by dragging within a cell on the home page or by clicking the star in the in the event details page \n Favorited events appear Iconic orange"

let helpFilt = "Enable filters by clicking the switch \n Activate a filter by tapping on them, filter icon will appear white and filter name will appear on the bottom bar \n Turn a filter off by tapping the active filter, filter icon will appear gray \n "
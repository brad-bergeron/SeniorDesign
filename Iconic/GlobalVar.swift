//
//  GlobalVar.swift
//  Iconic
//
//  Created by admin on 5/3/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import Foundation


var filteredEvents = [SingleEvent]() //Holds the events that were filtered
var filtered : Bool = false //If it is filtered use the constantFilteredEvents instead of the events
var seenEvents = [SingleEvent]() //The events that show up on page always
var toggleFilter : Bool = false //false means it starts in the off postion
var movieFilter : Bool = false // the movie filter should start off
var comedyFilter : Bool = false //the comedy filter should start off
var twentyOneFilter : Bool = false //the 21+ filter should start off
var musicFilter : Bool = false // the music filter should start off
var favorites = [SingleEvent]() //Holds the favorited events
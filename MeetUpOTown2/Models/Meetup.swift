//
//  Meetup.swift
//  MeetUpOTown2
//
//  Created by Dean Thibault on 5/9/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import Foundation

class Meetup {
	
	let ms: Double = 1000
	
	var name: String
	var meetupTime: NSNumber
	var group: String
	var description: String
	var id: String
	
	var isFavorite: Bool {
		return Favorites.isFavorite(meetup: self)
	}
	
	init(name: String, time: NSNumber, group: String, description: String, id: String) {
		
		self.name = name
		self.meetupTime = time
		self.group = group
		self.description = description
		self.id = id
	}
	
	func date() -> String {
		
		let time: TimeInterval = meetupTime.doubleValue/ms
		let date = Date(timeIntervalSince1970: time)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEE MMM dd"
		return dateFormatter.string(from: date)
	}

	func time() -> String {
		
		let time: TimeInterval = meetupTime.doubleValue/ms
		let date = Date(timeIntervalSince1970: time)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "hh:mm aaa"
		return dateFormatter.string(from: date)
	}

	func dateTime() -> String {
		
		let time: TimeInterval = meetupTime.doubleValue/ms
		let date = Date(timeIntervalSince1970: time)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEE MMM dd hh:mm aaa"
		return dateFormatter.string(from: date)
	}
	
	func setFavorite() {
		
		if isFavorite {
			
			Favorites.removeFavorite(meetup: self)
		}
		else {
			Favorites.addFavorite(meetup: self)
		}
	}
}

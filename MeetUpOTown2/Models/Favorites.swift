//
//  Favorites.swift
//  MeetUpOTown2
//
//  Created by Dean Thibault on 5/10/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import Foundation

class Favorites {
	
	static let favoritesFile = "favorites.plist"
	
	static var favorites: [String] = []
	
	static func load() {
	
		let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
	
		let filePath = String(format:"%@/%@", documentsDirectory, Favorites.favoritesFile)
		if let favorites = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [String] {
			self.favorites = favorites
		}
	}

	static func save()
	{
		let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
		
		let filePath = String(format:"%@/%@", documentsDirectory, Favorites.favoritesFile)
		NSKeyedArchiver.archiveRootObject(favorites, toFile: filePath)
	}

	static func isFavorite(meetup: Meetup) -> Bool {
		
		return !favorites.filter{ $0 == meetup.id}.isEmpty
	}

	static func removeFavorite(meetup: Meetup) {
		
		favorites = favorites.filter{ $0 != meetup.id}
		save()
	}
	
	static func addFavorite(meetup: Meetup) {
		
		guard !isFavorite(meetup: meetup) else { return }
		
		favorites.append(meetup.id)
		save()
	}
	
	static func removeAll() {
		
		favorites = []
		save()
	}
}

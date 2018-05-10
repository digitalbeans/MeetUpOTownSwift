//
//  FavoritesTest.swift
//  MeetUpOTown2Tests
//
//  Created by Dean Thibault on 5/10/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import XCTest
@testable import MeetUpOTown2

class FavoritesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()

		Favorites.load()
		Favorites.removeAll()
	}
    
    override func tearDown() {

		super.tearDown()

		Favorites.removeAll()
	}
    
    func testFavorites() {

		let meetup1 = Meetup(name: "meetup1",
							time: NSNumber(value: NSDate().timeIntervalSince1970),
							group: "group1",
							description: "some description",
							id: "abc123")

		let meetup2 = Meetup(name: "meetup2",
							 time: NSNumber(value: NSDate().timeIntervalSince1970),
							 group: "group2",
							 description: "some description",
							 id: "def345")
		
		Favorites.addFavorite(meetup: meetup1)
		
		// verify favorite added
		XCTAssertTrue(Favorites.isFavorite(meetup: meetup1))
		// verify not favorite
		XCTAssertFalse(Favorites.isFavorite(meetup: meetup2))
		
		Favorites.addFavorite(meetup: meetup2)
		
		// verify should be 2 favorites after add
		XCTAssertEqual(Favorites.favorites.count, 2)
		Favorites.removeFavorite(meetup: meetup1)
		//verify should be 1 favorite after remove
		XCTAssertEqual(Favorites.favorites.count, 1)

		// verify only 1 favorite
		XCTAssertTrue(Favorites.isFavorite(meetup: meetup2))
		XCTAssertFalse(Favorites.isFavorite(meetup: meetup1))

		Favorites.removeFavorite(meetup: meetup2)
		// verify no favorites remaining
		XCTAssertEqual(Favorites.favorites.count, 0)
	}
}

//
//  MeetupTests.swift
//  MeetUpOTown2Tests
//
//  Created by Dean Thibault on 5/10/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import XCTest
@testable import MeetUpOTown2

class MeetupTests: XCTestCase {
	
	let nameText = "meetup1"
	let time = NSNumber(value: NSDate().timeIntervalSince1970)
	let group = "group1"
	let descriptionText = "some description"
	let id = "abc123"

	var meetup: Meetup?
	
    override func setUp() {
        super.setUp()

		meetup = Meetup(name: nameText,
							 time: time,
							 group: group,
							 description: descriptionText,
							 id: id)

		Favorites.load()
		Favorites.removeAll()
	}
    
    override func tearDown() {

		super.tearDown()
		
		Favorites.removeAll()
    }
    
    func testCreateMeetup() {
		
		guard let meetup = meetup else {
			
			XCTFail()
			return
		}
		
		XCTAssertEqual(meetup.name, nameText)
		XCTAssertEqual(meetup.meetupTime, time)
		XCTAssertEqual(meetup.group, group)
		XCTAssertEqual(meetup.description, descriptionText)
		XCTAssertEqual(meetup.id, id)
	}
	
	func testFavoriteMeetup() {
		
		guard let meetup = meetup else {
			
			XCTFail()
			return
		}
		
		XCTAssertFalse(meetup.isFavorite)
		meetup.setFavorite()
		XCTAssertTrue(meetup.isFavorite)
		meetup.setFavorite()
		XCTAssertFalse(meetup.isFavorite)
	}
}

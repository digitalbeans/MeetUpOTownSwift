//
//  MeetupDownload.swift
//  MeetUpOTown2
//
//  Created by Dean Thibault on 5/9/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MeetupDownload {
	
//	var delegate: MeetupDelegateProtocol?

	// You need to create your own api key, here: https://secure.meetup.com/meetup_api/key/
	// and specify it here:
	let apiKey = "22725b25d57246332554b5c6e2e242c"

//https://api.meetup.com/2/open_events?&sign=true&photo-host=public&country=us&city=Orlando&state=fl&time=,1m&radius=100&page=20
	
	let openEventsURL = "https://api.meetup.com/2/open_events?format=json&text_format=plain&order=time&country=us&city=%@&state=%@&time=,6m&radius=25&page=20&offset=%d&key=%@"
	
	func searchMeetups(with city: String, state: String, offset: Int, completion: @escaping ([Meetup]?) -> Void) {
		
		let urlString = String(format: openEventsURL, city, state, offset, apiKey)
		
		guard let url = URL(string: urlString) else {
			completion(nil)
			return
		}
		
		Alamofire.request(url,
						  method: .get,
						  parameters: ["include_docs": "true"])
			.validate()
			.responseJSON { response in
				guard response.result.isSuccess else {
					
					completion(nil)
					return
				}
				
				guard let value = response.result.value as? [String: Any] else {
						print("Malformed data received from searchMeetups service")
						completion(nil)
						return
				}

				let meetups = JSON(value)[Constants.response.results].array?.map { json -> Meetup in

					Meetup(name: json[Constants.response.name].stringValue,
						   time: json[Constants.response.time].numberValue,
						   group: json[Constants.response.group].dictionaryValue[Constants.response.name]?.stringValue ?? "",
						   description: json[Constants.response.description].stringValue,
						   id: json[Constants.response.id].stringValue)
				}

				completion(meetups)
		}
	}
}

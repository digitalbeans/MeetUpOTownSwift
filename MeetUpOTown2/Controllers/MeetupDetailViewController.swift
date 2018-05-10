//
//  MeetupDetailViewController.swift
//  MeetUpOTown2
//
//  Created by Dean Thibault on 5/10/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit

class MeetupDetailViewController: UIViewController {

	@IBOutlet var dateLabel: UILabel!
	@IBOutlet var groupNameLabel: UILabel!
	@IBOutlet var meetupNameLabel: UILabel!
	@IBOutlet var descriptionTextView: UITextView!
	@IBOutlet var favoriteButton: UIButton!

	var meetup: Meetup?
	
    override func viewDidLoad() {
		
        super.viewDidLoad()

		if let meetup = meetup {
			
			meetupNameLabel.text = meetup.name
			groupNameLabel.text = meetup.group
			dateLabel.text = meetup.dateTime()
			descriptionTextView.text = meetup.description
			setFavoriteButtonImage(isFavorite: meetup.isFavorite)
		}
    }

	@IBAction func didTapFavoriteButton(_ sender: Any) {

		guard let meetup = meetup else { return }
		
		meetup.setFavorite()
		setFavoriteButtonImage(isFavorite: meetup.isFavorite)
	}
	
	func setFavoriteButtonImage(isFavorite: Bool) {
		
		if isFavorite {
			
			favoriteButton.setImage(UIImage(named: "blue-heart"), for: .normal)
		}
		else {
			
			favoriteButton.setImage(UIImage(named: "gray-heart"), for: .normal)
		}
	}
}

//
//  MeetupCell.swift
//  MeetUpOTown2
//
//  Created by Dean Thibault on 5/9/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit

class MeetupCell: UITableViewCell {

	@IBOutlet var dateLabel: UILabel!
	@IBOutlet var timeLabel: UILabel!
	@IBOutlet var groupNameLabel: UILabel!
	@IBOutlet var meetupNameLabel: UILabel!

    override func awakeFromNib() {

		super.awakeFromNib()
    }

	func setup(with meetup: Meetup) {
		
		dateLabel?.text = meetup.date()
		timeLabel?.text = meetup.time()
		groupNameLabel?.text = meetup.group
		meetupNameLabel?.text = meetup.name
	}
}

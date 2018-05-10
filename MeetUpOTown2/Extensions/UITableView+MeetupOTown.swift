//
//  UITableView+MeetupOTown.swift
//  MeetUpOTown2
//
//  Created by Dean Thibault on 5/10/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	
	func emptyMessage(message:String) -> UILabel {
		
		let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: bounds.size.width, height: bounds.size.height))
		let messageLabel = UILabel(frame: rect)
		messageLabel.text = message
		messageLabel.textColor = UIColor.black
		messageLabel.numberOfLines = 0;
		messageLabel.textAlignment = .center;
		messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
		messageLabel.sizeToFit()
		
		return messageLabel
	}
}

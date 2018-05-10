//
//  MeetupsTableViewController.swift
//  MeetUpOTown2
//
//  Created by Dean Thibault on 5/9/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit

class MeetupsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	var favoritesButton: UIBarButtonItem?
	var refreshControl = UIRefreshControl()
	
	let city = "Orlando"
	let state = "fl"
	
	var meetups: [Meetup] = []
	let meetupDownload = MeetupDownload()
	var pageOffset: Int = 0
	var showFavorites: Bool = false
	
	var favorites: [Meetup] {
		return meetups.filter({ $0.isFavorite })
	}
	
	override func viewDidLoad() {
		
        super.viewDidLoad()
		
		navigationItem.title = Constants.app.title
		
		getViewPreference()
		favoritesButton = UIBarButtonItem(title: favoriteButtonTitle(), style: .plain, target: self, action: #selector(didTapFavorites(_:)))
		navigationItem.rightBarButtonItem = favoritesButton
		
		let nib = UINib.init(nibName: MeetupCell.reuseIdentifier(), bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: MeetupCell.reuseIdentifier())

		tableView.addSubview(refreshControl)
		refreshControl.attributedTitle = NSAttributedString(string: Constants.app.refresh)
		refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

		fetchMeetups(city: city, state: state)
    }

	override func viewDidAppear(_ animated: Bool) {
		
		super.viewDidAppear(animated)
		
		tableView.reloadData()
	}
	
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if showFavorites {
			
			return favorites.count
		}
		else {
			
        	return meetups.count
		}
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: MeetupCell.reuseIdentifier(), for: indexPath) as? MeetupCell else {
			return UITableViewCell()
		}

		var meetup: Meetup
		if showFavorites {
			meetup = favorites[indexPath.row]
		}
		else {
        	meetup = meetups[indexPath.row]
		}
		
		cell.setup(with: meetup)

        return cell
    }

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)
		
		let meetup = meetups[indexPath.row]
		
		let detailViewController = MeetupDetailViewController(nibName: "MeetupDetailViewController", bundle: nil)
		detailViewController.meetup = meetup
		navigationController?.pushViewController(detailViewController, animated: true)

	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		
		let reloadDistance: CGFloat = 50

		let offset = scrollView.contentOffset
		let bounds = scrollView.bounds
		let inset = scrollView.contentInset
		let y = offset.y + bounds.size.height - inset.bottom
		let height = scrollView.contentSize.height
		
		if y > height + reloadDistance {
			
			activityIndicator.startAnimating()
			fetchMeetups(city: city, state: state)
		}
	}
}

extension MeetupsTableViewController {
	
	@objc func refresh() {
		
		meetups = []
		pageOffset = 0
		fetchMeetups(city: city, state: state)
	}
}

// MARK: - Data retrieval

extension MeetupsTableViewController {
	
	func fetchMeetups(city: String, state: String) {
		
		activityIndicator.isHidden = false
		activityIndicator.startAnimating()

		meetupDownload.searchMeetups(with: city, state: state, offset: pageOffset) { (meetups) in
			
			self.activityIndicator.stopAnimating()
			self.activityIndicator.isHidden = true
			self.refreshControl.endRefreshing()
			
			guard let meetups = meetups else {
				
				self.emptyMessage(isDisplayed: true)
				self.tableView.reloadData()
				return
			}
			
			self.pageOffset = self.pageOffset + 1
			
			self.meetups.append(contentsOf: meetups)
			self.emptyMessage(isDisplayed: false)
			self.tableView.reloadData()
		}
	}
	
	func emptyMessage(isDisplayed: Bool) {
		
		DispatchQueue.main.async() {
			if isDisplayed {
				
				self.tableView.backgroundView = self.tableView.emptyMessage(message: "Sorry, no meetups found")
				self.tableView.separatorStyle = .none
			}
			else {
				
				self.tableView.backgroundView = nil
				self.tableView.separatorStyle = .singleLine
			}
		}
	}
}

// MARK: - Favorites

extension MeetupsTableViewController {

	@IBAction func didTapFavorites(_ sender: Any) {
		
		showFavorites = !showFavorites
		favoritesButton?.title = favoriteButtonTitle()
		saveViewPreference()
		tableView.reloadData()
	}

	func favoriteButtonTitle() -> String {
		if showFavorites {
			return Constants.favorites.all
		}
		else {
			return Constants.favorites.favorites
		}
	}
	
	func saveViewPreference() {
		
		UserDefaults.standard.set(showFavorites, forKey: Constants.favorites.favorites)
	}
	
	func getViewPreference() {
		
		showFavorites = UserDefaults.standard.bool(forKey: Constants.favorites.favorites)
	}

}

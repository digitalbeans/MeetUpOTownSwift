# MeetUpOTown

MeetUpOTown demonstrates using the Meetup.com RESTful API to retrieve display a list of upcoming meetups in 
the Orlando, FL, area, for the next month, using Alamofire for network requests.

It will initially display the first 20 meetups, and when you 
scroll to the end of the list, will download and display the next available 20 meetups. 

It uses NSKeyedArchiver, to save a 'favorites' list,  that can be use to save and display a list of 
your favorite meetups.

It uses UserDefaults to save user preference for displaying all matching meetups or just favorites.

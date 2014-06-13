//
//  ViewController.swift
//  simple-swift-project
//
//  Created by ctrl-alt-del on 6/8/14.
//  Copyright (c) 2014 ctrl-alt-del. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var checkTime : UILabel
    @IBOutlet var night : UIButton
    
    @IBOutlet var tableView : UITableView
    
    let dateFormatter = NSDateFormatter()
    let greetingButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTimerFn"), userInfo: nil, repeats: true)
        
        dateFormatter.dateFormat = "h:mm:ss a"
        
        greetingButton.frame = CGRectMake(25, 25, 250, 25)
        greetingButton.setTitle("Say \"Hello World!\" and display time", forState: UIControlState.Normal)
        greetingButton.addTarget(self, action: "callback_01:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(greetingButton)
        
        night.addTarget(self, action: "changeBackgroundColor", forControlEvents: UIControlEvents.TouchUpInside)
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var listForTableView = ["Apple", "Banana", "Coconut", "Durian", "Elderberry", "Fig", "Guava"]
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if (tableView == appsTableView) {
            return tableData.count
        } else if (tableView == self.tableView) {
            return listForTableView.count
        } else {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "SimpleCell")
        
        if (tableView == self.appsTableView) {
            
            // Get the data of the current row and make cast it as an HashMap aka NSDictinary in this case
            var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
            
            // Get the name
            var name: String = rowData["trackName"] as String
            
            // Get the artworkUrl60 key to get an image URL for the app's thumbnail
            var urlString: NSString = rowData["artworkUrl60"] as NSString
            var imgURL: NSURL = NSURL(string: urlString)
            
            // Get image data from the url
            var imageData: NSData = NSData(contentsOfURL: imgURL)
            
            // Get the price
            var price: NSString = rowData["formattedPrice"] as NSString
            
            cell.text = name
            cell.detailTextLabel.text = price
            cell.image = UIImage(data: imageData)
            
        } else if (tableView == self.tableView) {
            cell.text = "#\(indexPath.row) " + listForTableView[indexPath.row]
            cell.detailTextLabel.text = "Fruit #\(indexPath.row)"
        } else {
            cell.text = "Error"
            cell.detailTextLabel.text = "Oops.."
        }
        return cell
    }
    
    
    // ======= functions =========
    
    func callback_01(sender: UIButton!) {
        
        var date = NSDate()
        
        checkTime.text = "Hello World! " + dateFormatter.stringFromDate(date)
        println("Hello World! " + dateFormatter.stringFromDate(date))
    }
    
    func updateTimerFn() {
        checkTime.text = dateFormatter.stringFromDate(NSDate())
    }
    
    func changeBackgroundColor() {
        
        if (night.titleLabel.text.compare("Night") == 0) {
            night.setTitle("Day", forState: UIControlState.Normal)
            night.backgroundColor = UIColor.blackColor()
            checkTime.textColor = UIColor.whiteColor()
            tableView.backgroundColor = UIColor.blackColor()
            self.view.backgroundColor = UIColor.blackColor()
        } else {
            night.setTitle("Night", forState: UIControlState.Normal)
            night.backgroundColor = UIColor.whiteColor()
            checkTime.textColor = UIColor.blackColor()
            tableView.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    
    
    @IBOutlet var appsTableView : UITableView
    
    func iTuneAPISearchRequest(givenTerms: String) {
        
        // Replace spaces with + signs
        var terms = givenTerms.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Escape
        var escapedTerm = terms.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        // Compose url string
        var urlPath = "https://itunes.apple.com/search?term=\(escapedTerm)&media=software"
        
        // Make an NSURL object based on the urlPath
        var url: NSURL = NSURL(string: urlPath)
        
        // Establish an NSURLRequest object
        var request: NSURLRequest = NSURLRequest(URL: url)
        
        // Make an NSURLConnection object based on the NSURLRequest created
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        println("Search iTunes API at URL \(url)")
        
        // Conneceting to the internet
        connection.start()
    }
    
    var data: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Get the response of a request, setup a mutable data object to ready for receiving data
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append recieved data
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        var err: NSError
        
        // Deserialization JSON into HashMap assuming the data received is a serialized JSON
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:    NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        // Make sure the json contains info, and the "result" package inside it contains info as well
        if (json.count > 0 && json["results"].count>0) {
            
            // Cast and JSON Array into NSArray
            var results: NSArray = json["results"] as NSArray
            self.tableData = results
            
            // Activate the "tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!" function in above to reload the info into the table view
            self.appsTableView.reloadData()
        }
    }
}


//
//  ViewController.swift
//  simple-swift-project
//
//  Created by ctrl-alt-del on 6/8/14.
//  Copyright (c) 2014 ctrl-alt-del. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIControllerProtocol {
    
    @IBOutlet var checkTime : UILabel
    @IBOutlet var night : UIButton
    
    @IBOutlet var tableView : UITableView
    @IBOutlet var appsTableView : UITableView
    
    var tableData: NSArray = NSArray()
    
    let dateFormatter = NSDateFormatter()
    let greetingButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    var api: APIController = APIController()
    
    
    /**
    * dictionary used to cache images
    */
    var imageCache = NSMutableDictionary()
    
    func didReceiveAPIResults(results: NSDictionary) {
        // Store the results in our table data array
        println("------> didRecieveAPIResults is called, with results.counts = \(results.count)")
        if (results.count > 0) {
            // Cast and JSON Array into NSArray
            self.tableData = results["results"] as NSArray
            self.appsTableView.reloadData()
            println("===> display API results")
        }
    }
    
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
        
        println(">>> calling API")
        api.delegate = self
        api.iTuneAPISearchRequest("apple")
        
        println(">>> done with API \(api.delegate?)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var listForTableView = ["Apple", "Banana", "Coconut", "Durian", "Elderberry", "Fig", "Guava"]
    
    /**
    * Overriden Method
    * Method used to return the count of the selected tableView object
    *
    * @param tableView := the selected UITableView object
    * @param section := the number of rows in section
    *
    * @return the count of selected UITableView
    */
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case appsTableView:
            return tableData.count
        case self.tableView:
            return listForTableView.count
        default:
            return 0
        }
    }
    
    let apiCellRef: String = "ApiCell"
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell: UITableViewCell? = appsTableView.dequeueReusableCellWithIdentifier(apiCellRef) as? UITableViewCell
        
        if !cell {
            cell = UITableViewCell(style:.Subtitle, reuseIdentifier: apiCellRef)
        }
        
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
            
            cell!.text = name
            cell!.detailTextLabel.text = price
            
            cell!.image = UIImage(data: imageData)
            return cell
        } else if (tableView == self.tableView) {
            
            cell!.text = "#\(indexPath.row) " + listForTableView[indexPath.row]
            cell!.detailTextLabel.text = "Fruit #\(indexPath.row)"
            return cell
        } else {
            
            cell!.text = "Error"
            cell!.detailTextLabel.text = "Oops.."
            return cell
        }
        
    }
    
    // callback function of each cell
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        //Define a UIAlertView with Swift way
        var alert = UIAlertView()
        alert.addButtonWithTitle("Ok")
        
        switch tableView {
        case self.appsTableView:
            
            var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
            
            var name: String = rowData["trackName"] as String
            var formattedPrice: String = rowData["formattedPrice"] as String
            
            alert.title = name
            alert.message = formattedPrice
            
        case self.tableView:
            alert.title = self.listForTableView[indexPath.row]
            alert.message = "Fruit #\(indexPath.row)"
            
        default:
            alert.title = "Error"
            alert.message = "You pressed item #\(indexPath.row)"
        }
        
        alert.show()
    }
    
    
    
    // MARK: Private Methods
    
    /**
    * private method used to change the text with specified string
    */
    func callback_01(sender: UIButton!) {
        
        var date = NSDate()
        
        checkTime.text = "Hello World! " + dateFormatter.stringFromDate(date)
        println("Hello World! " + dateFormatter.stringFromDate(date))
    }
    
    
    /**
    * private method used to change the text with current time
    */
    func updateTimerFn() {
        checkTime.text = dateFormatter.stringFromDate(NSDate())
    }
    
    /**
    * private method used to change the background color of the app
    */
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
}


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
    var data: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
}


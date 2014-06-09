//
//  ViewController.swift
//  simple-swift-project
//
//  Created by Berkelium on 6/8/14.
//  Copyright (c) 2014 ctrl-alt-del. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var checkTime : UILabel
    let dateFormatter = NSDateFormatter()
    let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton

        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTimerFn"), userInfo: nil, repeats: true)

        dateFormatter.dateFormat = "h:mm:ss a"
        
        
        button.frame = CGRectMake(25, 25, 250, 25)
        button.setTitle("Say \"Hello World!\" and display time", forState: UIControlState.Normal)
        button.addTarget(self, action: "callback_01:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func callback_01(sender: UIButton!) {
        
        var date = NSDate()
        
        checkTime.text = "Hello World! " + dateFormatter.stringFromDate(date)
        println("Hello World! " + dateFormatter.stringFromDate(date))
    }
    
    func updateTimerFn() {
        checkTime.text = dateFormatter.stringFromDate(NSDate())
    }
}


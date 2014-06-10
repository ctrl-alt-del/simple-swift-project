//
//  ViewController.swift
//  simple-swift-project
//
//  Created by ctrl-alt-del on 6/8/14.
//  Copyright (c) 2014 ctrl-alt-del. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var checkTime : UILabel
    @IBOutlet var night : UIButton
    
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


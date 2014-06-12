//
//  TaskViewController.swift
//  simple-swift-project
//
//  Created by ctrl-alt-del on 6/11/14.
//  Copyright (c) 2014 ctrl-alt-del. All rights reserved.
//

import Foundation
import UIKit

class TaskViewController: UIViewController {
    
   
    @IBOutlet var taskLabel : UILabel
    @IBAction func completeTask(sender : UIButton!) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

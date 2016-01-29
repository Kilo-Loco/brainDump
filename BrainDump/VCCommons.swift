//
//  ViewControllerStyling.swift
//  BrainDump
//
//  Created by Kyle Lee on 12/14/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

class VCCommons: UIViewController {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1.0)
    }
}

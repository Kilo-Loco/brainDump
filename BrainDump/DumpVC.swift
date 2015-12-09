//
//  DumpVC.swift
//  BrainDump
//
//  Created by Kyle Lee on 12/2/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

class DumpVC: UIViewController {
    
    @IBOutlet weak var dumpTitle: UILabel!
    @IBOutlet weak var dumpNote: UILabel!
    
    var selectedDump: Dump?

    // MARK: General View Setup
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dumpTitle.text = self.selectedDump?.title
        self.dumpNote.sizeToFit()
        self.dumpNote.text = self.selectedDump?.note
    }

    // MARK: Button Functionality
    @IBAction func backToCategoriesVC(sender: UIButton) {
        performSegueWithIdentifier("DumpToCategories", sender: nil)
    }
}

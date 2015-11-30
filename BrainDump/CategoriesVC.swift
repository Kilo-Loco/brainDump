//
//  CategoriesVC.swift
//  BrainDump
//
//  Created by Kyle Lee on 11/28/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    @IBAction func backBtnPressed(sender: UIButton) {
        performSegueWithIdentifier("CategoriesToVC", sender: nil)
    }
    
}

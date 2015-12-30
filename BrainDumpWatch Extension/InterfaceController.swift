//
//  InterfaceController.swift
//  BrainDumpWatch Extension
//
//  Created by Kyle Lee on 12/26/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import WatchKit
import Foundation



class InterfaceController: WKInterfaceController {
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        print("Dumps are:")
        
    }


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func composeDumpBtnPressed() {
        
    }
    

}

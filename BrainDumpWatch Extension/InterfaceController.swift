//
//  InterfaceController.swift
//  BrainDumpWatch Extension
//
//  Created by Kyle Lee on 12/26/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import WatchKit
import Foundation
import CoreData


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var dumpTable: WKInterfaceTable!
    
    var watchDumps = [Dump]()
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
//        self.dumpTable.setNumberOfRows(3, withRowType: "tableRowController")
//        
//        let row = self.dumpTable.rowControllerAtIndex(0) as? tableRowController
//        
//        row?.dumpNoteLbl.setText("dump note info")
        
    }
    
    func fetchAndSetResult() {
        
        let fetchRequest = NSFetchRequest(entityName: "Dump")
        
        do {
            let results = try CONTEXT.executeFetchRequest(fetchRequest)
            self.watchDumps = results as! [Dump]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func didAppear() {
        self.fetchAndSetResult()
        //suppose to reload data?
        
        self.dumpTable.setNumberOfRows(self.watchDumps.co, withRowType: "tableRowController")
        
        //let row = self.dumpTable.rowControllerAtIndex(0) as? tableRowController
        
        let row = self.dumpTable.rowControllerAtIndex(0) as? tableRowController
        
        row?.dumpNoteLbl.setText("dump note info")
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

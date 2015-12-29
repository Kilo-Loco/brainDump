//
//  tableRowController.swift
//  BrainDump
//
//  Created by Kyle Lee on 12/28/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import WatchKit
import CoreData

class tableRowController: NSObject {

    @IBOutlet var dumpTitleLbl: WKInterfaceLabel!
    @IBOutlet var dumpNoteLbl: WKInterfaceLabel!
    @IBOutlet var dumpDateLbl: WKInterfaceLabel!
    
    func configureRow(dump: Dump) {
        
        self.dumpTitleLbl.setText(dump.title)
        self.dumpNoteLbl.setText(dump.note)
        self.dumpDateLbl.setText(NSDateFormatter.localizedStringFromDate(dump.date!, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle))
    }
    
    
}

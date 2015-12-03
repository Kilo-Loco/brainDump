//
//  DumpCell.swift
//  BrainDump
//
//  Created by Kyle Lee on 11/30/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

class DumpCell: UITableViewCell {
    
    @IBOutlet weak var dumpTitle: UILabel!
    @IBOutlet weak var dumpNote: UILabel!
    @IBOutlet weak var dumpDate: UILabel!
    @IBOutlet weak var dumpCategoryColor: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(dump: Dump) {
        self.dumpTitle.text = dump.note
        self.dumpNote.text = dump.note
        self.dumpDate.text = NSDateFormatter.localizedStringFromDate(dump.date!, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        self.dumpCategoryColor.backgroundColor = UIColor.clearColor()
    }
    

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    

}

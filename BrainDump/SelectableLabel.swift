//
//  SelectableLabel.swift
//  BrainDump
//
//  Created by Kyle Lee on 12/17/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

class SelectableLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sharedInit()
    }
    
    func sharedInit() {
        self.userInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "showMenu:"))
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func copy(sender: AnyObject?) {
        let board = UIPasteboard.generalPasteboard()
        board.string = text
        let menu = UIMenuController.sharedMenuController()
        menu.setMenuVisible(false, animated: true)
    }
    
    func showMenu(sender: AnyObject?) {
        self.becomeFirstResponder()
        let menu = UIMenuController.sharedMenuController()
        if !menu.menuVisible {
            menu.setTargetRect(bounds, inView: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == "copy:" {
            return true
        }
        return false
    }


}

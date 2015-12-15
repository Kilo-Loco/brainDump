//
//  Constants.swift
//  BrainDump
//
//  Created by Kyle Lee on 12/14/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

let CTA = "What's on your mind?"

let APP = UIApplication.sharedApplication().delegate as! AppDelegate
let CONTEXT = APP.managedObjectContext

func SAVE() {
    do {
        
        try CONTEXT.save()
        print("Save successful")
    } catch {
        
        print("Error saving")
    }
}

//func KEYBOARD_WILL_SHOW(notif: NSNotification, btmConstraint: CGFloat, margin: Int, view: UIView) {
//    
//    if let userInfo = notif.userInfo {
//        if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
//            var constraint = btmConstraint
//            constraint = (keyboardHeight + CGFloat(margin))
//            UIView.animateWithDuration(0.25, animations: { () -> Void in
//                view.layoutIfNeeded()
//            })
//        }
//    }
//}


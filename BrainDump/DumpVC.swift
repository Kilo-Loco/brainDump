//
//  DumpVC.swift
//  BrainDump
//
//  Created by Kyle Lee on 12/2/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

class DumpVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var dumpTitle: UILabel!
    @IBOutlet weak var dumpNote: UILabel!
    @IBOutlet weak var editableDumpTitle: UITextField!
    @IBOutlet weak var editableDumpNote: UITextView!
    @IBOutlet weak var editSaveBtnText: UIButton!
    @IBOutlet weak var editNoteBtmConstraint: NSLayoutConstraint!
    
    var selectedDump: Dump?
    var editModeEnabled = false

    // MARK: General View Setup
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dumpTitle.text = self.selectedDump?.title
        self.dumpNote.sizeToFit()
        self.dumpNote.text = self.selectedDump?.note
        self.editableDumpTitle.delegate = self
        self.editableDumpNote.delegate = self
        self.editNoteBtmConstraint.constant = 8
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                self.editNoteBtmConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func resetEditNoteBtmConstraint() {
        self.editNoteBtmConstraint.constant = 8
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.resetEditNoteBtmConstraint()
    }
    
    // MARK: Button Functionality
    @IBAction func backToCategoriesVC(sender: UIButton) {
        performSegueWithIdentifier("DumpToCategories", sender: nil)
    }
    
    @IBAction func editSaveBtnPressed(sender: UIButton) {
        guard self.editModeEnabled == false else {
            self.editModeEnabled = false
            self.view.backgroundColor = UIColor.whiteColor()
            self.editableDumpTitle.hidden = true
            self.editableDumpNote.hidden = true
            self.dumpNote.hidden = false
            self.editSaveBtnText.setTitle("Edit", forState: UIControlState.Normal)
            
            self.dumpTitle.text = self.editableDumpTitle.text
            self.dumpNote.text = self.editableDumpNote.text
            
            return
        }
        
        self.editModeEnabled = true
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.editableDumpTitle.hidden = false
        self.editableDumpNote.hidden = false
        self.dumpNote.hidden = true
        self.editSaveBtnText.setTitle("Save", forState: UIControlState.Normal)
        
        self.editableDumpTitle.text = self.dumpTitle.text
        self.editableDumpNote.text = self.dumpNote.text
        self.dumpTitle.text = "Edit Mode"
    }
}

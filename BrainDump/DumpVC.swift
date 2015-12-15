//
//  DumpVC.swift
//  BrainDump
//
//  Created by Kyle Lee on 12/2/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class DumpVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var dumpTitle: UILabel!
    @IBOutlet weak var dumpNote: UILabel!
    @IBOutlet weak var editableDumpTitle: UITextField!
    @IBOutlet weak var editableDumpNote: UITextView!
    @IBOutlet weak var editSaveBtnText: UIButton!
    @IBOutlet weak var editNoteBtmConstraint: NSLayoutConstraint!
    @IBOutlet weak var backCancelBtnText: UIButton!
    
    var selectedDump: Dump?
    var selectedRow: NSIndexPath?
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
    
    func toggleEditModeView() {
        
        if self.editModeEnabled == true {
            
            self.view.backgroundColor = UIColor.whiteColor()
            self.editableDumpTitle.hidden = true
            self.editableDumpNote.hidden = true
            self.dumpNote.hidden = false
            self.dumpTitle.text = self.selectedDump?.title
            self.editSaveBtnText.setTitle("Edit", forState: UIControlState.Normal)
            self.backCancelBtnText.setTitle("Back", forState: UIControlState.Normal)
            self.view.endEditing(true)
            self.editModeEnabled = false
        } else {
            
            self.view.backgroundColor = UIColor.lightGrayColor()
            self.editableDumpTitle.hidden = false
            self.editableDumpNote.hidden = false
            self.dumpNote.hidden = true
            self.dumpTitle.text = "Edit Mode"
            self.editSaveBtnText.setTitle("Save", forState: UIControlState.Normal)
            self.backCancelBtnText.setTitle("Cancel", forState: UIControlState.Normal)
            self.editModeEnabled = true
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                self.editNoteBtmConstraint.constant = (keyboardHeight + CGFloat(8))
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
        if self.editModeEnabled == false {
            performSegueWithIdentifier("DumpToCategories", sender: nil)
        } else {
            self.toggleEditModeView()
        }
    }
    
    @IBAction func editSaveBtnPressed(sender: UIButton) {
        
        guard self.editModeEnabled == false else {
            
            self.toggleEditModeView()
            self.dumpTitle.text = self.editableDumpTitle.text
            self.dumpNote.text = self.editableDumpNote.text
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            
            if self.selectedDump != nil {
                
                self.selectedDump?.title = self.editableDumpTitle.text
                self.selectedDump?.note = self.editableDumpNote.text
                self.selectedDump?.date = NSDate()
            }
            
            do {
                
                try context.save()
                print("context was saved!")
            } catch {
                
                print("Could not save dump")
            }
            
            return
        }
        
        self.toggleEditModeView()
        self.editableDumpTitle.text = self.selectedDump?.title
        self.editableDumpNote.text = self.selectedDump?.note
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let categoriesVC = segue.destinationViewController as? CategoriesVC
        categoriesVC?.deselectedRow = self.selectedRow
    }
}

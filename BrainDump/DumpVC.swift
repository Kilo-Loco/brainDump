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
    
    override func viewDidAppear(animated: Bool) {
        
        print("Selected row is: \(self.selectedRow)")
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
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            
            if self.selectedDump == nil {
                
                let dumpDescription = NSEntityDescription.entityForName("Dump", inManagedObjectContext: context)
                
                self.selectedDump = Dump(entity: dumpDescription!, insertIntoManagedObjectContext: context)
            }
            
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
        
        self.editModeEnabled = true
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.editableDumpTitle.hidden = false
        self.editableDumpNote.hidden = false
        self.dumpNote.hidden = true
        self.editSaveBtnText.setTitle("Save", forState: UIControlState.Normal)
        
        self.editableDumpTitle.text = self.dumpTitle.text
        self.editableDumpNote.text = self.dumpNote.text
        self.dumpTitle.text = "Edit Mode"
        
        print(self.selectedDump?.title)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let categoriesVC = segue.destinationViewController as? CategoriesVC
        categoriesVC?.deselectedRow = self.selectedRow
    }
}

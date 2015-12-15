//
//  ViewController.swift
//  BrainDump
//
//  Created by Kyle Lee on 11/26/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: VCCommons, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var hideBtnText: UIButton!
    @IBOutlet weak var savedLabel: UILabel!
    
    @IBOutlet weak var titleFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var accessoryBtmConstraint: NSLayoutConstraint!
    
    // MARK: General View Setup
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.titleField.delegate = self
        self.textView.delegate = self
        self.placeholderTextInTextView()
        self.hideBtnText.hidden = true
        self.savedLabel.alpha = 0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    // MARK: TextView Font Style
    func placeholderTextInTextView() {
        
        self.textView.text = CTA
        self.textView.textColor = UIColor.lightGrayColor()
    }
    
    // MARK: Text Editing
    func keyboardWillShow(sender: NSNotification) {
        
        if let userInfo = sender.userInfo {
            
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                
                self.accessoryBtmConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
                self.hideBtnText.hidden = false
            }
        }
    }
    
    func orientationChange() {
        
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            
            self.titleField.hidden = true
            self.titleFieldTopConstraint.constant = -40
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation) {
            
            self.titleField.hidden = false
            self.titleFieldTopConstraint.constant = 0
        }
    }
    
    func resetAccessoryConstraint() {
        
        self.accessoryBtmConstraint.constant = 0
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
        self.hideBtnText.hidden = true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        self.textView.textColor = UIColor.darkGrayColor()
        if self.textView.text == CTA {
            
            self.textView.text = ""
        }
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChange", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            
            self.titleField.hidden = true
            self.titleFieldTopConstraint.constant = -40
        }
        
        self.view.layoutIfNeeded()
    }

    
    func textViewDidEndEditing(textView: UITextView) {
        
        if self.textView.text == "" {
            self.placeholderTextInTextView()
        }
        
        self.resetAccessoryConstraint()
        
        self.titleField.hidden = false
        self.titleFieldTopConstraint.constant = 0
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.resetAccessoryConstraint()
    }
    
    // MARK: Button Functionality
    @IBAction func hideButton(sender: UIButton) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func addBtnPressed(sender: UIButton) {
        
        if let note = self.textView.text where self.textView.text != CTA && self.textView.text != "" {

            let entity = NSEntityDescription.entityForName("Dump", inManagedObjectContext: CONTEXT)!
            let dump = Dump(entity: entity, insertIntoManagedObjectContext: CONTEXT)
    
            if let title = self.titleField.text where self.titleField.text != "" {
                
                guard title.characters.count <= 30 else {
                    
                    let alertTitle = "Title is too long"
                    let alertMessage = "Your title is \(title.characters.count) characters long. Please enter a title that is less than 31 characters long."
                    let alertController: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
                    let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(alertAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    print("title too long")
                    
                    return
                }
                
                dump.title = title
            } else {
                dump.title = "Untitled"
            }
            
            dump.note = note
            dump.date = NSDate()
            
            CONTEXT.insertObject(dump)
            
            SAVE()
//            do {
//                
//                try CONTEXT.save()
//
//                print("context was saved!")
//            } catch {
//                
//                print("Could not save dump")
//            }
            
            self.savedLabel.alpha = 1.0
            UIView.animateWithDuration(2.5, animations: { () -> Void in
                self.savedLabel.alpha = 0
            })
            
            self.titleField.text = ""
            self.textView.text = ""
        }
    }
    
    @IBAction func categoriesBtnPressed(sender: UIButton) {
        
        performSegueWithIdentifier("VCToCategories", sender: nil)
    }
}


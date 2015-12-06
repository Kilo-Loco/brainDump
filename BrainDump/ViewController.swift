//
//  ViewController.swift
//  BrainDump
//
//  Created by Kyle Lee on 11/26/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var accessoryBtmConstraint: NSLayoutConstraint!
    
    let CTA = "What's on your mind?"
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: TextView Font Style
    func placeholderTextInTextView() {
        self.textView.text = self.CTA
        self.textView.textColor = UIColor.lightGrayColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleField.delegate = self
        self.textView.delegate = self
        self.placeholderTextInTextView()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                self.accessoryBtmConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
        

        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.titleField.frame.size.height = 10
        self.textView.textColor = UIColor.darkGrayColor()
        if self.textView.text == self.CTA {
            self.textView.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if self.textView.text == "" {
            self.placeholderTextInTextView()
        }
        
        self.accessoryBtmConstraint.constant = 0
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
        self.titleField.frame.size.height = 40
    }
    
    @IBAction func doneButton(sender: UIButton) {
        self.view.endEditing(true)
    }
    
    @IBAction func addBtnPressed(sender: UIButton) {
        
        if let note = self.textView.text where self.textView.text != self.CTA && self.textView.text != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Dump", inManagedObjectContext: context)!
            let dump = Dump(entity: entity, insertIntoManagedObjectContext: context)
    
            dump.note = note
            dump.date = NSDate()
            print(dump.note!)
            print(dump.date!)
            
            context.insertObject(dump)
            
            do {
                try context.save()
                print("context was saved!")
            } catch {
                print("Could not save dump")
            }
            
            self.textView.text = ""
        }
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    @IBAction func categoriesBtnPressed(sender: UIButton) {
        performSegueWithIdentifier("VCToCategories", sender: nil)
    }
    
}


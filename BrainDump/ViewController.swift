//
//  ViewController.swift
//  BrainDump
//
//  Created by Kyle Lee on 11/26/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var textView: UITextView!
    
    // MARK: TextView Font Style
    func placeholderTextInTextView() {
        self.textView.text = "What's on your mind?"
        self.textView.textColor = UIColor.lightGrayColor()
    }
    func userTextStyle() {
        self.textView.text = ""
        self.textView.textColor = UIColor.darkGrayColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        self.placeholderTextInTextView()
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.userTextStyle()
        self.textView.setContentOffset(CGPointMake(0, 250), animated: true)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.textView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func scrollRangeToVisible
    
}


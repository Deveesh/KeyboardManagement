//
//  ViewController.swift
//  KeyboardManagementLearn
//
//  Created by Deveesh on 26/11/19.
//  Copyright © 2019 MindfireSolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBackgroundViewTap(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeKeyboardObservers()
    }
    
    func addKeyboardObservers(){
        //This will trigger the selector when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShowing), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //This will trigger the selector when keyboard disappears
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDisappearing), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleBackgroundViewTap(_ sender: UITapGestureRecognizer? = nil) {
        textField.resignFirstResponder()
    }
    
    @objc func handleKeyboardDisappearing(notification : NSNotification){
        //Get the textfield back to the bottom
        textFieldBottomConstraint.constant = 0
    }
    
    @objc func handleKeyboardShowing(notification : NSNotification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        //Get the frame(x,y co-ordinates and its width, height)
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        //Pushing the textfield above the keyboard
        textFieldBottomConstraint.constant = keyboardScreenEndFrame.height
    }

}


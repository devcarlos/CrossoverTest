//
//  PaymentViewController.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/10/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import Alamofire

class PaymentViewController: UIViewController, UITextFieldDelegate {
    
    //MARK : IBOutlets
    
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var expirationText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    
    //MARK : Properties
    
    var request: Request?
    
    //MARK : ViewController Lifetime
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure UI settings
        self.configureUI()
    }
    
    func configureUI(){
        
        //configure textfields
        self.numberText.returnKeyType = .Done
        self.nameText.returnKeyType = .Done
        self.expirationText.returnKeyType = .Done
        self.codeText.returnKeyType = .Done
        
        //configure view for keyboard dismiss on tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    //dismiss keyboard on tap
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    deinit {
        request?.cancel()
    }
    
    //MARK : API Call Functions
    
    func payment() {
        
        //validate empty fields to avoid typing every time
        if self.numberText.text == "" {
            self.numberText.text = "1234123412341234"
        }
        
        if self.nameText.text == "" {
            self.nameText.text = "Hayao Miyazaki"
        }
        
        if self.expirationText.text == "" {
            self.expirationText.text = "11/20"
        }
        
        if self.codeText.text == "" {
            self.codeText.text = "754"
        }
        
        
        let number = self.numberText.text!
        let name = self.nameText.text!
        let expiration = self.expirationText.text!
        let code = self.codeText.text!
        
        request = APIManager.sharedInstance.payment(number, name: name, exp: expiration, code: code, completion: { [unowned self] (message, error) in
            
            self.request = nil
            
            if let errorValid = error {
                let alert = ErrorManager.errorAlertController(errorValid)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                
                //show alert message and get back to Map
                self.showAlert("Payment Success", message: message, handler:  { (action) in
                    self.backToMap()
                })
            }
        })
    }
    
    //MARK : Navigation
    
    func backToMap() {
        
        //pop back to Map View
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK : Actions
    
    @IBAction func paymentAction(sender: UIButton) {
        //callback login functionality
        self.payment()
    }
    
    //MARK : TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //dismiss on return
        textField.resignFirstResponder()
        return true
    }
}


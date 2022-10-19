//
//  ViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 14/12/2019.
//  Copyright © 2019 Florian Peyrony. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

class SignUpViewController: UIViewController {
    // MARK : Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    var database = Firestore.firestore()
    
    // MARK : Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setUpButtonsSkin()
        setUpTextFieldManager()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(_:)), name: UIViewController.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(_:)), name: UIViewController.keyboardWillHideNotification, object: nil)
    }
    
    func setUpButtonsSkin() {
        signInButton.layer.cornerRadius = 20
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        logInButton.layer.cornerRadius = 20
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        logInButton.backgroundColor?.withAlphaComponent(0.20)
        userNameTextField.layer.borderWidth = 1
        userNameTextField.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
    }
    
    func setUpTextFieldManager() {
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    @objc func keyboardAppear(_ notification: Notification) {
            guard let frame = notification.userInfo?[UIViewController.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame = frame.cgRectValue
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardFrame.height
            }
        }

    @objc func keyboardDisappear(_ notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    // MARK : Actions
    @IBAction func tapToDismiss(_ sender: UITapGestureRecognizer) {
        userNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    @IBAction func signInButton(_ sender: Any) {
        if userNameTextField.text != "" && passwordTextField.text != "" && emailTextField.text != "" {
            print("Inscription de \(userNameTextField.text ?? "no name")")
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authRequest, error in
                if error != nil {
                    print(error.debugDescription)
                    self.presentAlert(title: "ERROR", message: "Incorrect password")
                } else {
                    let userInfo = self.createUserObject()
                    self.performSegue(withIdentifier: "segueToWelcome", sender: userInfo)
                    
    
                    
                    // saving to database the name and the adress of the user, to use it in the successVC
                    self.saveUserInfo(name: self.userNameTextField.text!, email: self.emailTextField.text!)
                }
            }
            
        } else {
            print("Error : Missing Username or password")
            self.presentAlert(title: "ERROR", message: "Add a valid e-mail or password")
        }
    }
    
    func saveUserInfo(name: String, email: String) {
        let docRef = database.document("users/\(name)")
        docRef.setData(["username": name, "email": email])
        
    }
    
    private func createUserObject() -> User {
        let name = userNameTextField.text
        let email = emailTextField.text

        return User(name: name!, email: email!)
    }

    
    private func setDocument() {
           // [START set_document]
           // Add a new document in collection "cities"
        database.collection("users").document("\(userNameTextField.text!)").setData([
            "username": "\(userNameTextField.text!)",
            "email": "\(emailTextField.text!)"
           ]) { err in
               if let err = err {
                   print("Error writing document: \(err)")
               } else {
                   print("Document successfully written!")
               }
           }
           // [END set_document]
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segueToWelcome" {
                let successVC = segue.destination as? SuccessRegisterViewController
                let userInfo = sender as? User
            successVC?.userInfo = userInfo
        }
    }
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


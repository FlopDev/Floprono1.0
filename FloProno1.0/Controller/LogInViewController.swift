//
//  LogInViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 05/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    // MARK : Outlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    // MARK : Properties
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpButtonsSkin()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(_:)), name: UIViewController.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(_:)), name: UIViewController.keyboardWillHideNotification, object: nil)
    }
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpButtonsSkin() {
        signInButton.layer.cornerRadius = 20
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        logInButton.layer.cornerRadius = 20
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        logInButton.backgroundColor?.withAlphaComponent(0.20)
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
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
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != nil {
            print("Inscription de \(emailTextField.text ?? "no adress")")
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                if error != nil {
                    // meilleure gestion des erreurs par exemple erreur reseau ? erreur mdp incorrect ?
                    print(error.debugDescription)
                    self.presentAlert(title: "ERROR", message: "Incorrect password")
                } else {
                    self.performSegue(withIdentifier: "segueToMain", sender: self)
                }
            }
        } else {
            presentAlert(title: "ERROR", message: "Add a valid e-mail or password")
            print("Error : Missing Email or password")
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
    }
    

    
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

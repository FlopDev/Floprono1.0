//
//  LogInViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 05/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpButtonsSkin()
    }
    
    @IBAction func logIn(_ sender: Any) {
    }
    
    @IBAction func signIn(_ sender: Any) {
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

    }

}

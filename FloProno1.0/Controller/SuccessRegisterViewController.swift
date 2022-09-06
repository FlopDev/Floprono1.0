//
//  SuccessRegisterViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 06/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import UIKit

class SuccessRegisterViewController: UIViewController {
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpButtonsSkin()
    }
    
    func setUpButtonsSkin() {
        
        logInButton.layer.cornerRadius = 20
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        logInButton.backgroundColor?.withAlphaComponent(0.20)
    }
}

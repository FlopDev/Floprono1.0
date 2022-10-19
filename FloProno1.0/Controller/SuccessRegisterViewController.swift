//
//  SuccessRegisterViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 06/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

class SuccessRegisterViewController: UIViewController {
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    var userInfo: User?
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpButtonsSkin()
        
        if let user = Auth.auth().currentUser {
            
            // user connected
          //  let username = getNameOfUser()
          //  successLabel.text = "Great the adress :  \(username) has been registered! You can now log in."
        } else {
            fatalError("Aucun utilisateur connecté")
        }
    }
    
    func getNameOfUser() {
    
        let docRef = db.collection("users").document("users")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func setUpButtonsSkin() {
        logInButton.layer.cornerRadius = 20
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        logInButton.backgroundColor?.withAlphaComponent(0.20)
        
        successLabel.text = "Great \(userInfo!.name), your registration has been validated! You can now log in."
    }
}

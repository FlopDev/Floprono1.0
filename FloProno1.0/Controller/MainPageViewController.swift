//
//  MainPageViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 05/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainPageViewController: UIViewController {
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var imageOfTheBet: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var trustFactorLabel: UILabel!
    @IBOutlet weak var percentageBankrollLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentaryButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressLikeButton(_ sender: UIButton) {
    }
    @IBAction func didPressCommentaryButton(_ sender: UIButton) {
    }
    @IBAction func pressLogOutButton(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Can't deconnect user")
        }
       
    }
}

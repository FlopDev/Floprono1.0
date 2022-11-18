//
//  MainPageViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 05/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class MainPageViewController: UIViewController {
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var imageOfTheBet: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var trustFactorLabel: UILabel!
    @IBOutlet weak var percentageBankrollLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentaryButton: UIButton!
    
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var addPronosticButton: UIButton!
    
    var database = Firestore.firestore()
    
    var userInfo: User?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("\(String(describing: Auth.auth().currentUser?.uid))")
        print("\(String(describing: Auth.auth().currentUser?.email))")
        let docRef = database.document("users/\(Auth.auth().currentUser?.uid)")
        docRef.getDocument { doc, error in
            print("\(doc?.data()?["isAdmin"])")
        }
        
        //print("\(String(describing: Auth.auth().currentUser?.username))")
        //print("\(Auth.auth().currentUser.isAdmin)")
        if (userInfo?.isAdmin ?? false) {
            addPronosticButton.isHidden = false
        }
    }
    @IBAction func addNewPronostic(_ sender: UIButton) {
    }
    
    @IBAction func didPressLikeButton(_ sender: UIButton) {
    }
    @IBAction func didPressCommentaryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToCommentaries", sender: UserInfo.self)
    }
    @IBAction func pressLogOutButton(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Can't deconnect user")
        }
       
    }

    
    func getUserInfoFromBDD() {
        let docRef = database.collection("users").document("\(userInfo!.username)")
       

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segueToCommentaries" {
                let successVC = segue.destination as? CommentariesViewController
                let userInfo = sender as? User
            successVC?.userInfo = userInfo
        }
    }
    
}

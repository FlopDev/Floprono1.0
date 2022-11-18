//
//  CommentariesViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 13/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CommentariesViewController: UIViewController {
    
    // MARK : Outlets
    @IBOutlet weak var commentaryTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var userInfo: User?
    static var cellIdentifier = "CommentaryCell"

    // MARK : Properties
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(_:)), name: UIViewController.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(_:)), name: UIViewController.keyboardWillHideNotification, object: nil)
    }
    
    /**
     Alert with a textfield for the commentary
     */
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Add a Commentary", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                // operations
                print("Text==>" + text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Tag"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        commentaryTextField.resignFirstResponder()
    }
    @IBAction func addCommentary(_ sender: Any) {
    }
    @IBAction func publish(_ sender: Any) {
        if commentaryTextField.text == "" {
            showAlertWithTextField()
        } else {
            
            var commentary = Commentary()
            commentary.nameOfWriter = "me" // Recuperer coté BDD le nom du User
        
            
            commentary.text = commentaryTextField.text!
            CommentaryService.shared.add(commentary: commentary)
            tableView.reloadData()
        }
    }

    
}

extension CommentariesViewController: UITableViewDataSource, UITextFieldDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentaryService.shared.commentaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentariesViewController.cellIdentifier, for: indexPath)
        let commentary = CommentaryService.shared.commentaries[indexPath.row]
        cell.textLabel?.text = commentary.nameOfWriter
        cell.detailTextLabel?.text = commentary.text
        
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//
//  CreateViewController.swift
//  training
//
//  Created by Olesya Nikolaeva on 11.10.2021.
//  Copyright © 2021 Olesya Nikolaeva. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class CreateViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signIn")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @IBAction func createTapped(_ sender: Any) {
        if name.text?.isEmpty == true {
            print("Name field is empty")
            return
        }
        if email.text?.isEmpty == true {
            print("Email field is empty")
            return
        }
        if password.text?.isEmpty == true {
            print("Password field is empty")
            return
        }
        signUp()
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) {
            (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "forecast")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}

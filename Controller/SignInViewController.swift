//
//  SignInViewController.swift
//  training
//
//  Created by Olesya Nikolaeva on 11.10.2021.
//  Copyright © 2021 Olesya Nikolaeva. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func forgotTapped(_ sender: Any) {
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if email.text?.isEmpty == true {
            print("Email field is empty")
            return
        }
        if password.text?.isEmpty == true {
            print("Password field is empty")
            return
        }
        
        login()
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {
            [weak self] authResult, err in
            guard let strongSelf = self else {return}
            if let err = err {
                print(err.localizedDescription)
            }
            self!.checkUserInfo()
        }
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "forecast")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
}

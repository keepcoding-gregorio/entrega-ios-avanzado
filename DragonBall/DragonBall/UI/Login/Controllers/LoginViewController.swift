//
//  LoginViewController.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlet -
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var loadingView: UIView!

    // MARK: - IBAction -
    @IBAction func onLoginTapped() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}


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
        viewModel?.onLoginTapped(
            email: emailField.text,
            password: passwordField.text
        )
    }

    // MARK: - Public Properties -
    var viewModel: LoginViewControllerDelegate?

    private enum FieldType: Int {
        case email = 0
        case password
    }

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setObservers()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "LOGIN_TO_HOME",
              let homeViewController = segue.destination as? HomeViewController else {
            return
        }

        homeViewController.viewModel = viewModel?.homeViewModel
    }

    // MARK: - Private functions -
    private func initViews() {
        emailField.delegate = self
        emailField.tag = FieldType.email.rawValue
        passwordField.delegate = self
        passwordField.tag = FieldType.password.rawValue

        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismissKeyboard)
            )
        )
    }

    @objc func dismissKeyboard() {
        // Ocultar el teclado al pulsar en cualquier punto de la vista
        view.endEditing(true)
    }

    private func setObservers() {
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                    case .loading(let isLoading):
                        self?.loadingView.isHidden = !isLoading

                    case .showEmailError(let error):
                        self?.emailError.text = error
                        self?.emailError.isHidden = (error == nil || error?.isEmpty == true)

                    case .showPasswordError(let error):
                        self?.passwordError.text = error
                        self?.passwordError.isHidden = (error == nil || error?.isEmpty == true)

                    case .navigateToNext:
                        self?.performSegue(withIdentifier: "LOGIN_TO_HOME",
                                           sender: nil)
                }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch FieldType(rawValue: textField.tag) {
            case .email:
                emailError.isHidden = true

            case .password:
                passwordError.isHidden = true

            default: break
        }
    }
}



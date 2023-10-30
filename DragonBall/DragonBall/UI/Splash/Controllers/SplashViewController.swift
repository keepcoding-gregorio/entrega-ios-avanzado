//
//  SplashViewController.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import UIKit

class SplashViewController: UIViewController {

    static let identifier: String = "SplashViewController"

    // MARK: - IBOutlet -
    @IBOutlet weak var loading: UIActivityIndicatorView!

    var viewModel: SplashViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
        viewModel?.onViewAppear()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "SPLASH_TO_LOGIN":
                guard let loginViewController = segue.destination as? LoginViewController else { return }
                loginViewController.viewModel = viewModel?.loginViewModel

            case "SPLASH_TO_HOME":
                guard let homeViewController = segue.destination as? HomeViewController else { return }
                homeViewController.viewModel = viewModel?.homeViewModel

            default:
                break
        }
    }

    private func setObservers() {
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                    case .loading(let isLoading):
                        self?.loading.isHidden = !isLoading

                    case .navigateToLogin:
                        self?.performSegue(withIdentifier: "SPLASH_TO_LOGIN", sender: nil)

                    case .navigateToHome:
                        self?.performSegue(withIdentifier: "SPLASH_TO_HOME", sender: nil)
                }
            }
        }
    }
}

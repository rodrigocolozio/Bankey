//
//  ViewController.swift
//  Bankey
//
//  Created by Rodrigo Colozio on 19/05/23.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Attributes
    
    let appTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    var username: String? {
        return loginView.usernameTextfield.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

    // MARK: - View Style and Layout
extension LoginViewController {
    
    private func style() {
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.text = "Bankey"
        appTitleLabel.textColor = .black
        appTitleLabel.textAlignment = .center
        appTitleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Your premium source of all things banking!"
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = -1
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .regular)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        self.view.addSubview(appTitleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(loginView)
        self.view.addSubview(signInButton)
        self.view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            // AppTitleLabel
            appTitleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -20),
            appTitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            // DescriptionLabel
            descriptionLabel.bottomAnchor.constraint(equalTo: self.loginView.topAnchor, constant: -20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            // LogInView
            loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: self.loginView.trailingAnchor, multiplier: 1),
            
            // SignInButton
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: self.signInButton.trailingAnchor, multiplier: 1),
            signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // ErrorLabel
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
    
}

    // MARK: - Actions
extension LoginViewController {
    
    @objc func signInTapped(_ sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = self.username, let password = self.password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        if username == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
            configureNextAction()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
    private func configureNextAction() {
        let vc = OnboardingContainerViewController()
        present(vc, animated: true)
    }
}


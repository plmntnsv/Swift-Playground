//
//  LoginViewController.swift
//  SignInApp
//
//  Created by Plamen Atanasov on 12.11.19.
//  Copyright © 2019 Plamen Atanasov. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    @IBOutlet weak var signInWithAppleButtonHolder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let signInButton = ASAuthorizationAppleIDButton()
            
            signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchDown)
            
            signInButton.translatesAutoresizingMaskIntoConstraints = false
            signInWithAppleButtonHolder.addSubview(signInButton)
            
            NSLayoutConstraint.activate([
                signInButton.centerXAnchor.constraint(equalTo: signInWithAppleButtonHolder.centerXAnchor),
                signInButton.centerYAnchor.constraint(equalTo: signInWithAppleButtonHolder.centerYAnchor),
                signInButton.heightAnchor.constraint(equalTo: signInWithAppleButtonHolder.heightAnchor),
                signInButton.widthAnchor.constraint(equalTo: signInWithAppleButtonHolder.widthAnchor)
            ])
        }
        
    }

//    @available(iOS 13.0, *)
//    @IBAction func loginButtonTapped(_ sender: Any) {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.performRequests()
//    }
    
    @objc private func signInButtonTapped() {
        print("asd")
    }
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))") }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("AppleID Credential failed with error: \(error.localizedDescription)")
    }
}


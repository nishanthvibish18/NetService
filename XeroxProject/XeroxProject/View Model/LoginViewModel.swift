//
//  LoginViewModel.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import Foundation
import GoogleSignIn

class LoginViewModel{
    
    var onLogout: (() -> Void)?

    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkNotReachable), name: .networkNotReachable, object: nil)
    }
    
    
    func isUserLogin(completion: @escaping(Bool) -> ()){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil {
                completion(false)
            }else{
                completion(true)
            }            
        }
    }
    
    
    @objc private func networkNotReachable(){
        self.logout()
    }
    
    func googleSinginAction(viewController: UIViewController, completionHandler: @escaping (GIDGoogleUser?,Error?) -> ()){
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { user, error in
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            
            guard let users = user?.user else{
                return
            }
            
            completionHandler(users, nil)
        
        }
    }
    
    
    func logout(){
        GIDSignIn.sharedInstance.signOut()
        self.onLogout?()
    }
    
    
    
}




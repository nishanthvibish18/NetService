//
//  SigninViewController.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import UIKit

class SigninViewController: UIViewController {

    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func singinButton(_ sender: UIButton) {
        self.loginViewModel.googleSinginAction(viewController: self) { user, error in
            
            if(error == nil && user != nil){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
                
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else{
                print(error?.localizedDescription ?? "")
            }
            
            
        }
    }
    
    
   
    
}

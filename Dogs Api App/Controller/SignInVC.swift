//
//  SignInVC.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/14/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class SignInVC: UIViewController {

    
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [.publicProfile])
        loginButton.center.x = view.center.x
        loginButton.center.y = view.bounds.height * 0.8
        
        view.addSubview(loginButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
            
            dismiss(animated: true, completion: nil)
        }
        
        
        /*
        //if the user is already logged in
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
            
            performSegue(withIdentifier: "GoToSignInVC", sender:nil)
        }*/
    }

    //when login button clicked
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
        }
    }
    
    //function is fetching the user data
    func getFBUserData(){
        print("getFBUserData")
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print("Result: \(result!)")
                    print("dict: \(self.dict)")
                    
                }
            })
        }
    }



}

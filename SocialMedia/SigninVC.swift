//
//  SigninVC.swift
//  SocialMedia
//
//  Created by Russell G Stewart on 2017-02-28.
//  Copyright © 2017 App Whole. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper

class SigninVC: UIViewController {
    
    @IBOutlet weak var emailField: TextFieldBorder!
    
    @IBOutlet weak var pwdField: TextFieldBorder!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
       if let _ =  KeychainWrapper.standard.string(forKey: KEY_UID) {
           print("RUSS: ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        
        }
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("RUSS: unable to authenticate with Facebook - \(String(describing: error))")
                
            } else if result?.isCancelled == true {
                print("RUSS: User cancelled Facebook authentication")
            
            } else {
                print("RUSS: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
         
        }
        
    }
    
        func firebaseAuth(_ credential: FIRAuthCredential) {
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print("RUSS: unable to authenticate with Firebase - \(String(describing: error))")
                
                } else {
                    print("RUSS: Successfully authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": credential.provider]
                        self.completeSignIn(id: user.uid, userData: userData)
                    
                    
                    }
                    
                    
                }
            
            
            })
        
        
        }

    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                    if error == nil {
                    print("RUSS: Email user authenticated with Firebase")
                        if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                            
                        }
                        //self.performSegue(withIdentifier: "goToFeed", sender: nil)
                
                    } else {
                        FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                            if error != nil {
                                print("RUSS: Unable to authenticate with Firebase using email")
                                if let user = user {
                                    let userData = ["provider": user.providerID]
                                    self.completeSignIn(id: user.uid, userData: userData)
                                
                                }
                                
                            } else {
                                print("RUSS: Successfully authenticated with Firebase")
                                if let user = user {
                                    let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                                    
                                }
                            }
                        
                        
                        })
                        
                        
                        //print("RUSS: login failed")
                
                }
            })
        
        
        }
            
    }
      
            func completeSignIn(id: String, userData: Dictionary<String, String>) {
            DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
            let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
            print("RUSS: Data saved to keychain \(keychainResult)")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        
        }
        
    }

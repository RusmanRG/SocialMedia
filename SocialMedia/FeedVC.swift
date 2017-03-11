//
//  FeedVC.swift
//  SocialMedia
//
//  Created by Russell G Stewart on 2017-03-06.
//  Copyright © 2017 App Whole. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signOutPressed(_ sender: Any) {
    let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("RUSS: ID removed from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
        
    }
    
}

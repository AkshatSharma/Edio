//
//  LoginViewController.swift
//  Edio
//
//  Created by Akshat Sharma on 4/9/18.
//  Copyright © 2018 Akshat Sharma. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var db : Firestore!
    
    var univList = [Dictionary<String, Any>]()
    
    var univOrgNames : [String] = []

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginTapped(_ sender: Any) {
        getUnivCollection(selectedUniversity: "University of Minnesota")
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
    }
    private func getCollection() {
        db.collection("Universities").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    private func getUnivCollection(selectedUniversity : String) {
        db.collection("Organizations").whereField("University", isEqualTo: selectedUniversity).getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var count : Int = 0
                for document in querySnapshot!.documents {
                    self.univList.append(document.data())
                    //print ("\(document.documentID) => \(document.data())")
                    
                    if let value = self.univList[count]["OrgName"] {
                        self.univOrgNames.append(value as! String)
                        print("Appended")
                        print(self.univOrgNames[count])
                    }
                    count = count + 1
                }
            }
        }
    }
}


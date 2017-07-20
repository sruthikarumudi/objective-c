//
//  AddNewStudentViewController.swift
//  EducationiOS
//
//  Created by Pritesh Patel on 2017-07-11.
//  Copyright © 2017 MoxDroid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddNewStudentViewController: UIViewController {

   var refStudent: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        //getting a reference to the node artists
        refStudent = Database.database().reference().child("students");

        // Do any additional setup after loading the view.
        //updateStudent()
        //deleteStudent(id: "-KomaHnqStBFhCgAE9i1")
        getStudentRecords()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnInsert(_ sender: UIButton) {
        addStudent()
    }
    
    func addStudent(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refStudent.childByAutoId().key
        
        //creating artist with the given values
        let student = ["id":key,
                      "sid":"1",
                      "firstName": "sruthi",
                      "lastName": "karumudi"
        ]
        
        //adding the artist inside the generated unique key
        refStudent.child(key).setValue(student)
        
        //displaying message
        print("Student Added")
    }
    
    func getStudentRecords()
    {
        //observing the data changes
        refStudent.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //iterating through all the values
                for student in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let studentObject = student.value as? [String: AnyObject]
                    let id  = studentObject?["id"]
                    let studentId  = studentObject?["sid"]
                    let studentFName  = studentObject?["firstName"]
                    let studentLName = studentObject?["lastName"]
                    print("\(id) -- \(studentId) -- \(studentFName) -- \(studentLName)")
                }
            
            }
        })
    }
    
    func updateStudent(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = "-KomaHnqStBFhCgAE9i1"
        //creating artist with the given values
        let student = ["id":key,
                        "sid":"1",
                       "firstName": "sindhu",
                       "lastName": "reddy"
        ]
        
        //adding the artist inside the generated unique key
        refStudent.child(key).setValue(student)
        
        //displaying message
        print("Student Updated")
    }
    
    func deleteStudent(id:String){
        refStudent.child(id).setValue(nil)
        
        //displaying message
        print("Student Deleted")
    }

    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController");           self.present(vc, animated: false, completion: nil)
        }
    }
}

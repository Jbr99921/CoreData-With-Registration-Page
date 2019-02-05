//
//  EditVC.swift
//  RegistrationPageCoreData
//
//  Created by MacMiniOld on 06/11/18.
//  Copyright © 2018 Xongolab. All rights reserved.
//

import UIKit
import CoreData
import Foundation
class EditVC: UIViewController{


    @IBOutlet var TxtFname: UITextField!
    @IBOutlet var TxtLname: UITextField!
    @IBOutlet var TxtUsername: UITextField!
    @IBOutlet var TxtEmail: UITextField!
    @IBOutlet var TxtPassword: UITextField!
    
    
    @IBOutlet var UniqueId: UITextField!
    
    @IBOutlet var BtnUpdt: UIButton!
    @IBOutlet var UpdateView: UIView!
    
    var Fname:String?
    var Lname:String?
    var user:String?
    var email:String?
    var pass:String?
    var UniqueID:String?
    var selectedMark:RegistrationDetails?
    
    var MyIndex:Int?
   
    var object = NSManagedObjectContext()
     var person = [NSManagedObject]()

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    func configureView() {
        if let details = self.detailItem {
            print(details)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
        TxtFname.text = Fname
        TxtLname.text = Lname
        TxtUsername.text = user
        TxtEmail.text = email
        TxtPassword.text = pass
        UniqueId.text = UniqueID
        
       
        UpdateView.layer.cornerRadius = 40
        BtnUpdt.layer.cornerRadius = 14
        BtnUpdt.layer.borderWidth = 2
        BtnUpdt.layer.borderColor = UIColor.white.cgColor
        BtnUpdt.backgroundColor = .clear
        
        //MARKS:-- FOR PickerView
        
       
        //MARKS:-- Txtfiels Layout Function
        textfieldlayout()
        
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func textfieldlayout(){
        //Marks:-- FirstName
        
        TxtFname.rightViewMode = UITextFieldViewMode.always
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image1 = UIImage(named: "usernameL")
        imageView1.image = image1
        TxtFname.rightView = imageView1
        
        //Marks:-- FirstName
        TxtLname.rightViewMode = UITextFieldViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image2 = UIImage(named: "usernameL")
        imageView2.image = image2
        TxtLname.rightView = imageView2
        
        //Marks:-- Username
        TxtUsername.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "UserL")
        imageView.image = image
        TxtUsername.rightView = imageView
        
        //Marks:-- Email
        TxtEmail.rightViewMode = UITextFieldViewMode.always
        let imageView4 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image4 = UIImage(named: "emailL")
        imageView4.image = image4
        TxtEmail.rightView = imageView4
        
        //Marks:-- Password
        TxtPassword.rightViewMode = UITextFieldViewMode.always
        let imageView5 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image5 = UIImage(named: "PassL")
        imageView5.image = image5
        TxtPassword.rightView = imageView5
    }

    func validation(){
        let alertController = UIAlertController(title: "Error", message: "Please Enter Valid Email Address", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("succeffully done")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func emailAlreadyExist(){
        let alertEmail = UIAlertController(title: "Error", message: "Email is Already Exist", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("succeffully done")
        }
        alertEmail.addAction(okAction)
        self.present(alertEmail, animated: true, completion: nil)
    }
    
    func alertaction(){
        if (TxtFname.text == "" || TxtLname.text == "" || TxtUsername.text == "" || TxtEmail.text == "" || TxtPassword.text=="" || UniqueId.text == ""){
            let alertController = UIAlertController(title: "Error", message: "Please Enter Valid Details", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                //     print("OK Pressed")
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                //  print("Cancel Pressed")
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    @IBAction func BtnUpdate(_ sender: UIButton) {
       
    
       if !isValidEmail(testStr: TxtEmail.text!){
        
        }else if isValidEmail(testStr: TxtEmail.text!){
        let Dictionry = ["firstName":(TxtFname.text)!,"lastName":(TxtLname.text)!,"user":(TxtUsername.text)!,"email":(TxtEmail.text)!,"password":(TxtPassword.text)!,"uniqueId":(UniqueId.text)!]
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BtnBack(_ sender: UIButton) {
        let navigate = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowRegisterVC") as! ShowRegisterVC
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    
}

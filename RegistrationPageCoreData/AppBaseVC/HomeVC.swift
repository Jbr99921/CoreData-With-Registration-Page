//
//  HomeVC.swift
//  RegistrationPageCoreData
//
//  Created by MacMiniOld on 02/11/18.
//  Copyright © 2018 Xongolab. All rights reserved.
//

import UIKit
import CoreData
import Foundation
public var selectedMark:RegistrationDetails?
class HomeVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NSFetchedResultsControllerDelegate{

    @IBOutlet var center:NSLayoutConstraint!
    @IBOutlet var TxtFname: UITextField!
    @IBOutlet var TxtLname: UITextField!
    @IBOutlet var TxtUsrName: UITextField!
    @IBOutlet var TxtEmail: UITextField!
    @IBOutlet var TxtPassword: UITextField!
    @IBOutlet var TxtCnfPassword: UITextField!
    @IBOutlet var BtnRgstr: UIButton!
    @IBOutlet var RegisterVW: UIView!
    @IBOutlet var TxtUniqueId: UITextField!
    @IBOutlet var SearchID: UITextField!
    @IBOutlet var BtnSearchRecord: UIButton!
    @IBOutlet var BtnUpdateRecord: UIButton!
    @IBOutlet var LblMenuLogo: UILabel!
    @IBOutlet var ImgUser: UIImageView!
    @IBOutlet var BtnUserImg: UIButton!
    @IBOutlet weak var BtnShowAll: UIButton!
    
    //var data:RegistrationDetails? = nil
    var Fname:String?
    var Lname:String?
    var user:String?
    var email:String?
    var pass:String?
    var confirm:String?
    var objectId = NSManagedObjectID()
    var contex = NSManagedObjectContext()
    var selectedImageTag = 0
    let imagePicker = UIImagePickerController()
    
    var results = [RegistrationDetails]()
    
    var appdel = UIApplication.shared.delegate as! AppDelegate
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearTextfield()
        imagePicker.delegate = self
        BtnUpdateRecord.isHidden = true
        LblMenuLogo.text = "Register"
        results = DatabaseHelper.shareInstance.GetShowData()
        
        if let s = selectedMark{
            TxtFname.text = s.firstName
            TxtLname.text = s.lastName
            TxtUsrName.text = s.user
            TxtEmail.text = s.email
            TxtPassword.text = s.password
            TxtUniqueId.text = s.uniqueId
            ImgUser.image = UIImage(data: (s.imgUser)! as Data)
        }
        Fname = TxtFname.text
        Lname = TxtLname.text
        user = TxtUsrName.text
        email = TxtEmail.text
        pass = TxtPassword.text
        confirm = TxtCnfPassword.text
        layout()
        
        UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.center.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func layout(){
        
        //      MARKS:-- Update Button
        BtnUpdateRecord.layer.cornerRadius = 8
        BtnUpdateRecord.layer.borderWidth = 2
        BtnUpdateRecord.layer.borderColor = UIColor.red.cgColor
        BtnUpdateRecord.backgroundColor = .clear
        
        
        // MARKS:-- Search Button
        BtnSearchRecord.layer.cornerRadius = 8
        BtnSearchRecord.layer.borderWidth = 2
        BtnSearchRecord.layer.borderColor = UIColor.red.cgColor
        BtnSearchRecord.backgroundColor = .clear
        
        // MARKS:--SHOW ALL DATA BUTTON
        BtnShowAll.layer.cornerRadius = 8
        BtnShowAll.layer.borderWidth = 2
        BtnShowAll.layer.borderColor = UIColor.red.cgColor
        BtnShowAll.backgroundColor = .clear
        
        //        MARKS:-- Registration Button
        RegisterVW.layer.cornerRadius = 40
        BtnRgstr.layer.cornerRadius = 14
        BtnRgstr.layer.borderWidth = 2
        BtnRgstr.layer.borderColor = UIColor.red.cgColor
        BtnRgstr.backgroundColor = .clear
        
        
        // MARKS:-- USerImage
        imagePicker.delegate = self
        ImgUser.layer.cornerRadius = ImgUser.frame.size.height/2
        ImgUser.clipsToBounds = false
        ImgUser.layer.masksToBounds = true
        
        
        // MARKS:-- USerImgButton
        BtnUserImg.layer.cornerRadius = BtnUserImg.frame.size.height/2
        BtnUserImg.clipsToBounds = false
        BtnUserImg.layer.masksToBounds = true
        BtnUserImg.layer.borderColor = UIColor.red.cgColor
        
        //Marks:-- FirstName
        TxtFname.backgroundColor = .clear
        TxtFname.attributedPlaceholder = NSAttributedString(string: "Enter First Name",attributes: [NSAttributedStringKey.foregroundColor: UIColor.cyan])
        TxtFname.rightViewMode = UITextFieldViewMode.always
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image1 = UIImage(named: "usernameL")
        imageView1.image = image1
        TxtFname.rightView = imageView1
        
        //Marks:-- FirstName
        TxtLname.backgroundColor = .clear
        TxtLname.attributedPlaceholder = NSAttributedString(string: "Enter Last Name",attributes: [NSAttributedStringKey.foregroundColor: UIColor.cyan])
        TxtLname.rightViewMode = UITextFieldViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image2 = UIImage(named: "usernameL")
        imageView2.image = image2
        TxtLname.rightView = imageView2
        
        //Marks:-- Username
        TxtUsrName.backgroundColor = .clear
        TxtUsrName.attributedPlaceholder = NSAttributedString(string: "Enter Username Name",attributes: [NSAttributedStringKey.foregroundColor: UIColor.cyan])
        TxtUsrName.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "UserL")
        imageView.image = image
        TxtUsrName.rightView = imageView
        
        //Marks:-- Email
        TxtEmail.backgroundColor = .clear
        TxtEmail.attributedPlaceholder = NSAttributedString(string: "Enter Email Id",attributes: [NSAttributedStringKey.foregroundColor: UIColor.cyan])
        TxtEmail.rightViewMode = UITextFieldViewMode.always
        let imageView4 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image4 = UIImage(named: "emailL")
        imageView4.image = image4
        TxtEmail.rightView = imageView4

        //Marks:-- Password
        TxtPassword.backgroundColor = .clear
        TxtPassword.attributedPlaceholder = NSAttributedString(string: "Please Enter Password",attributes: [NSAttributedStringKey.foregroundColor: UIColor.cyan])
        TxtPassword.rightViewMode = UITextFieldViewMode.always
        let imageView5 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image5 = UIImage(named: "PassL")
        imageView5.image = image5
        TxtPassword.rightView = imageView5
        
        //Marks:-- Confirm Password
        TxtCnfPassword.backgroundColor = .clear
        TxtCnfPassword.attributedPlaceholder = NSAttributedString(string: "Please Conf. Enter Password",attributes: [NSAttributedStringKey.foregroundColor: UIColor.cyan])
        TxtCnfPassword.rightViewMode = UITextFieldViewMode.always
        let imageView6 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image6 = UIImage(named: "PassL")
        imageView6.image = image6
        TxtCnfPassword.rightView = imageView6
  
        TxtUniqueId.backgroundColor = .clear
        TxtUniqueId.attributedPlaceholder = NSAttributedString(string: "Please Enter Unique Id",attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
        
        SearchID.attributedPlaceholder = NSAttributedString(string: "Search Id",attributes: [NSAttributedStringKey.foregroundColor: UIColor.brown])
    
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
        if (TxtFname.text == "" || TxtLname.text == "" || TxtUsrName.text == "" || TxtEmail.text == "" || TxtPassword.text=="" || TxtCnfPassword.text == "" || TxtUniqueId.text == ""){
            let alertController = UIAlertController(title: "Error", message: "Please Enter Valid Data", preferredStyle: .alert)
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
    
    func clearTextfield ()
    {
        TxtFname.text = ""
        TxtLname.text = ""
        TxtUsrName.text = ""
        TxtEmail.text = ""
        TxtPassword.text = ""
        TxtCnfPassword.text = ""
        TxtUniqueId.text = ""
    }
    
    @IBAction func BtnBackToHome(_ sender: UIButton) {
        let navigate = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    
    @IBAction func BtnRegister(_ sender: UIButton) {
       if (TxtFname.text == "" || TxtLname.text == "" || TxtUsrName.text == "" || TxtEmail.text == "" || TxtPassword.text=="" || TxtCnfPassword.text == "" || TxtUniqueId.text == ""){
            alertaction()
        }else if !isValidEmail(testStr: TxtEmail.text!){
            validation()
        }else if isValidEmail(testStr: TxtEmail.text!)
       {
//        for get in mydata{
//
//            for search in get {
//
//                if(search.value == TxtEmail.text){
//                    emailAlreadyExist()
//                    return
//                }
//            }
//        }

        if let img = ImgUser.image {
            let imageDatas:NSData = UIImageJPEGRepresentation(img,0)! as NSData
          //  let strBase64 = imageDatas.base64EncodedString(options: .lineLength64Characters)
            
       //     if let imageDatas = UIImagePNGRepresentation(img){
//                items.imgUser = imageDatas as NSData
//                        items.firstName =  TxtFname.text
//                        items.lastName  = TxtLname.text
//                        items.user = TxtUsrName.text
//                        items.email = TxtEmail.text
//                        items.password = TxtPassword.text
//                        items.uniqueId = TxtUniqueId.text
            
       let Dictionry:[String:Any] = ["firstName":(TxtFname.text)!,"lastName":(TxtLname.text)!,"user":(TxtUsrName.text)!,"email":(TxtEmail.text)!,"password":(TxtPassword.text)!,"Confirm":(TxtCnfPassword.text)!,"uniqueId":(TxtUniqueId.text)!,"imgUser":(imageDatas)]
            
            DatabaseHelper.shareInstance.Save(object:Dictionry)
            
        let navigate = self.storyboard?.instantiateViewController(withIdentifier: "ShowRegisterVC") as! ShowRegisterVC
        
        self.navigationController?.pushViewController(navigate, animated: true)
        clearTextfield()
            }
        }
}
    @IBAction func BtnSearchRecord(_ sender: UIButton) {
        imagePicker.delegate = self
        LblMenuLogo.text = "Update"
        BtnRgstr.isHidden = true
        BtnUpdateRecord.isHidden = false
        if (SearchID.text?.isEmpty)!
        {
            alertaction()
        }
        else
        {
            selectedMark = DatabaseHelper.shareInstance.dataByUniqueID(uniqueId: SearchID.text!)[0]
            TxtFname.text = selectedMark?.firstName
            TxtLname.text = selectedMark?.lastName
            TxtUsrName.text = selectedMark?.user
            TxtEmail.text = selectedMark?.email
            TxtPassword.text = selectedMark?.password
            TxtUniqueId.text = selectedMark?.uniqueId
                ///  ImgUser.image = selectedMark?.imgUser as? UIImage
            objectId = (selectedMark?.objectID)!
            TxtUniqueId.isUserInteractionEnabled = false
            SearchID.text = ""
            if  let ImgUsers = selectedMark?.imgUser as? NSData{
                if let images = UIImage(data: ImgUsers as Data,scale: 1){
                    ImgUser.image = images
                    
//            if let imageDatar = RegistrationDetails.value(forKey: "imgUser") as? NSData {
//                if let images = UIImage(data:imageDatar as! Data) as? UIImage {
//            ImgUser.image = images
//                    //  ImgUser.image = image
                }
            }

        }
    }
    @IBAction func BtnUpdate(_ sender: UIButton) {
    
        imagePicker.delegate = self
        if (TxtFname.text == "" || TxtLname.text == "" || TxtUsrName.text == "" || TxtEmail.text == "" || TxtPassword.text=="" || TxtCnfPassword.text == "" || TxtUniqueId.text == ""){
            
            alertaction()
            
        }else{
//            data!.imgUser = UIImagePNGRepresentation(ImgUser.image!) as! NSData

            if let img = ImgUser.image {
                if let imageDatas:NSData = UIImageJPEGRepresentation(img,0)! as NSData
                    {
//                     let strBase64 = imageDatas.base64EncodedString(options: .lineLength64Characters)
//                        let dataDecoded:NSData = NSData(base64Encoded: strBase64, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let Dictionry:[String : Any] = ["firstName":TxtFname.text!,"lastName":TxtLname.text!,"user":TxtUsrName.text!,"email":TxtEmail.text!,"password":TxtPassword.text!,"uniqueId":TxtUniqueId.text!,"imgUser":(imageDatas)]
                        
            TxtUniqueId.isUserInteractionEnabled = false
            DatabaseHelper.shareInstance.updateRecord(id: objectId, dictionary: Dictionry as! [String : Any])
        
        clearTextfield()
        BtnRgstr.isHidden = false
        BtnUpdateRecord.isHidden = true
        TxtUniqueId.isUserInteractionEnabled = true
            LblMenuLogo.text = "Register"
            }
        }
    }
}
    @IBAction func BtnUserImg(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        self.ImgUser.image = pickedImage
        print(pickedImage)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnShowAll(_ sender: UIButton) {
        
        let navigate = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowRegisterVC") as! ShowRegisterVC
    self.navigationController?.pushViewController(navigate, animated: true)
    }
    
}

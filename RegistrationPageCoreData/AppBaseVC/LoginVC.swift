//
//  LoginVC.swift
//  RegistrationPageCoreData
//
//  Created by MacMiniOld on 05/11/18.
//  Copyright © 2018 Xongolab. All rights reserved.
//

import UIKit
import CoreData

class LoginVC: UIViewController {

    @IBOutlet var TxtUserName: UITextField!
    @IBOutlet var TxtPassword: UITextField!
    @IBOutlet var BtnSignIn: UIButton!
    @IBOutlet var LoginVW: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       Textfieldvalidation()
        Layouts()
        
//        UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//            self.center.constant = 0
//            self.view.layoutIfNeeded()
//        }, completion: nil)
    }
    
    func Layouts(){
        TxtUserName.backgroundColor = .clear
        TxtUserName.attributedPlaceholder = NSAttributedString(string: "Enter User Name",attributes: [NSAttributedStringKey.foregroundColor: UIColor.cyan])
        TxtUserName.backgroundColor = .clear
        
        TxtPassword.backgroundColor = .clear
        TxtPassword.attributedPlaceholder = NSAttributedString(string: "Enter Password Name",attributes: [NSAttributedStringKey.foregroundColor: UIColor.cyan])
        TxtPassword.backgroundColor = .clear
        
        LoginVW.layer.cornerRadius = 30
        
        BtnSignIn.layer.cornerRadius = 14
        BtnSignIn.layer.borderWidth = 2
        BtnSignIn.layer.borderColor = UIColor.red.cgColor
        BtnSignIn.backgroundColor = .clear
    }
    func Textfieldvalidation(){
        
        TxtUserName.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "UserL")
        imageView.image = image
        TxtUserName.rightView = imageView
        
        TxtPassword.rightViewMode = UITextFieldViewMode.always
        let imageView5 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image5 = UIImage(named: "PassL")
        imageView5.image = image5
        TxtPassword.rightView = imageView5
    }
    @IBAction func BtnSign(_ sender: UIButton) {
    }
    
    @IBAction func BtnRegister(_ sender: UIButton) {
        let Navigate =  UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
    
    self.navigationController?.pushViewController(Navigate, animated: true)
    }
    
    
    
    
 
}

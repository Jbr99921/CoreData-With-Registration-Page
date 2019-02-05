//
//  RegisterCellCell.swift
//  RegistrationPageCoreData
//
//  Created by MacMiniOld on 15/11/18.
//  Copyright © 2018 Xongolab. All rights reserved.
//

import UIKit

class RegisterCellCell: UITableViewCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet var ImgUser: UIImageView!
    @IBOutlet var Fname: UILabel!
    @IBOutlet var Lname: UILabel!
    @IBOutlet var User: UILabel!
    @IBOutlet var Email: UILabel!
    @IBOutlet var Pass: UILabel!
    @IBOutlet var UniqueID: UILabel!
    
    
    let imagePicker = UIImagePickerController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        imagePicker.delegate = self
        ImgUser.layer.cornerRadius = ImgUser.frame.size.height/2
        ImgUser.clipsToBounds = false
        ImgUser.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
let imagePicker = UIImagePickerController()

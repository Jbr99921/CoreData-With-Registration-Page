//
//  ShowRegisterVC.swift
//  RegistrationPageCoreData
//
//  Created by MacMiniOld on 05/11/18.
//  Copyright © 2018 Xongolab. All rights reserved.
//

import UIKit

import CoreData

class ShowRegisterVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var AddRecord: UIButton!
    @IBOutlet var UpdateRecord: UIButton!
    @IBOutlet var TblView: UITableView!
    var register = [NSManagedObject]()
    
    var err:NSError?
    var StorecoreRecords:[RegistrationDetails] = []
    
    override func viewDidAppear(_ animated: Bool) {
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RegistrationDetails")
        TblView.reloadData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        self.TblView.reloadData()

        TblView.layer.cornerRadius = 30
        AddRecord.layer.cornerRadius = 14
        AddRecord.layer.borderWidth = 1
        AddRecord.layer.borderColor = UIColor.red.cgColor
        UpdateRecord.layer.cornerRadius = 14
        UpdateRecord.layer.borderWidth = 1

        StorecoreRecords = DatabaseHelper.shareInstance.GetShowData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorecoreRecords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reference =  StorecoreRecords[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCellCell", for: indexPath) as! RegisterCellCell
        cell.Fname.text = reference.firstName
        cell.Lname.text = reference.lastName
        cell.User.text = reference.user
        cell.Email.text = reference.email
        cell.Pass.text = reference.password
        cell.UniqueID.text = reference.uniqueId
        if let Imagedata = reference.imgUser {
        cell.ImgUser?.image = UIImage(data: Imagedata as Data)
        }
      //  DatabaseHelper.shareInstance.clearCoreData()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let navigate = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditVC") as! EditVC
        let celldetail = tableView.cellForRow(at: indexPath) as! RegisterCellCell
        navigate.Fname = celldetail.Fname.text
        navigate.Lname = celldetail.Lname.text
        navigate.user = celldetail.User.text
        navigate.email = celldetail.Email.text
        navigate.pass = celldetail.Pass.text
        navigate.UniqueID = celldetail.UniqueID.text
        self.navigationController?.pushViewController(navigate, animated: true)
         self.TblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
       
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            context.delete(StorecoreRecords[indexPath.row])
            StorecoreRecords.remove(at: indexPath.row)
            do{
                try context.save()
            }catch{
                return
            }
        self.TblView.deleteRows(at: [indexPath], with: .left)
        }else{
            return
        }
    }
    @IBAction func AddRecords(_ sender: UIButton) {
    let navigat = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(navigat, animated: true)
    }
    @IBAction func UpdateRecord(_ sender: UIButton) {
     
    }
}
        
 


//
//  EditViewController.swift
//  foodbowl-ios
//
//  Created by Tech on 2021-04-10.
//  Copyright © 2021 GBC. All rights reserved.
//
import Foundation
import UIKit
import CoreData
import MessageUI


class EditViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    
    var dataFromRow: NSManagedObject!;
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_Address: UITextField!
    @IBOutlet weak var txt_City: UITextField!
    @IBOutlet weak var txt_Province: UITextField!
    @IBOutlet weak var txt_Country: UITextField!
    @IBOutlet weak var txt_Phone: UITextField!
    @IBOutlet weak var txt_Description: UITextField!
    @IBOutlet weak var txt_Tags: UITextField!
    @IBOutlet weak var txt_Rating: UITextField!

    
    @IBOutlet weak var err_name: UILabel!
    @IBOutlet weak var err_address: UILabel!
    @IBOutlet weak var err_city: UILabel!
    @IBOutlet weak var err_province: UILabel!
    @IBOutlet weak var err_country: UILabel!
    @IBOutlet weak var err_phone: UILabel!
    @IBOutlet weak var err_description: UILabel!
    @IBOutlet weak var err_tags: UILabel!
    @IBOutlet weak var err_rating: UILabel!
    
    @IBOutlet weak var err_message: UILabel!
    
    @IBAction func shareRestaurant(_ sender: Any) {
        print("hello")
        showMailComposer()
    }
    
    
    func showMailComposer(){
        let mailComposeViewController = configuredMailComposeViewController()
         if MFMailComposeViewController.canSendMail() {
             self.present(mailComposeViewController, animated: true, completion: nil)
           } else {
            print("no work")
         }
        
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
      let mailComposerVC = MFMailComposeViewController()
       mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("This is my review of:" + (txt_Name.text as! String))
        mailComposerVC.setMessageBody((txt_Name.text as! String) + "was a restaurant I visited. I gave it " + (txt_Rating.text as! String), isHTML: false)
        
              return mailComposerVC
            }
    
    @IBAction func mapToLocation(_ sender: Any) {
        
    }
    
    @IBAction func updateRestaurant(_ sender: UIButton) {
        let name: String! = txt_Name.text
        let address: String! = txt_Address.text
        let city: String! = txt_City.text
        let province: String! = txt_Province.text
        let country: String! = txt_Country.text
        let phone: String! = txt_Phone.text
        let desc: String! = txt_Description.text
        let tags: String! = txt_Tags.text
        let rating: String! = txt_Rating.text
        
        
        var isFormValid = true
        
        errFieldReset()
        //if set to false do dont submit
        
        
        if !name.isValid(.name){
            isFormValid = false
            err_name.text = "Invalid Name."
        }
        
        if !address.isValid(.address){
            isFormValid = false
            err_address.text = "Invalid Address"
        }
        
        if !city.isValid(.city){
            isFormValid = false
            err_city.text = "Invalid City"
        }
        
        if !province.isValid(.province){
            isFormValid = false
            err_province.text = "Invalid Province"
        }
        
        if !country.isValid(.country){
            isFormValid = false
            err_country.text = "Invalid Country"
        }
        
        if !phone.isValid(.phone){
            isFormValid = false
            err_phone.text = "Invalid Phone Number"
        }
        
        if !desc.isValid(.desc){
            isFormValid = false
            err_description.text = "Invalid Description"
        }
        
        if !tags.isValid(.tags){
            isFormValid = false
            err_tags.text = "Invalid Tags"
        }
        
        if !rating.isValid(.rating){
            isFormValid = false
            err_rating.text = "Invalid Rating"
        }
        
        
        
        //if passed all field checks send away!
        if(isFormValid){
        
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
            
            fetchRequest.predicate = NSPredicate(format: "name = %@", dataFromRow.value(forKey: "name") as! String)
            do {
                let results = try context.fetch(fetchRequest) as? [NSManagedObject]
                if results?.count != 0 {
                    results?[0].setValue(txt_Name.text as! NSString, forKey: "name")
                    results?[0].setValue(txt_Address.text as! NSString, forKey: "address")
                    results?[0].setValue(txt_City.text as! NSString, forKey: "city")
                    results?[0].setValue(txt_Province.text as! NSString, forKey: "province")
                    results?[0].setValue(txt_Country.text as! NSString, forKey: "country")
                    results?[0].setValue(txt_Description.text as! NSString, forKey: "desc")
                    results?[0].setValue(txt_Tags.text as! NSString, forKey: "tags")
                    results?[0].setValue(txt_Phone.text as! NSString, forKey: "phone")
                    results?[0].setValue(txt_Rating.text as! NSString, forKey: "rating")
                }
            } catch {
                print("CATCH")
                err_message.text = "Failed Search."
            }
            
            do {
                try context.save()
                err_message.text = "Update Successful.";
                //restaurantList.append(restaurant)
            } catch let error as NSError {
                err_message.text = "Update Failed.";
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFromRow.value(forKey: "name") as! String)
        txt_Name.text = dataFromRow.value(forKey: "name") as! String;
        txt_Address.text = dataFromRow.value(forKey: "address") as! String;
        txt_City.text = dataFromRow.value(forKey: "city") as! String;
        txt_Province.text = dataFromRow.value(forKey: "province") as! String;
        txt_Country.text = dataFromRow.value(forKey: "country") as! String;
        txt_Phone.text = dataFromRow.value(forKey: "phone") as! String;
        txt_Description.text = dataFromRow.value(forKey: "desc") as! String;
        txt_Tags.text = dataFromRow.value(forKey: "tags") as! String;
        txt_Rating.text = dataFromRow.value(forKey: "rating") as! String;
        
        err_name.text = "";
        err_address.text = "";
        err_city.text = "";
        err_province.text = "";
        err_country.text = "";
        err_phone.text = "";
        err_description.text = "";
        err_tags.text = "";
        err_rating.text = "";
        err_message.text = "";
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue"{
            let destVC : MapViewController = segue.destination as! MapViewController
            destVC.address = txt_Address.text as! String;
            destVC.city = txt_City.text as! String;
            destVC.province = txt_Province.text as! String;
        }
    }
    /*
    @IBAction func editRestaurant(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName:"Restaurant", in:context){
            let
        }
        
        
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func errFieldReset(){
        err_name.text = "";
        err_address.text = "";
        err_city.text = "";
        err_province.text = "";
        err_country.text = "";
        err_phone.text = "";
        err_description.text = "";
        err_tags.text = "";
        err_rating.text = "";
        
    }
}





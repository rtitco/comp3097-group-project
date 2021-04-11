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

class EditViewController: UIViewController {
    
    
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
        //Share Button code goes here
    }
    
    @IBAction func updateRestaurant(_ sender: UIButton) {
        
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

}

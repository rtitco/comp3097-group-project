import Foundation
import UIKit
import CoreData

class AddViewController: UIViewController {
    
    @IBOutlet weak var lbl_AddTitle: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_Address: UITextField!
    @IBOutlet weak var txt_City: UITextField!
    @IBOutlet weak var txt_Province: UITextField!
    @IBOutlet weak var txt_Country: UITextField!
    @IBOutlet weak var txt_Phone: UITextField!
    @IBOutlet weak var txt_Desc: UITextView!
    @IBOutlet weak var txt_Tags: UITextField!
    @IBOutlet weak var txt_Rating: UITextField!
    
    
    @IBAction func saveRestaurant(_ sender: UIButton) {
        let name: String! = txt_Name.text
        let address: String! = txt_Address.text
        let city: String! = txt_City.text
        let province: String! = txt_Province.text
        let country: String! = txt_Country.text
        let phone: String! = txt_Phone.text
        let desc: String! = txt_Phone.text
        let tags: String! = txt_Tags.text
        let rating: String! = txt_Rating.text
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
    
        if let entity = NSEntityDescription.entity(forEntityName: "Restaurant", in: context){
        let restaurant = NSManagedObject(entity:entity, insertInto: context)
        
        restaurant.setValue(name, forKeyPath: "name")
        restaurant.setValue(address, forKeyPath: "address")
        restaurant.setValue(city, forKeyPath: "city")
        restaurant.setValue(province, forKeyPath: "province")
        restaurant.setValue(country, forKeyPath: "country")
        restaurant.setValue(phone, forKeyPath: "phone")
        restaurant.setValue(desc, forKeyPath: "desc")
        restaurant.setValue(tags, forKeyPath: "tags")
        restaurant.setValue(rating, forKeyPath: "rating")
    
            do {
                try context.save()
                print("Save Successful")
                //restaurantList.append(restaurant)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        //restaurantArray? =
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

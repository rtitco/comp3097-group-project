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
    
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var err_name: UILabel!
    @IBOutlet weak var err_address: UILabel!
    @IBOutlet weak var err_city: UILabel!
    @IBOutlet weak var err_province: UILabel!
    @IBOutlet weak var err_country: UILabel!
    @IBOutlet weak var err_phone: UILabel!
    @IBOutlet weak var err_description: UILabel!
    @IBOutlet weak var err_tags: UILabel!
    @IBOutlet weak var err_rating: UILabel!
    
    let rgx_str = "/^[A-Za-z]{1,}([- ]*[A-Za-z]{1,}){0,}$/";
    let rgx_Phone = "/^$/";
    let rgx_Address = "/^[0-9]{1,5}[ ]{1}[A-Za-z]{1,}([ ]{1}[A-Za-z]{2,}){1,}([ ]{1}[A-Za-z]{0,1}){0,1}([,]{0,1}[ ]{1}[A-Za-z]{4,} [ ]{1} [0-9]{1,}){0,1}$/";
    let rgx_Tags = "/^[a-zA-Z]{2,}([,]{1}[ ]{0,1}[a-zA-Z]{2,})*$/";
    let rgx_Rating = "/^[0-5]{1}$/";
    
    //Validation to do for next part
    /*
    func isValid(userInput: String, type: String)->Bool{
        let format = "SELF MATCHES %&";
        var validateInput: Any;
        
        if(type == "phone"){
            validateInput = NSPredicate(format: format, rgx_Phone)
            return validateInput.evaluateWithObject(userInput);
            
        } else if(type == "address"){
            
        } else if(type == "tags"){
            
        } else if (type == "rating"){
            
        } else {
            
        }
        
    }
 */
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
                lbl_Message.text = "Save Successful.";
                //restaurantList.append(restaurant)
            } catch let error as NSError {
                lbl_Message.text = "Save Failed.";
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_Message.text = "";
        err_name.text = "";
        err_address.text = "";
        err_city.text = "";
        err_province.text = "";
        err_country.text = "";
        err_phone.text = "";
        err_description.text = "";
        err_tags.text = "";
        err_rating.text = "";
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

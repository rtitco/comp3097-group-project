import Foundation
import UIKit
import CoreData

class AddViewController: UIViewController {
    
    //let validityType: String.ValidityType = .phone
    
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
    
    
    @IBAction func saveRestaurant(_ sender: UIButton) {
        let name: String! = txt_Name.text
        let address: String! = txt_Address.text
        let city: String! = txt_City.text
        let province: String! = txt_Province.text
        let country: String! = txt_Country.text
        let phone: String! = txt_Phone.text
        let desc: String! = txt_Desc.text
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
        else{
            lbl_Message.text = "Invalid Fields."
        }
        
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_Message.text = "";
        errFieldReset()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}


extension String {
    enum ValidityType {
        case name
        case address
        case city
        case province
        case country
        case phone
        case desc
        case tags
        case rating
    }
    
    enum Regex: String {
        case str = "^[A-Za-z]{1,}([- ]*[A-Za-z]{1,}){0,}$";
        case phone = "^[0-9]{10}$";
        case address = "^[0-9]{1,5}[ ]{1}[A-Za-z]{1,}([ ]{1}[A-Za-z]{2,}){1,}([ ]{1}[A-Za-z]{0,1}){0,1}([,]{0,1}[ ]{1}[A-Za-z]{4,} [ ]{1} [0-9]{1,}){0,1}$";
        case tags = "^[A-Za-z]{1,}([- ]*[A-Za-z]{1,}){0,}([,]{1}[ ]{0,1}[A-Za-z]{1,}([- ]*[A-Za-z]{1,}){0,})*$";
        case rating = "^[0-5]{1}$";
    }
    
    func isValid(_ validityType: ValidityType)->Bool{
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .name:
            regex = Regex.str.rawValue
        case .address:
            regex = Regex.address.rawValue
        case .city:
            regex = Regex.str.rawValue
        case .province:
            regex = Regex.str.rawValue
        case .country:
            regex = Regex.str.rawValue
        case .phone:
            regex = Regex.phone.rawValue
        case .desc:
            regex = Regex.str.rawValue
        case .tags:
            regex = Regex.tags.rawValue
        case .rating:
            regex = Regex.rating.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}

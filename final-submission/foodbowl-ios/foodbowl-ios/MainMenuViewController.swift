import UIKit
import CoreData

class RestaurantTableViewCell: UITableViewCell{
    

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var restuarantName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var tagslist: UILabel!
}

class MainMenuViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var restaurantList:[NSManagedObject] = []
    var selectedRestaurant:NSManagedObject!
    
    var filteredList:[NSManagedObject]!
    
    func getRestaurants() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Restaurant")
        
        do {
            restaurantList = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if (!searchText.isEmpty){
            let p1 = NSPredicate(format:"tags CONTAINS[c] %@", searchText);
            let p2 = NSPredicate(format:"name CONTAINS[c] %@", searchText);
            let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [p1, p2])
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
            fetchRequest.predicate = predicate
            do {
                restaurantList = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
                print(restaurantList.count)
            } catch let error as NSError {
                print("Could not fetch. \(error)")
            }
             
        } else {
            getRestaurants()
        }
        tableView.reloadData()
    }
    
    func checkRating(rating: String) -> String {
        if rating == "1"{
            return "☆☆☆☆★" }
        if rating == "2"{
             return "☆☆☆★★" }
        if rating == "3"{
             return "☆☆★★★" }
        if rating == "4"{
             return "☆★★★★" }
        if rating == "5"{
             return "★★★★★" }
        return "no rating"
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRestaurants()
        tableView.reloadData()
    }
    override func viewDidLoad() {
        searchBar.delegate=self;
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.restaurantList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(108)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = restaurantList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell
        
        cell.restuarantName?.text = restaurant.value(forKeyPath: "name") as! String
        cell.desc?.text = restaurant.value(forKeyPath: "desc") as! String
        cell.phone?.text = restaurant.value(forKeyPath: "phone") as! String
        
        var address = restaurant.value(forKeyPath: "address") as! String
        var city = restaurant.value(forKeyPath: "city") as! String
        var province = restaurant.value(forKeyPath: "province") as! String
        var country = restaurant.value(forKeyPath: "country") as! String
        cell.address.text = address + " " + city + ", " + province + " " + country
        cell.rating?.text = checkRating(rating: restaurant.value(forKeyPath: "rating") as! String)
        cell.tagslist?.text = restaurant.value(forKeyPath: "tags") as! String

        return cell
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditSegue"{
            let destVC : EditViewController = segue.destination as! EditViewController
            let rowIndex:Int! = tableView.indexPathForSelectedRow?.row
            destVC.dataFromRow = restaurantList[rowIndex]
        }
    }
 
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let context = appDelegate.persistentContainer.viewContext
            
            // Delete the row from the data source
            
            let restaurant = restaurantList[indexPath.row]
            context.delete(restaurant)
            restaurantList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}

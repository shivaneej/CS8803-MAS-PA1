//
//  BuyViewController.swift
//  Seller
//
//  Created by Daniel Basman on 9/9/22.
//

import UIKit

class BuyViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    

    @IBOutlet weak var itemTable: UITableView!
    let tableViewData = Array(repeating: "Item", count: 5)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        call()
           
//        print(call()?.values)
        itemTable.register(UITableViewCell.self,
                               forCellReuseIdentifier: "TableViewCell")
        
        itemTable.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
     
    */
    

    func call () -> NSArray? {
        
//        let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
        var x:NSArray? = nil
        let url = URL(string: "https://mas-prog-asgn.herokuapp.com/posts")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
//        request.httpBody = try? JSONSerialization.data(wit, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response!)
            do {
                x = (try JSONSerialization.jsonObject(with: data!)) as! NSArray
//                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                x = json
                print(x?[1])
                
            } catch {
                print("error")
            }
           
        })

        task.resume()
        return x

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let x = call()
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                                     for: indexPath)
            cell.textLabel?.text = self.tableViewData[indexPath.row]
            return cell
    }
    

}



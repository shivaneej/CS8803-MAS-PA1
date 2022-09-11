//
//  BuyViewController.swift
//  Seller
//
//  Created by Daniel Basman on 9/9/22.
//

import UIKit

class BuyViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var itemTable: UITableView!
    var tableViewData: NSArray? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableViewData = self.call()
            self.itemTable.reloadData()
        }
        
        itemTable.register(UITableViewCell.self,
                               forCellReuseIdentifier: "TableViewCell")
        
        itemTable.dataSource = self
        itemTable.reloadData()
    }

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
                let jsonData = try! JSONSerialization.data(withJSONObject: x)
//                let arrayString = String(data: jsonData, encoding: .utf8)!
                let p = x as! NSArray
//                print(p)
                self.tableViewData = x
                DispatchQueue.main.async {
                    self.itemTable.reloadData()
                }
                

//                print(p.value(forKey: "category"))
            } catch {
                print("error")
            }
           
        })
        itemTable.reloadData()
        
        task.resume()
        return x

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let x = call()
        return tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                                     for: indexPath)
//            tableViewData = call()!
        let x = tableViewData![indexPath.row] as! Dictionary<String, Any>
        print(x)
        
       
        cell.textLabel?.text = x["name"] as? String
        
        let url = URL(string: x["image_url"] as! String)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.imageView?.image =  image
        }

            return cell
    }
    
    
    
    

}



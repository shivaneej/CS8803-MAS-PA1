//
//  BuyViewController.swift
//  Seller
//
//  Created by Daniel Basman on 9/9/22.
//

import UIKit

class BuyViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate, UITableViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemTable: UITableView!
    var tableViewData: NSArray? = nil
    @IBAction func ref(_ sender: Any) {
        viewDidLoad()
//        itemTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.itemTable.reloadData()
        DispatchQueue.main.async {
            self.tableViewData = self.call()
            self.itemTable.reloadData()
        }
        
        itemTable.register(UITableViewCell.self,
                               forCellReuseIdentifier: "TableViewCell")
        
        itemTable.allowsSelection = true
        itemTable.dataSource = self
        itemTable.delegate = self
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
//        print(x)
        
       
        
        
        let url = URL(string: x["image_url"] as! String)
        
        
        let session = URLSession.shared

        let downloadPicTask = session.dataTask(with: url!) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
//                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            cell.imageView?.image = image
                            cell.textLabel?.text = x["name"] as? String
                            
                        }
                        
                        // Do something with your image.
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print ("HERHEHERHERHHEHREHHRE")
        let z = tableViewData![indexPath.row] as! Dictionary<String, Any>
        let description = "Description: " + (z["description"] as? String)!
        let mobile = String(describing: z["mobile"] as! NSString)
        
        let w = "Contact Info: " + mobile
        
        let price = "Price: " + (z["price"] as! String)
        let message = description + "\n" + price + "\n" + w
        
        let alert = UIAlertController(title: z["name"] as! String, message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Call Seller", style: UIAlertAction.Style.default, handler: { action in
    
            UIApplication.shared.openURL(URL(string: "tel://\(mobile)")!)

        }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    

}



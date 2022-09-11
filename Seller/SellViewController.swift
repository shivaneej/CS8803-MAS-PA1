//
//  SellViewController.swift
//  Seller
//
//  Created by Daniel Basman on 9/9/22.
//

import UIKit

class SellViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemCategory: UITextField!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var itemContact: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    @IBOutlet weak var itemImageURL: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemDescription.layer.borderColor = UIColor.placeholderText.cgColor

        image.contentMode = .scaleAspectFill

        // Dismiss the keyboard after clicking outside the keyboard
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }

    // fetch the remote image from the url and set it in the image view
    @IBAction func fetchRemoteImage(_ sender: UITextField) {
        if sender.text == "" {
            return
        }
        let urlString = sender.text!
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        image.image = UIImage(data: data)
    }

    
    @IBAction func postButtonClicked(_ sender: UIButton) {
        guard let postTitle = itemName.text, let postCategory = itemCategory.text, let postDesc = itemDescription.text, let postPrice = itemPrice.text, let postImage = itemImageURL.text, let postContact = itemContact.text else {
            return
        }
        
        // Validate fields
        if (postTitle.isEmpty) {
            displayAlert(message: "Please enter item name")
            return
        }
        
        if (postCategory.isEmpty) {
            displayAlert(message: "Please enter item category")
            return
        }
        
        if (postContact.isEmpty) {
            displayAlert(message: "Please enter contact number")
            return
        }
        
        if (postImage.isEmpty) {
            displayAlert(message: "Please enter item image url")
            return
        }
        
        if (postPrice.isEmpty) {
            displayAlert(message: "Please enter item price")
            return
        }
        
        createNewPost(title: postTitle, category: postCategory, description: postDesc, contact: postContact, imageURL: postImage, price: postPrice)
    }
    
    // POST request to create a new post
    func createNewPost(title: String, category: String, description: String, contact: String, imageURL: String, price: String) {
          let parameters: [String: Any] = ["category": category, "description": description, "image_url": imageURL, "mobile": contact, "name": title, "price": price]
          let url = URL(string: "https://mas-prog-asgn.herokuapp.com/posts")!
          
          let session = URLSession.shared
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          
          // add headers for the request
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          request.addValue("application/json", forHTTPHeaderField: "Accept")
          
          do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
          } catch let error {
            print(error.localizedDescription)
            return
          }
          
          // create dataTask using the session object to send data to the server
          let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
              print("Post Request Error: \(error.localizedDescription)")
              return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
              print("Invalid Response received from the server")
              return
            }
            
            guard let responseData = data else {
              print("No Data received from the server")
              return
            }
            
            do {
              if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                  print(jsonResponse)
                  let message = "Ad Posted!"
                  
                  /*
                  DispatchQueue.main.async {
                      if let navController = self.navigationController{
                          self.displayAlert(message: message, dismiss: true)
                      }
                  }
                */
              } else {
                print("data maybe corrupted or in wrong format")
                throw URLError(.badServerResponse)
              }
            } catch let error {
              print(error.localizedDescription)
            }
          }
          task.resume()
    }
    
    // Display alert with custom message
    func displayAlert(message: String, dismiss: Bool = false) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: false, completion: nil)
        if dismiss{
            let duration: Double = 1 // auto dismiss after 1 sec
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true)
                /*
                if let navcontroller = self.navigationController{
                    navcontroller.popViewController(animated: false)
                }
                for each in self.navigationController.viewControllers {
                    if let each = each as? buy {
                    navigationController.popToViewController(each, animated: false)
                    }
                }
                */
            }
        }
        
                         
    }
}

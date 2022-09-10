//
//  SellViewController.swift
//  Seller
//
//  Created by Daniel Basman on 9/9/22.
//

import UIKit

class SellViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var image: UIImageView!
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemCategory: UITextField!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var itemContact: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    @IBAction func imageAddButton(_ sender: Any) {

        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image.image = img
            }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}

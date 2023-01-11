//
//  EditViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 10/1/23.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var textInput: UITextView!
    var currPost: String?
    var image: UIImage?
    var curIndex: Int?
    var delegate: delegateProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        textInput.layer.borderWidth = 1
        textInput.layer.cornerRadius = 20
        textInput.layer.borderColor = UIColor(named: "customBlue")?.cgColor
        imageView.layer.cornerRadius = 20
        updateButton.layer.cornerRadius = 20
        
        textInput.text = currPost
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateAction(_ sender: Any) {
        if currPost != " "{
            delegate?.updatePost(curIndex!,textInput.text!, imageView.image )
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func changeImage(_ sender: Any) {
        imagePicker()
    }
}
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePicker(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
        }
        picker.dismiss(animated: true)
        
    }
    
}

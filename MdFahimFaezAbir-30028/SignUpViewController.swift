//
//  SignUpViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 10/1/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    var user = [User]()
    var count = 0
    var delegate: logindelegateProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserDBHelper.shared.getAllUser(){
            count = user.count
            print(count)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        addNewUser(userName: userName.text!, userEmail: userEmail.text!, userPassword: userPassword.text!, confirmPassword: confirmPassword.text!)
        self.dismiss(animated: true)
    }
    
    func addNewUser(userName: String, userEmail: String, userPassword: String, confirmPassword: String){
        if userName != " " && userEmail != " " && userPassword != " " && confirmPassword != " "{
            if userPassword == confirmPassword{
                UserDBHelper.shared.addUser(userId: count+1,userName: userName, userEmail: userEmail, userPassword: userPassword)
                delegate?.getUser()
            }else{
                let alert = UIAlertController(title: "SignUp Failed!!", message: "Password & confirm password doesnot match", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .default){_ in
                    alert.dismiss(animated: true)
                }
                alert.addAction(cancel)
                present(alert,animated: true)
            }
        }
        
    }
    
}

//
//  LogInViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 6/1/23.
//

import UIKit
protocol logindelegateProtocol{
    func getUser()
}

class LogInViewController: UIViewController, logindelegateProtocol {
    let encoder = JSONEncoder()
    var users = [User]()
    @IBOutlet weak var logInButtonLeading: NSLayoutConstraint!
    @IBOutlet weak var loginButtonVertical: NSLayoutConstraint!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var logInField: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        logInField.layer.cornerRadius = 5
        navigationController?.setNavigationBarHidden(true, animated: false)
        getUser()
        
    }
    func getUser(){
        if let user = UserDBHelper.shared.getAllUser(){
            users = user
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.signup {
            if let signup = segue.destination as? SignUpViewController{
                signup.delegate = self
            }
        }
    }
    @IBAction func signUpAction(_ sender: Any) {
        performSegue(withIdentifier: Constants.signup, sender: nil)
    }
    @IBAction func logInAction(_ sender: Any) {
        var isLogin: Bool = false
        if emailField.text != "" && passwordField.text != "" {
            if let email = emailField.text, let password = passwordField.text{
                print(KeyChainHelperClass.keyChainShared.readFromKeyChain(account: email, service: "password"))
                isLogin = logIn(email: email, password: password)
            }
        }
        if isLogin{
            performSegue(withIdentifier: Constants.newsFeedSegue, sender: self)
        }else{
            showAlert()
        }
    }
}
extension LogInViewController{
    func showAlert(){
        
        UIView.animate(withDuration: 2,delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let self = self else {return}
            self.logInField.setTitle("failed!!", for: .normal)
            sleep(1)
            self.logInButtonLeading.constant = -20
            self.loginButtonVertical.constant -= 20 + 315
            self.logInField.layer.backgroundColor = UIColor.red.cgColor
            self.view.layoutIfNeeded()
            
        }, completion: { [weak self]_ in
            
            self?.logInButtonLeading.constant = 30
            self?.loginButtonVertical.constant = 0
            self?.logInField.setTitle("Log In", for: .normal)
            self?.logInField.layer.backgroundColor = UIColor(named: "customBlue")?.cgColor
        })
        
        
        
    }
}

extension LogInViewController{
    func logIn(email: String, password: String)-> Bool{
        var flag = false
        
        for i in 0..<users.count{
            if email == users[i].userEmail && password == users[i].userPassword{
                let user = UserInfo(userId: users[i].userId,userName: users[i].userName!, userEmail: email, userPassword: password, isLoggedIn: true)
                KeyChainHelperClass.keyChainShared.writeToKeychain(pass: password, email: email)
                do{
                    let userData = try encoder.encode(user)
                    UserDefaults.standard.set(userData, forKey: Constants.userData)
                    print(userData)
                    flag = true
                    break
                }catch{
                    print(error)
                }
                
            }
            
        }
        if flag{
            return true
        }else{
            return false
        }
        
    }
}

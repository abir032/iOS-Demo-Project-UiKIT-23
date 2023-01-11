//
//  ProfileViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 7/1/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var user: UserInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fetchData()
        profileImage.layer.cornerRadius = profileImage.bounds.size.width / 2.0
        userName.text = user.userName
        userTableView.dataSource = self
        userTableView.delegate = self
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        logOut()
    }
    func logOut(){
        self.user.isLoggedIn = false
        saveData(user: self.user)
        setRootViewController()
        
    }
    func fetchData(){
        let decoder = JSONDecoder()
        if let fetchedData = UserDefaults.standard.data(forKey: Constants.userData) {
            if let user = try? decoder.decode(UserInfo.self, from: fetchedData) {
                self.user = user
            }
        }
    }
    func saveData(user: UserInfo){
        let encoder = JSONEncoder()
        do{
            let userData = try encoder.encode(user)
            UserDefaults.standard.set(userData, forKey: Constants.userData)
        }catch{
            print(error)
        }
    }
    func setRootViewController() {
        // let window = UIWindow(windowScene: windowScene)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        // let viewcontroller = UIViewController()
        let vc = storyboard?.instantiateViewController(identifier: "navigation") as! UINavigationController
        sceneDelegate.window?.rootViewController = vc
    }
}


extension ProfileViewController: UITableViewDelegate{
    
}
extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: Constants.firstCell, for: indexPath) as! UserProfileTableViewCell
        cell.email.text = user.userEmail
        cell.isOnline.text = "Online"
        return cell
    }
}

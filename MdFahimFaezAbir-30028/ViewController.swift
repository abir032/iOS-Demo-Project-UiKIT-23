//
//  ViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 20/12/22.
//

import UIKit
protocol delegateProtocol{
    func updatePost(_ currIndex: Int,_ updateText: String, _ updateImage: UIImage?)
}

class ViewController: UIViewController, delegateProtocol{
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textInput: UITextView!
    @IBOutlet weak var userInfo: UIButton!
    @IBOutlet weak var userNameField: UILabel!
    var images: UIImage?
    var currPost: String = ""
    var currImage: UIImage?
    var currIndex: Int?
    var user: UserInfo!
    var userPost = [Userpost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 20
        textInput.layer.borderWidth = 1
        textInput.layer.borderColor = UIColor.systemBlue.cgColor
        textInput.layer.cornerRadius = 15
        //createFileManager()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        ///textInput.layer.borderColor = UIColor.systemPink.cgColor
        //textInput.layer.cornerRadius = 5
        fetchData()
        userNameField.text = "Hi, " + user.userName
        getAllpost()
    }
    
    @IBAction func userInfo(_ sender: Any) {
        performSegue(withIdentifier: Constants.goToProfile, sender: self)
    }
    
    
    @IBAction func pickImage(_ sender: Any) {
        imagePicker()
    }
    
    @IBAction func postAction(_ sender: Any) {
        if textInput.text != ""{
            savePost(UserPost: textInput.text, images: images)
            images = nil
            getAllpost()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.editAction{
            if let editClass = segue.destination as? EditViewController{
                editClass.currPost = currPost
                editClass.image = currImage
                editClass.curIndex = currIndex
                editClass.delegate = self
            }
        }
    }
    
    
    
}




extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPost.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstSection", for: indexPath) as! FirstSection
        cell.labelView.text = user.userName
        cell.titleInput.text = userPost[indexPath.row].post
        if let images = userPost[indexPath.row].imagePath{
            cell.imagesSet.image = UIImage(data: images)
        }
        cell.showOption.tag = indexPath.row
        cell.showOption.addTarget(self, action: #selector(showAlertOption), for: .touchUpInside)
        
        //            cell.imagesSet.bounds.size.height = 0
        //            cell.imagesSet.bounds.size.width = 0
        return cell
        
    }
    @objc func showAlertOption(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let alert = UIAlertController(title: "Choose Option", message: "", preferredStyle: .alert)
        let deleteAlert = UIAlertAction(title: "Delete Post", style: .default){ [weak self]_ in
            guard let self = self else { return}
            self.deletePost(indexPath: indexPath)
        }
        let editAlert = UIAlertAction(title: "Edit Post", style: .default){ [weak self]_ in
            guard let self = self else { return}
            self.editPost(indexPaths: indexPath)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default){_ in
            alert.dismiss(animated: true)
        }
        alert.addAction(editAlert)
        alert.addAction(deleteAlert)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        // cell.transform  = CGAffineTransform(scaleX: 1, y:  0)
        UIView.animate(withDuration: 0.8, animations:{
            cell.alpha = 1
        })
    }
    
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
extension ViewController{
    func fetchData(){
        let decoder = JSONDecoder()
        if let fetchedData = UserDefaults.standard.data(forKey: Constants.userData) {
            if let user = try? decoder.decode(UserInfo.self, from: fetchedData) {
                self.user = user
            }
        }
    }
}

extension ViewController{
    func savePost(UserPost: String, images: UIImage?){
        let post = CoreDataDB.shared.savePost(userid: user.userId,UserPost: UserPost, images: images)
        guard let post = post else {return}
        userPost.append(post)
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
        self.images = nil
    }
    
    func getAllpost(){
        
        guard let allPost = CoreDataDB.shared.getAllpost(userid: user.userId) else {return}
        userPost = allPost
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
    }
    func deletePost(indexPath: IndexPath) {
        CoreDataDB.shared.deletePost(indexPath: indexPath, postList:  userPost)
        userPost.remove(at: indexPath.row)
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
    }
    func editPost(indexPaths: IndexPath){
        currPost = userPost[indexPaths.row].post ?? " "
        if let images =  userPost[indexPaths.row].imagePath{
            currImage = UIImage(data: images)
        }
        currIndex = indexPaths.row
        
        performSegue(withIdentifier: Constants.editAction, sender: self)
    }
    func updatePost(_ currIndex: Int,_ updateText: String, _ updateImage: UIImage?){
        userPost[currIndex].post = updateText
        userPost[currIndex].imagePath = updateImage?.pngData()
        CoreDataDB.shared.updatePost(indexPath: currIndex, postList: userPost)
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
    }
    
}


extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePicker(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            images = image
        }
        picker.dismiss(animated: true)
        
    }
}

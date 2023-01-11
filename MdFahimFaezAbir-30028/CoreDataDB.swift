//
//  CoreDataDB.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 9/1/23.
//

import Foundation
import UIKit
import CoreData

class CoreDataDB{
    static let shared = CoreDataDB()
    private init(){}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func savePost(userid: Int32,UserPost: String, images: UIImage?)-> Userpost?{
        let post = Userpost(context: context)
        post.post = UserPost
        post.imagePath = images?.pngData()
        post.createDate = Date()
        post.updateDate = Date()
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        let predicate = NSPredicate(format: "userId == %i", userid)
        fetchRequest.predicate = predicate
        do {
            let user = try context.fetch(fetchRequest).first
            user?.addToUserPost(post)
            try context.save()
            return post
        }catch {
            print(error)
            return nil
        }
        
    }
    func getAllpost(userid: Int32)-> [Userpost]?{
        var post = [Userpost]()
        let fetchRequest = NSFetchRequest<Userpost>(entityName: "Userpost")
        //let predicate = NSPredicate(format: "userId == %@", userid)
        print(userid)
        let predicate = NSPredicate(format: "userId == %i", userid)
        
        fetchRequest.predicate = predicate
        do{
            post = try context.fetch(fetchRequest)
            return post
        }catch{
            print(error)
            return nil
        }
    }
    
    func deletePost(indexPath: IndexPath, postList: [Userpost]) {
        let post = postList[indexPath.row]
        context.delete(post)
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    func updatePost(indexPath: Int, postList: [Userpost]){
        let post = postList[indexPath]
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
}

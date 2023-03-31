//
//  FriendViewModel.swift
//  Friends
//
//  Created by Md Saddam Hossain on 30/3/23.
//

import Foundation
import Photos
import UIKit

class FriendViewModel{
    
    var friendssUrl = "https://randomuser.me/api/?page=3&results=10&seed=abc"
    static var cache = NSCache<AnyObject, UIImage>()
    static var share = FriendViewModel()
    
    func getdataFromAPI(completion: @escaping (AllFrinds)->()){
        
        URLSession.shared.dataTask(with: URL(string: friendssUrl)!) { data, response, error in
            guard error == nil, let data = data else { return }
            
            do{
                let friends = try JSONDecoder().decode(AllFrinds.self, from: data)
                completion(friends)
                /*
                for frn in friends.results{
                    print(frn.gender," -- ",frn.name.title,frn.name.first,frn.name.last)
                    print(frn.email," ",frn.cell)
                }
                */
            }catch{
                print("error")
            }
        }.resume()
        
    }
    
    func downloadImage(img: String, completion: @escaping (UIImage?)->()){
        let imgURL = URL(string: img)!
        if let cachedImage = FriendViewModel.cache.object(forKey: imgURL as AnyObject) {
           // print("You get image from cache")
            completion(cachedImage)
            
        }else{
            URLSession.shared.dataTask(with: imgURL) { (data, respnse, error) in
                if let error = error {
                    print("Error: \(error)")
                    
                }else if let data = data {
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        
                        if let img = image{
                            FriendViewModel.cache.setObject(img, forKey: imgURL as AnyObject)
                           // print("You get image from \(imgURL)")
                            completion(img)
                        }else{
                            completion(nil)
                        }
                    }
                }
            }.resume()
        }
    }
    deinit {
        
        print("Deinit NetworkManager")
    }
}

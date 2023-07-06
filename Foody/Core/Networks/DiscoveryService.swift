//
//  DiscoveryService.swift
//  Foody
//
//  Created by halil yılmaz on 5.07.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DiscoveryService {
    static let shared = DiscoveryService()
    
    struct User {
        let username: String
        let email: String
        // Diğer kullanıcı bilgileri
    }
    
    
    func searchUsers(withKeyword keyword: String, completion: @escaping ([User]?, Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users")
            .whereField("username", isGreaterThanOrEqualTo: keyword)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                var users: [User] = []
                
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    
                    let username = userData["username"] as? String ?? ""
                    let email = userData["email"] as? String ?? ""
                    
                    let user = User(username: username, email: email)
                    users.append(user)
                }
                
                completion(users, nil)
            }
    }
  
}

//
//  AddRecipeViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 29.06.2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class AddRecipeViewModel {

    func addRecipe(photo: UIImage?, title: String, subTitle: String, recipeTime: Int, materials: [String], howManyPersonFor: Int, completion: @escaping (Bool, Error?) -> Void) {
        // Öncelikle fotoğrafı veritabanına kaydedin.
        var photoURL: String? = nil
        if let photo = photo {
            // Fotoğrafı veritabanına kaydeden bir fonksiyon kullanın
            // Bu örnekte Firebase Storage kullanıldığını varsayalım
            uploadPhoto(photo) { result in
                switch result {
                case .success(let url):
                    photoURL = url
                    self.saveRecipe(photoURL: photoURL, title: title, subTitle: subTitle, recipeTime: recipeTime, materials: materials, howManyPersonFor: howManyPersonFor, completion: completion)
                case .failure(let error):
                    completion(false, error)
                }
            }
        } else {
            saveRecipe(photoURL: photoURL, title: title, subTitle: subTitle, recipeTime: recipeTime, materials: materials, howManyPersonFor: howManyPersonFor, completion: completion)
        }
    }

    private func uploadPhoto(_ photo: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = photo.jpegData(compressionQuality: 0.8) else {
              completion(.failure(UploadError.invalidImage))
              return
          }
          
          let storageRef = Storage.storage().reference().child("recipePhotos").child(UUID().uuidString)
          let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
              if let error = error {
                  completion(.failure(error))
              } else {
                  storageRef.downloadURL { url, error in
                      if let error = error {
                          completion(.failure(error))
                      } else if let downloadURL = url?.absoluteString {
                          completion(.success(downloadURL))
                      } else {
                          completion(.failure(UploadError.unknown))
                      }
                  }
              }
          }
    }

    private func saveRecipe(photoURL: String?, title: String, subTitle: String, recipeTime: Int, materials: [String], howManyPersonFor: Int, completion: @escaping (Bool, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(false, nil)
            return
        }
        
        var data: [String: Any] = [
            "title": title,
            "subTitle": subTitle,
            "recipeTime": recipeTime,
            "materials": materials,
            "howManyPersonFor": howManyPersonFor
        ]
        
        if let photoURL = photoURL {
            data["photoURL"] = photoURL
        }
        
        let collectionRef = Firestore.firestore().collection("recipies").document(userUID).collection(userUID)
        let documentRef = collectionRef.addDocument(data: data) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
        
        documentRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let detailId = document.documentID
                // Silme işlemi için detailId değerini kullanabilirsiniz
            } else {
                completion(false, error)
            }
        }
    }


}

enum UploadError: Error {
    case invalidImage
    case unknown
}


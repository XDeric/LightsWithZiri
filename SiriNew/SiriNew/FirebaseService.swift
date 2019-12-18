//
//  FirebaseService.swift
//  SiriNew
//
//  Created by EricM on 12/13/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import FirebaseFirestore

fileprivate enum FireStoreCollections: String {
    case button
}

enum SortingCriteria: String {
    case fromNewestToOldest = "dateCreated"
    var shouldSortDescending: Bool {
        switch self {
        case .fromNewestToOldest:
            return true
        }
    }
}

class FirestoreService {
    private init () {}
    
    static let manager = FirestoreService()
    private let db = Firestore.firestore()
    
    
//    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
//        var fields = user.fieldsDict
//        fields["dateCreated"] = Date()
//        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
//            if let error = error {
//                completion(.failure(error))
//                print(error)
//            }
//            completion(.success(()))
//        }
//    }
    
//    func updateCurrentUser(userName: String? = nil, photoURL: URL? = nil, completion: @escaping (Result<(), Error>) -> ()){
//        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
//            //MARK: TODO - handle can't get current user
//            return
//        }
//        var updateFields = [String:Any]()
//
//        if let user = userName {
//            updateFields["userName"] = user
//        }
//
//        if let photo = photoURL {
//            updateFields["photoURL"] = photo.absoluteString
//        }
        
        
        //PUT request
//        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//
//        }
//    }
    
    
    func createPost(button: ButtonStatus, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = button.fieldsDict
       
        //when creating for post need to save in document the post id
        db.collection(FireStoreCollections.button.rawValue).document(button.buttonID).setData(fields) { (error) in
            if let error = error {
                completion (.failure(error))
            }
            completion (.success(()))
        }
    }
    
    
    
    
    
    func getPosts(forUserID: String, completion: @escaping (Result<[ButtonStatus], Error>) -> ()) {
        db.collection(FireStoreCollections.button.rawValue).whereField("creatorID", isEqualTo: forUserID).addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let posts = snapshot?.documents.compactMap({ (snapshot) -> ButtonStatus? in
                    let buttonID = snapshot.documentID
                    let post = ButtonStatus(from: snapshot.data(), buttonID: buttonID)
                    return post
                })
                completion(.success(posts ?? []))
            }
        }
    }
    
//    func updateButton(status: Bool? = nil, completion: @escaping (Result<(), Error>) -> ()){
//        
//        var updateFields = [String:Any]()
//        
//        if let button = status {
//            updateFields["on"] = button
//        }
//        
//        if let photo = photoURL {
//            updateFields["photoURL"] = photo.absoluteString
//        }
//        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//            
//        }
//    }
    
    //MARK: delete user post
    
    func delete(buttonID: String, completion: @escaping (Result<(), Error>) -> ()) {
        db.collection(FireStoreCollections.button.rawValue).document(buttonID).delete { (error) in
            if let error = error {
                completion (.failure(error))
            }
            completion (.success(()))
        }
    }
}

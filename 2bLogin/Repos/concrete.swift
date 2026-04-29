//
//  concrete.swift
//  2bLogin
//
//  Created by Omar on 27/04/2026.
//

import Foundation

class LoginAthRepo: AuthRepoProtocol {
    func login(userCredentials: UserCredentials, completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() ){
            if (userCredentials.userName == "omar45" && userCredentials.password == "123456")
            {
                completion(.success(User(userName: "admin", token: "2r3fvhgrt4")))
                
            }else{
                completion(.failure(NSError(domain: "Ath", code: 401)))
            }
        }
    }
    
    
}

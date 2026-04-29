//
//  File.swift
//  2bLogin
//
//  Created by Omar on 27/04/2026.
//

import Foundation
class LoginUseCaseImp: LoginUseCaseProtocol {
    
    let userRepository: AuthRepoProtocol
    
    init(userRepository: AuthRepoProtocol) {
        self.userRepository = userRepository
    }
    enum userDefaultsKeys {
        static let userName = "userName"
        static let token = "token"
    }

    func execute(credentials: UserCredentials, completion: @escaping (Result<User, Error>) -> Void) {
        userRepository.login(userCredentials: credentials) { result in
            switch result {
                
            case .success(let user):
                UserDefaults.standard.set(user.userName,forKey: userDefaultsKeys.userName)
                
                UserDefaults.standard.set(user.token,forKey: userDefaultsKeys.token)
                completion(.success(user))
                
                
            case .failure(let e):
                completion(.failure(e))
            }
          
        }
    }
    
    
}

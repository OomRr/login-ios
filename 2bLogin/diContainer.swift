//
//  diContainer.swift
//  2bLogin
//
//  Created by Omar on 28/04/2026.
//

import Foundation
class DIContainer{
    static let shared = DIContainer()
    
    lazy var repo: AuthRepoProtocol = {
        return LoginAthRepo()
    }()
    lazy var loginUseCase: LoginUseCaseProtocol = {
        return LoginUseCaseImp(userRepository: repo)
        
    }()
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(loginUseCase: loginUseCase)
    }
    
}

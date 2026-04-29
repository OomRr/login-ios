//
//  LoginViewModel.swift
//  2bLogin
//
//  Created by Omar on 27/04/2026.
//

import Foundation
class LoginViewModel {
    
    var onStateChanged: ((LoginState) -> Void)?

    private  var state: LoginState = .idleState {
        didSet{
            onStateChanged?(state)
        }
    }
    
    
    let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    func didTapped(userName: String, password: String){
        guard !userName.isEmpty && !password.isEmpty else {
            state = .failureState("Fields cant be empty")
            return
        }
        state = .loadingState
        let userCredentials = UserCredentials(userName: userName, password: password)
        loginUseCase.execute(credentials: userCredentials) { [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case .success(let user):
                    self?.state = .successState(user)
                case .failure(let error):
                    self?.state = .failureState(error.localizedDescription)
             
                    
                }
            }
        }
    }
}
    
enum LoginState{
    case idleState
    case loadingState
    case successState(User)
    case failureState(String)
    
}

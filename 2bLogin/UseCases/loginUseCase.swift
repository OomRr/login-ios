//
//  loginUseCas.swift
//  2bLogin
//
//  Created by Omar on 27/04/2026.
//

import Foundation
protocol LoginUseCaseProtocol{
    func execute(credentials: UserCredentials, completion: @escaping (Result<User, Error>) ->Void)
    
}

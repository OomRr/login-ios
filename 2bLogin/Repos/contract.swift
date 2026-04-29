//
//  contract.swift
//  2bLogin
//
//  Created by Omar on 27/04/2026.
//

import Foundation
protocol AuthRepoProtocol {
    func login(userCredentials: UserCredentials, completion: @escaping (Result<User, Error>) -> Void)
}

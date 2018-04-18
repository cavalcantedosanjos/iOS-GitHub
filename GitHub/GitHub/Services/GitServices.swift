//
//  GitServices.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

class GitService {

    private let baseUrl = "https://api.github.com/"
    
    private var searchUserUrl: String {
        return baseUrl + "search/users"
    }
    
    func getUser(by name:String, onSuccess: @escaping (_ users: [User]?) -> Void,
                 onFailure: @escaping (_ error: ErrorResponse) -> Void,
                 onCompleted: @escaping ()-> Void) {
        
        let url = searchUserUrl + "?q=\(name)"
        
        Service().request(.get, urlString: url, onSuccess: { (response: SearchUserResponse?) in
            onSuccess(response?.items)
        }, onFailure: { (error) in
            onFailure(error)
        }, onCompleted: {
            onCompleted()
        })
    }
    
    func getRepositories(url: String, onSuccess: @escaping (_ repositories: [Repository]?) -> Void,
                         onFailure: @escaping (_ error: ErrorResponse) -> Void,
                         onCompleted: @escaping ()-> Void){
        
        Service().request(.get, urlString: url, onSuccess: { (response: [Repository]?) in
            onSuccess(response)
        }, onFailure: { (error) in
            onFailure(error)
        }, onCompleted: {
            onCompleted()
        })
    }
    
}

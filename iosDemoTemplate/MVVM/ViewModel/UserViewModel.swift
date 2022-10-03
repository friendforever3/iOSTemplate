//
//  UserViewModel.swift
//  iosDemoTemplate
//
//  Created by Surinder kumar on 24/07/22.
//

import UIKit

class UserViewModel: NSObject {

    public static let shared : UserViewModel? = UserViewModel()
    
    func userLogin(email:String,password:String,completion:@escaping (Bool,String)->()){
        
        let param = ["email":email,"pass":password]
        
        server(url: "BaseUrl", apiMethod: .post, param: param, header: nil) { (response,responseData,success) in
            
            let usersData = try? JSONDecoder().decode(CommonModel.self, from: responseData ?? Data())
            if usersData?.status_code == 200{
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
        }
        
    }
    
}

//
//  APIHepler.swift
//  ProductForm
//
//  Created by Surinder Kumar on 01/08/21.
//

import Foundation
import Alamofire
import UIKit

func server(url:String,apiMethod:HTTPMethod,param:[String:Any]?,header:HTTPHeaders?,completion:@escaping([String:Any],Data?,Bool)->()){
    
    print("baseurl:-",url)
    print("parameter:-",param)
    if Connectivity.isConnectedToInternet(){
      
        AF.request(url, method: apiMethod, parameters: param, headers: header).responseJSON { (response) in
            
           // print("response.response?.statusCode:-",response.response?.statusCode)
            switch (response.result){
            
            case .success(_):
                
                if let dict = response.value as? [String:Any]{
                    
                    if response.response?.statusCode == 401{
                            UtilityMangr.shared.removeDetailsLogout()
                            let story = UIStoryboard(name: "Main", bundle:nil)
                            let vc = story.instantiateViewController(withIdentifier: "LoginVC")
                            let navigationController = UINavigationController(rootViewController: vc)
                            //navigationController.navigationBar.isHidden = true
                            navigationController.setNavigationBarHidden(true, animated: false)
                            UIApplication.shared.windows.first?.rootViewController = navigationController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                       
                    }else{
                        completion(dict,response.data, true)
                    }
                }
                break
            case .failure(let error):
                let dict = ["status_code":500,"message":error.localizedDescription ] as [String : Any]
                let jsonData = dict.jsonStringRepresentation?.data(using: .utf8) ?? Data()
                completion([:],jsonData,false)
                break
            }
        }
    }else{
        let dict = ["status_code":501,"message":"Please connect to the internet"] as [String : Any]
        let jsonData = dict.jsonStringRepresentation?.data(using: .utf8) ?? Data()
        completion(dict,jsonData, false)
    }
    
    
}


func uploadDataToServer(url:String,imageKey:String,imagedata:Data?,param:[String:String],header:HTTPHeaders?,completion:@escaping([String:Any],Data?)->()){
    if Connectivity.isConnectedToInternet(){
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in param {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            if let dataarray = imagedata{
                
                // for (index,value) in dataarray.enumerated(){
                
                // print(value)
                multipartFormData.append(dataarray, withName: imageKey, fileName: "\(UUID().uuidString).png", mimeType: "\(UUID().uuidString)/png")
                //}
            }
        },
                  to: url, method: .post , headers: header)
            .responseJSON(completionHandler: { (response) in
                
                if let err = response.error{
                    print(err)
                    return
                }
                print("Succesfully uploaded")
                
                let json = response.value as? [String:Any] ?? [:]
                
                if (json != nil)
                {
                    completion(json, response.data)
                    // let jsonObject = JSON(json!)
                    // print(jsonObject)
                }
            })
    }else{
        let dict = ["status_code":501,"message":"Please connect to the internet"] as [String : Any]
        let jsonData = dict.jsonStringRepresentation?.data(using: .utf8) ?? Data()
        completion(dict, jsonData)
    }
}

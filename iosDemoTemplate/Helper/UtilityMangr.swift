//
//  UtilityMangr.swift
//  CampersCloset
//
//  Created by Surinder Kumar on 11/05/22.
//
import Foundation
import UIKit
import NVActivityIndicatorView
import Alamofire
import Kingfisher

class UtilityMangr : NSObject{
    
    public static var shared = UtilityMangr()
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
     var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func removeUserDefault(_ keys:[String]){
        for key in keys{
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    func removeDetailsLogout(){
        removeUserDefault(["userDetail","appToken"])
    }
    
    func setImage(url:String,imgVw:UIImageView){
        imgVw.kf.indicatorType = .activity
        //DispatchQueue.main.async {
        imgVw.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "defaultImage"), options: nil) { (result) in
            switch result{
            case .success(let _):
                break
            case .failure(let error):
                print("dsds")
                // print(error.localizedDescription)
            }
            // }
        }
    }
    
    func decorateText(sub:String, des:String,subFont:String,desFont:String,subSize:CGFloat,desSize:CGFloat,subColor:UIColor,desColor:UIColor)->NSAttributedString{
        let textAttributesOne = [NSAttributedString.Key.foregroundColor: subColor, NSAttributedString.Key.font: UIFont(name: subFont, size: subSize)]
        let textAttributesTwo = [NSAttributedString.Key.foregroundColor: desColor, NSAttributedString.Key.font: UIFont(name: desFont, size: desSize)]
        
        let textPartOne = NSMutableAttributedString(string: sub, attributes: textAttributesOne as [NSAttributedString.Key : Any])
        let textPartTwo = NSMutableAttributedString(string: des, attributes: textAttributesTwo as [NSAttributedString.Key : Any])
        
        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        return textCombination
    }
    
    func isValidEmail(testStr:String) -> Bool {
            // print("validate calendar: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
    
    func dateFormatter(inputDate:String,inputFormat:String,outputFormat:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat //"yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from:inputDate) else{return ""}
        dateFormatter.dateFormat = outputFormat//"yyyy-MM-dd h:mm a"
        let datestr = dateFormatter.string(from: date)
        return datestr
    }
    
}


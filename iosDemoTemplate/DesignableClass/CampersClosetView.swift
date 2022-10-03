

import UIKit

class ShadowView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // corner radius
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        // border
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor

        // shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }

}

@IBDesignable
class ViewCustom: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var dropShadow: Bool {
           set{
               if newValue {
                   layer.shadowColor = UIColor.black.cgColor
                   layer.shadowOpacity = 0.4
                   layer.shadowRadius = 1
                   layer.shadowOffset = CGSize.zero
               } else {
                   layer.shadowColor = UIColor.clear.cgColor
                   layer.shadowOpacity = 0
                   layer.shadowRadius = 0
                   layer.shadowOffset = CGSize.zero
               }
           }
           get {
               return layer.shadowOpacity > 0
           }
       }
    
    @IBInspectable var shadowWidth:CGFloat = 0{
        
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
        
    }
    @IBInspectable var shadowHeight:CGFloat = 0{
        
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowOpacity:Float = 0.0{
        
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowColor:UIColor = UIColor.clear{
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
        
    }
    
    @IBInspectable var isShadow:Bool = false{
        didSet {
            if(!isShadow){
                
                layer.shadowColor = UIColor.clear.cgColor
                layer.shadowOffset = .zero
                layer.shadowOpacity = 0
                layer.masksToBounds = false
                layer.shadowRadius = 0
            }
            else{
                layer.shadowColor = shadowColor.cgColor
                layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
                layer.shadowOpacity = shadowOpacity
                layer.masksToBounds = false
                layer.shadowRadius = shadowRadius
                
            }
        }
    }
    
    @IBInspectable var shadowRadius:CGFloat = 0.0{
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
            layer.shadowOpacity = shadowOpacity
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
        }
        
    }
    
    @IBInspectable var isRound: Bool = false {
        didSet {
            if(isRound){
                layer.cornerRadius = self.frame.height/2
                layer.masksToBounds = true
            }
        }
    }
    

}

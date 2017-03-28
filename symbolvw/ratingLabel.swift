//
//  simleylabel.swift
//  Kedar
//
//  Created by Kedar on 24/01/17.
//  Copyright © 2017 com.kedar. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class StarLabel:UILabel
{
    private var startPoint:CGPoint = .zero
    private var currentPoint:CGPoint = .zero
    private var endPointPoint:CGPoint = .zero
    
    @IBInspectable var preSymbol:String = "★" {
        didSet{
            self.attributedText = fillRating(fillValue: 2)
        }
    }
    @IBInspectable var postSymbol:String = "★"
    @IBInspectable var symbolCount:UInt = 5
    @IBInspectable var fillColor:UIColor = .orange
    @IBInspectable var emptyColor:UIColor = .lightGray
    @IBInspectable var glowColor:UIColor = .orange
    @IBInspectable var glowShadowOffSet:CGSize = .zero
    @IBInspectable var glowBlurRadius:CGFloat = 5
    
    var finalRating:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.adjustsFontSizeToFitWidth = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(touches.count == 1)
        {
            let touch =    touches.first
            startPoint = (touch?.location(in: self))!
            //print("Start Point \(startPoint.x)")
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(touches.count == 1)
        {
            let touch =    touches.first
            currentPoint = (touch?.location(in: self))!
            //print("Current Point \(currentPoint.x)")
            startPoint.x = 0
            calculateSmileyCount(startPoint: currentPoint.x, endPoint: currentPoint.x)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(touches.count == 1)
        {
            let touch =    touches.first
            endPointPoint = (touch?.location(in: self))!
            //print("End Point \(endPointPoint.x)")
            
             calculateSmileyCount(startPoint: startPoint.x, endPoint: endPointPoint.x)
           
            
        }
    }
    
    
    
    private func calculateSmileyCount(startPoint:CGFloat,endPoint:CGFloat)
    {
        //manually add condition, if rating is greater than 5.
        
        if startPoint < 15.0 && endPoint < 15.0
        {
            self.attributedText = fillRating(fillValue: 0)
            finalRating = 0
        }
        else if startPoint < 37.0 && endPoint < 37.0
        {
            self.attributedText = fillRating(fillValue: 1)
            finalRating = 1
            
        }else if startPoint < 66.0 && endPoint < 66.0
        {
             self.attributedText = fillRating(fillValue: 2)
             finalRating = 2
            
        }else if startPoint < 95.0 && endPoint < 95.0
        {
            self.attributedText = fillRating(fillValue: 3)
            finalRating = 3
            
        }else if startPoint < 121.0 && endPoint < 121.0
        {
            self.attributedText = fillRating(fillValue: 4)
            finalRating = 4
            
        }else if startPoint < 130.0 && endPoint < 130.0
        {
            self.attributedText = fillRating(fillValue: 5)
            finalRating = 5
           
        }
        
        
    }
    
    

}

extension StarLabel
{
    func fillRating(fillValue:UInt) -> NSAttributedString
    {
        let glow = NSShadow()
        glow.shadowBlurRadius = glowBlurRadius
        glow.shadowOffset = glowShadowOffSet
        glow.shadowColor = glowColor
        
        let active = [NSForegroundColorAttributeName:fillColor,NSFontAttributeName:self.font,NSShadowAttributeName:glow] as [String : Any]
        
        let inactice = [NSFontAttributeName:self.font,NSForegroundColorAttributeName:emptyColor] as [String : Any]
        
        let attriString:NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        for _ in 0..<fillValue
        {
            attriString.append(NSAttributedString(string: postSymbol, attributes: active))
        }
        
        for _ in 0..<(symbolCount - fillValue)
        {
            attriString.append(NSAttributedString(string: preSymbol, attributes: inactice))
        }
        
        return attriString
        
    }
}

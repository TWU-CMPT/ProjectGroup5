//
// AnimatedSquareViewController.swift - View Controller for the animated square, contained in the Square Breathing feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Berke Boz
// Contributing Programmers:
// Known issues:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import Foundation
import UIKit


// Square Object (Contained by the main Square Breathing screen view controller)

class Draw: UIView {
    // Square visual code:
    //********************
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Draw the square on screen
    // Note: This is a visual UI element that must be checked manually
    override func draw(_ rect: CGRect)
    {
        self.backgroundColor = UIColor .clear           //Make backgound
        //Initialize Lines and Rectangles
        let lineLeft = UIGraphicsGetCurrentContext()
        let lineRight = UIGraphicsGetCurrentContext()
        let lineTop = UIGraphicsGetCurrentContext()
        let lineBot = UIGraphicsGetCurrentContext()
        let circleTopLeft = UIGraphicsGetCurrentContext()
        let circleTopRight = UIGraphicsGetCurrentContext()
        let circleBotLeft = UIGraphicsGetCurrentContext()
        let circleBotRight = UIGraphicsGetCurrentContext()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()  //Set color
        let components: [CGFloat] = [0.0, 0.0, 1.0, 1.0]//Set color
        let color = CGColor(colorSpace: colorSpace, components: components)
        
        lineLeft?.setLineWidth(4.0)                     //Adjust line width
        lineLeft?.setStrokeColor(color!)    //Set color
        lineLeft?.move(to: CGPoint(x: 40, y: 190))  //Move to coordinates
        lineLeft?.addLine(to: CGPoint(x: 40, y: 85))//Add line to given coordinates
        lineLeft?.strokePath()
        
        lineRight?.setLineWidth(4.0)//Adjust line width
        lineRight?.setStrokeColor(color!)//Set color
        lineRight?.move(to: CGPoint(x: 180, y: 190))
        lineRight?.addLine(to: CGPoint(x: 180, y: 85))  //Move to coordinates
        lineRight?.strokePath()//Add line to given coordinates
        
        lineTop?.setLineWidth(4.0)//Adjust line width
        lineTop?.setStrokeColor(color!)//Set color
        lineTop?.move(to: CGPoint(x: 67, y: 65))
        lineTop?.addLine(to: CGPoint(x: 150, y: 65))  //Move to coordinates
        lineTop?.strokePath()//Add line to given coordinates
        
        lineBot?.setLineWidth(4.0)//Adjust line width
        lineBot?.setStrokeColor(color!)//Set color
        lineBot?.move(to: CGPoint(x: 67, y: 205))
        lineBot?.addLine(to: CGPoint(x: 154, y: 205))  //Move to coordinates
        lineBot?.strokePath()//Add line to given coordinates
        
        circleTopLeft?.saveGState()
        circleTopLeft?.setLineWidth(4.0)//Adjust line width
        circleTopLeft?.setStrokeColor(UIColor.blue.cgColor)//Set color
        let rectangle = CGRect(x: 10,y: 25,width: 60,height: 60)//Set coordinates
        circleTopLeft?.addEllipse(in: rectangle)
        circleTopLeft?.strokePath()//Add line to given coordinates
        
        circleTopRight?.saveGState()
        circleTopRight?.setLineWidth(4.0)//Adjust line width
        circleTopRight?.setStrokeColor(UIColor.blue.cgColor)//Set color
        let rectangle2 = CGRect(x: 150,y: 25,width: 60,height: 60)//Set coordinates
        circleTopRight?.addEllipse(in: rectangle2)
        circleTopRight?.strokePath()//Add line to given coordinates
        
        circleBotLeft?.saveGState()
        circleBotLeft?.setLineWidth(4.0)//Adjust line width
        circleBotLeft?.setStrokeColor(UIColor.blue.cgColor)//Set color
        let rectangle3 = CGRect(x: 10,y: 190,width: 60,height: 60)//Set coordinates
        circleBotLeft?.addEllipse(in: rectangle3)
        circleBotLeft?.strokePath()//Add line to given coordinates
        
        circleBotRight?.saveGState()
        circleBotRight?.setLineWidth(4.0)//Adjust line width
        circleBotRight?.setStrokeColor(UIColor.blue.cgColor)//Set color
        let rectangle4 = CGRect(x: 150,y: 190,width: 60,height: 60)//Set coordinates
        circleBotRight?.addEllipse(in: rectangle4)
        circleBotRight?.strokePath()//Add line to given coordinates
    }
}

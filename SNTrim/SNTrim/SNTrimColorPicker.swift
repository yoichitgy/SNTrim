//
//  SNTrimColorPicker.swift
//  SNTrim
//
//  Created by satoshi on 9/13/16.
//  Copyright © 2016 Satoshi Nakajima. All rights reserved.
//

import UIKit

class SNTrimColorPicker: UIViewController {
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var colorView:UIView!
    var image:UIImage!
    var color:UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        colorView.backgroundColor = color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func done() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func handleTap(recognizer:UITapGestureRecognizer) {
        print("handleTap")
        let size = image.size
        let pt = recognizer.locationInView(imageView)
        let data = NSMutableData(length: 4)!
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(data.mutableBytes, 1, 1, 8, 4, CGColorSpaceCreateDeviceRGB(), bitmapInfo.rawValue)
        CGContextDrawImage(context, CGRect(origin:CGPoint(x:-pt.x, y:-pt.y), size:size), image.CGImage)
        let bytes = UnsafePointer<UInt8>(data.bytes)
        print("colors", bytes[0], bytes[1], bytes[2], bytes[3])
        color = UIColor(red: CGFloat(bytes[0]) / 255, green: CGFloat(bytes[1]) / 255, blue: CGFloat(bytes[2]) / 255, alpha: 1.0)
        colorView.backgroundColor = color
    }
}

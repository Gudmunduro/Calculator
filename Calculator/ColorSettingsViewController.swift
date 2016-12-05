//
//  ColorSettingsViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 1/16/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

class ColorSettingsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var TitleBar: UILabel!
    var buttons: [UIButton] = [], ButtonY: CGFloat = 38, buttonColors: [UIColor] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.width += 58;
        AddColor("Red", color: .redColor())
        AddColor("Lime Green", color: .greenColor())
        AddColor("Blue", color: view.tintColor)
        AddColor("Orange", color: .orangeColor())
        AddColor("Yellow", color: .yellowColor())
        AddColor("Green", color: UIColor(red: 0.375, green: 0.81, blue: 0.0, alpha: 1.0))
        AddColor("Dodger Blue", color: UIColor(red: 0.117, green: 0.564, blue: 1.0, alpha: 1.0))
        AddColor("Orange Red", color: UIColor(red: 1.0, green: 0.27, blue: 0, alpha: 1.0))
        AddColor("Spring Green", color: UIColor(red: 0, green: 1.0, blue: 0.498, alpha: 1.0))
        AddColor("Dark Red", color: UIColor(red: 0.545, green: 0, blue: 0, alpha: 1.0))
        AddColor("Deep Pink", color: UIColor(red: 1.0, green: 0.07, blue: 0.576, alpha: 1.0))
        AddColor("Deep Sky Blue", color: UIColor(red: 0, green: 0.749, blue: 1.0, alpha: 1.0))
        AddColor("Light blue", color: UIColor(red: 0.34, green: 0.53, blue: 0.98, alpha: 1.0))
        AddColor("Purple", color: UIColor(red: 0.74, green: 0.0, blue: 1.0, alpha: 1.0))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ColorChangeButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        ButtonColor = buttonColors[GetButtonColorIndex(sender as! UIButton)]
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.BeginFromCurrentState, .AllowUserInteraction, .CurveLinear], animations:
            {
                self.TitleBar.layer.backgroundColor = ButtonColor.CGColor;
            }, completion: nil)
        for b in buttons
        {
            UIView.animateWithDuration(0.5, delay: 0.0, options: [.BeginFromCurrentState, .AllowUserInteraction, .CurveLinear], animations: { b.backgroundColor = ButtonColor; }, completion: nil)
        }
        print(GetButtonColorIndex(sender as! UIButton))
        let button = sender as! UIButton
        SaveColorToPlist((button.titleLabel?.text)!)
    }
    func SaveColorToPlist(color: String)
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = paths + "/" + "Settings.plist"
       // let fileManager = NSFileManager.defaultManager()
        let data : NSMutableDictionary = NSMutableDictionary(contentsOfFile: path)!
        data.setObject(color, forKey: "Color")
        data.writeToFile(path, atomically: false)
    }
    @IBAction func ButtonTouchDown(sender: AnyObject) {
        let button = sender as! UIButton
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { button.alpha = 0.7 }, completion: nil)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        TitleBar.backgroundColor = UIColor.clearColor();
        TitleBar.layer.backgroundColor = ButtonColor.CGColor;
        scrollView.backgroundColor = BackroundColor;
    }
    
    func AnimateButton(button: UIButton)
    {
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { button.alpha = 1.0 }, completion: nil)
    }
    
    func AddColor(text: String, color: UIColor)
    {
        let button = UIButton(type: .System)
        button.frame = CGRectMake(0, ButtonY, 320, 40)
        button.setTitle(" " + text, forState: .Normal)
        button.backgroundColor = ButtonColor
        button.tintColor = UIColor.whiteColor()
        button.titleLabel!.font = UIFont.systemFontOfSize(20.0)
        button.contentHorizontalAlignment = .Left
        scrollView.addSubview(button)
        buttons.insert(button, atIndex: GetButtonColorIndex(button))
        buttonColors.insert(color, atIndex: GetButtonColorIndex(button))
        button.addTarget(self, action: "ColorChangeButtonPressed:", forControlEvents: .TouchUpInside)
        button.addTarget(self, action: "ButtonTouchDown:", forControlEvents: .TouchDown)
        button.addTarget(self, action: "ButtonTouchDraggedOutside:", forControlEvents: .TouchDragOutside)
        button.addTarget(self, action: "ButtonTouchDraggedOutside:", forControlEvents: .TouchUpInside)
        ButtonY += 41
        scrollView.contentSize.height += 45;
    }
    
    func GetButtonColorIndex(button: UIButton) -> Int
    {
        return Int((button.center.y - 58) / 41)
    }
    
    @IBAction func ButtonTouchDraggedOutside(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

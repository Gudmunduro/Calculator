//
//  CreatePresetViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 10/31/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

class CreatePresetViewController: UIViewController {

    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sStopButton: UIButton!
    @IBOutlet weak var sStartButton: UIButton!
    @IBOutlet weak var pxButton: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var piButton: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var pButton: UIButton!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var n0Button: UIButton!
    @IBOutlet weak var n1Button: UIButton!
    @IBOutlet weak var n2Button: UIButton!
    @IBOutlet weak var n3Button: UIButton!
    @IBOutlet weak var n4Button: UIButton!
    @IBOutlet weak var n5Button: UIButton!
    @IBOutlet weak var n6Button: UIButton!
    @IBOutlet weak var n7Button: UIButton!
    @IBOutlet weak var n8Button: UIButton!
    @IBOutlet weak var n9Button: UIButton!
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var sqrButton: UIButton!
    @IBOutlet weak var prButton: UIButton!
    @IBOutlet weak var pmButton: UIButton!
    @IBOutlet weak var ValueButton: UIButton!
    @IBOutlet weak var D2Button: UIButton!
    
    var presetCount: Int = 0, currentValueId = 1;
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "";
        presetCount = presets.count;
        presets.append(Preset())
        presets[presetCount].name = "Preset " + String(presetCount)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        titleBar.backgroundColor = ButtonColor;
        label.textColor = ButtonColor;
        D2Button.backgroundColor = ButtonColor;
        sStartButton.backgroundColor = ButtonColor;
        sStopButton.backgroundColor = ButtonColor;
        backButton.backgroundColor = ButtonColor;
        acButton.backgroundColor = ButtonColor;
        dButton.backgroundColor = ButtonColor;
        sButton.backgroundColor = ButtonColor;
        pButton.backgroundColor = ButtonColor;
        mButton.backgroundColor = ButtonColor;
        p2Button.backgroundColor = ButtonColor;
        pxButton.backgroundColor = ButtonColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Add(value: String)
    {
        presets[presetCount].values.append(value)
    }
    
    @IBAction func acButtonPressed(sender: AnyObject) {
        label.text = "";
        ScrollView.contentOffset.x = 0;
        ScrollView.contentSize.width = 0;
    }
    @IBAction func backButtonPressed(sender: AnyObject) {
        label.text = removeCharsFromString(label.text!, count: getPrintValue(getButtonForId(presets[presetCount].values[presets[presetCount].values.count])).characters.count)
        presets[presetCount].values.popLast()
        updateScrollviewWidth()
    }
    @IBAction func buttonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        label.text = label.text! + getPrintValue(sender as! UIButton)
        Add(getIdForButton(sender as! UIButton))
        updateScrollviewWidth()
    }
    @IBAction func CancelButtonPressed(sender: AnyObject) {
        presets.popLast()
        
        
    }
    
    @IBAction func valueButtonPressed(sender: AnyObject) {
        currentValueId++;
        ValueButton.setTitle("V" + String(currentValueId), forState: .Normal)
    }
    
    @IBAction func ButtonTouchDraggedOutside(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
    }
    @IBAction func ButtonTouchDown(sender: AnyObject) {
        let button = sender as! UIButton;
        UIView.animateWithDuration(0.1, delay: 0.0, options:[ .AllowUserInteraction, .BeginFromCurrentState], animations: { button.bounds.size = CGSize(width: sender.size.width-10, height: sender.size.height-10); }, completion: nil)
    }
    
    
    func getIdForButton(button: UIButton) -> String
    {
        switch (button)
        {
            case pxButton: return "powX";
            case p2Button: return "pow2";
            case piButton: return "pi";
            case mButton: return "minus";
            case pButton: return "plus";
            case sButton: return "tim";
            case dButton: return "div";
            case n0Button: return "n0";
            case n1Button: return "n1";
            case n2Button: return "n2";
            case n3Button: return "n3";
            case n4Button: return "n4";
            case n5Button: return "n5";
            case n6Button: return "n6";
            case n7Button: return "n7";
            case n8Button: return "n8";
            case n9Button: return "n9";
            case acButton: return "ac";
            case backButton: return "back";
            case sqrButton: return "sqr";
            case prButton: return "pr";
            case pmButton: return "plmi";
            case ValueButton: return "value";
            case D2Button: return "div2";
            default: return "error";
        }
    }
    func getButtonForId(id: String) -> UIButton
    {
        switch (id)
        {
        case "powX": return pxButton;
        case "pow2": return p2Button;
        case "pi": return piButton;
        case "minus": return mButton;
        case "plus": return sButton;
        case "tim": return dButton;
        case "div": return pxButton;
        case "n0": return n0Button;
        case "n1": return n1Button;
        case "n2": return n2Button;
        case "n3": return n3Button;
        case "n4": return n4Button;
        case "n5": return n5Button;
        case "n6": return n6Button;
        case "n7": return n7Button;
        case "n8": return n8Button;
        case "n9": return n9Button;
        case "ac": return acButton;
        case "back": return backButton;
        case "sqr": return sqrButton;
        case "pr": return prButton;
        case "plmi": return pmButton;
        case "value": return ValueButton;
        case "div2": return D2Button;
        default: return UIButton();
        }
    }
    func getPrintValue(button: UIButton) -> String
    {
        switch (button)
        {
            case D2Button: return "/";
            case pmButton: changePM(); return "";
            case sButton: return " x ";
            case pxButton: return "^";
            case p2Button: return "^2";
            case ValueButton: return "value" + String(currentValueId);
            case pButton: return " + ";
            case mButton: return " - ";
            case dButton: return " ÷ ";
            default: return (button.titleLabel?.text)!;
        }
    }
    func updateScrollviewWidth()
    {
        if (label.text?.characters.count < 15){ return; }
        ScrollView.contentSize.width = label.text!.sizeWithAttributes(([NSFontAttributeName: UIFont.systemFontOfSize(30.0)])).width + 60.0;
        ScrollView.contentOffset.x = ScrollView.contentSize.width - 300;
    }
    func changePM()
    {
        
    }
    func GetButtonDefaultSize(button: UIButton) -> CGSize
    {
        let DefaultButtonSize = CGSize(width: 63, height: 63), Default0ButtonSize = CGSize(width: 127, height: 63);
        switch (button)
        {
        case n0Button: return Default0ButtonSize;
        case n1Button: return DefaultButtonSize;
        case n2Button: return DefaultButtonSize;
        case n3Button: return DefaultButtonSize;
        case n4Button: return DefaultButtonSize;
        case n5Button: return DefaultButtonSize;
        case n6Button: return DefaultButtonSize;
        case n7Button: return DefaultButtonSize;
        case n8Button: return DefaultButtonSize;
        case n9Button: return DefaultButtonSize;
        case pButton: return DefaultButtonSize;
        case mButton: return DefaultButtonSize;
        case sButton: return DefaultButtonSize;
        case dButton: return DefaultButtonSize;
        case piButton: return DefaultButtonSize;
        case sqrButton: return DefaultButtonSize;
        case acButton: return DefaultButtonSize;
        default: return DefaultButtonSize;
        }
    }
    func AnimateButton(button: UIButton)
    {
        UIView.animateWithDuration(0.1, delay: 0.0, options: [ .AllowUserInteraction, .BeginFromCurrentState ], animations: { button.bounds.size = self.GetButtonDefaultSize(button); }, completion: nil)
    }
    func removeCharsFromString(var string: String, count: Int) ->String
    {
        for (var i = 0; i < count; i++)
        {
            string.removeAtIndex(string.endIndex.predecessor())
        }
        return string;
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
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

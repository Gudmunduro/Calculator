//
//  ViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 1/12/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

var ButtonColor: UIColor = UIColor(), DevMode: Bool = false, labelText: String = "", presets: [Preset] = [];

class ViewController: UIViewController {

    
    @IBOutlet weak var presetButton: UIButton!
    @IBOutlet weak var calcTimeButton: UIButton!
    @IBOutlet weak var addMemoryButton: UIButton!
    @IBOutlet weak var memoryScrollView: UIScrollView!
    @IBOutlet weak var memoryButton: UIButton!
    @IBOutlet weak var pmButton: UIButton!
    @IBOutlet weak var sqrButton: UIButton!
    @IBOutlet weak var sStopButton: UIButton!
    @IBOutlet weak var sStartButton: UIButton!
    @IBOutlet weak var prButton: UIButton!
    @IBOutlet weak var ansButton: UIButton!
    @IBOutlet weak var piButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var pButton: UIButton!
    @IBOutlet weak var CalcButton: UIButton!
    @IBOutlet weak var kButton: UIButton!
    @IBOutlet weak var n0Button: UIButton!
    @IBOutlet weak var n1Button: UIButton!
    @IBOutlet weak var n2Button: UIButton!
    @IBOutlet weak var n3Button: UIButton!
    @IBOutlet weak var n4Button: UIButton!
    @IBOutlet weak var n5Button: UIButton!
    @IBOutlet weak var n6Button: UIButton!
    @IBOutlet weak var n9Button: UIButton!
    @IBOutlet weak var n8Button: UIButton!
    @IBOutlet weak var n7Button: UIButton!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var pxButton: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var d2Button: UIButton!
    
    
    @IBOutlet weak var ScrollView: UIScrollView!
    var Nums: [String] = [], currentNum = 0, symbol: [String] = [], kUsed: Bool = false, piUsed = false, ans: String = "", CurrentMemorySVIndex: Int = 1, Memory: [String] = [], FirstTime = true, brackets: [[String]] = [], inBrackets = false, currentBIndex = 0, currentBNum = 0, bracketSymbol: [[String]] = [], presetMode = false, currentPresetValue = 0;
    let DefaultButtonSize = CGSize(width: 63, height: 63), Default0ButtonSize = CGSize(width: 127, height: 63), DefaultCalcButtonSize = CGSize(width: 63, height: 127);
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readPlist()
    }

    func AnimateButton(button: UIButton)
    {
        UIView.animateWithDuration(0.1, delay: 0.0, options: [ .AllowUserInteraction, .BeginFromCurrentState ], animations: { button.bounds.size = self.GetButtonDefaultSize(button); }, completion: nil)
    }
    @IBAction func ACButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        Nums.removeAll();
        symbol.removeAll();
        Label.text = "0";
        currentNum = 0;
        ScrollView.contentSize.width = 0;
        ScrollView.contentOffset.x = 0;
        currentBIndex = 0;
        currentBNum = 0;
        brackets.removeAll()
        bracketSymbol.removeAll()
        inBrackets = false
        kUsed = false;
        piUsed = false;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func isLastSymbol() -> Bool
    {
        if (Label.text == "0"){ return true; }
        if (Nums.count == 0 && !inBrackets){ return true; }
        if (getLastChar(Label.text!) == "("){ return true; }
        if (getLastChar(Label.text!) == " "){ return true; }
        if (getLastChar(Label.text!) == "^"){ return true; }
        if (getLastChar(Label.text!) == "/"){ return true; }
        return false;
    }
    func isLastPi() -> Bool
    {
        return (getLastChar(Label.text!) == "%" || getLastChar(Label.text!) == "π")
    }
    func Calculated() -> Bool
    {
        return !((Label.text?.rangeOfString("=")) == nil)
    }
    @IBAction func NumButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (Calculated()){ return; }
        if (getLastChar(Label.text!) == ")" || isLastPi() || piUsed){ symbolButtonPressed(sButton) }
        if (Label.text == "0"){ if (sender as! UIButton == n0Button){ return; }; Label.text! = ""; }
        var num = 0;
        switch (sender as! UIButton)
        {
        case n1Button: num = 1;
        case n2Button: num = 2;
        case n3Button: num = 3;
        case n4Button: num = 4;
        case n5Button: num = 5;
        case n6Button: num = 6;
        case n7Button: num = 7;
        case n8Button: num = 8;
        case n9Button: num = 9;
        case n0Button: num = 0;
        default: break;
        }
        Insert(String(num), Num: String(num))
    }
    @IBAction func kButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (kUsed || Calculated())
        {
            return;
        }
        if (piUsed || isLastPi())
        {
            symbolButtonPressed(sButton)
            NumButtonPressed(n0Button)
        }
        if (inBrackets)
        {
            if (Label.text == "0"){ Label.text = ""; }
            else if (getLastChar(Label.text!) == "√"){ Label.text = Label.text! + "0"; }
            if (brackets[currentBIndex].count <= currentBNum || brackets[currentBIndex].isEmpty){
                brackets[currentBIndex].insert("0.", atIndex: currentBNum);
                Label.text = Label.text! + "0,";
            }
            else if (brackets[currentBIndex][currentBNum] == ""){
                brackets[currentBIndex][currentBNum] = "0.";
                Label.text = Label.text! + "0,";
            }
            else {
                brackets[currentBIndex][currentBNum] = brackets[currentBIndex][currentBNum] + ".";
                Label.text = Label.text! + ",";
            }
            updateScrollviewWidth()
            kUsed = true;
            return;
        }
        if (Label.text == "0"){ Label.text = ""; }
        else if (getLastChar(Label.text!) == "√"){ Label.text = Label.text! + "0"; }
        if (Nums.count <= currentNum || Nums.isEmpty){
            Nums.insert("0.", atIndex: currentNum);
            Label.text = Label.text! + "0,";
        }
        else if (Nums[currentNum] == ""){
            Nums[currentNum] = "0.";
            Label.text = Label.text! + "0,";
        }
        else {
        Nums[currentNum] = Nums[currentNum] + ".";
        Label.text = Label.text! + ",";
        }
        updateScrollviewWidth()
        kUsed = true;
    }
    @IBAction func symbolButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (isLastSymbol() || Calculated() || getLastChar(Label.text!) == "√"){ return; }
        if (Label.text![(Label.text?.characters.count)! - 1] == ","){ Label.text = Label.text! + "0"; }
        if (getLastChar(Label.text!) == "^")
        {
            NumButtonPressed(n2Button)
        }
        var s: String;
        switch (sender as! UIButton)
        {
        case pButton: s = "+";
        case mButton: s = "-";
        case sButton: s = "*";
        case dButton: s = "/";
        default: return;
        }
        if (inBrackets)
        {
            bracketSymbol[currentBIndex].insert(s, atIndex: currentBNum);
            Label.text = Label.text! + " " + ConvertSymbolToDisplayChar(s) + " ";
            currentBNum++;
            updateScrollviewWidth()
            kUsed = false;
            piUsed = false;
            return;
        }
        symbol.insert(s, atIndex: currentNum);
        Label.text = Label.text! + " " + ConvertSymbolToDisplayChar(s) + " ";
        currentNum++;
        updateScrollviewWidth()
        kUsed = false;
        piUsed = false;
    }
    @IBAction func piButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (Calculated()){ return; }
        if (!isLastSymbol())
        {
            symbolButtonPressed(sButton)
        }
        if (Label.text == "0"){ Label.text = ""; }
        Insert("π", Num: "3.14159265359")
        updateScrollviewWidth()
        piUsed = true;
    }
    
    
    @IBAction func ansButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (ans == "" || Calculated()  || getLastChar(Label.text!) == "√"){ return; }
        if (!isLastSymbol()){
            symbolButtonPressed(sButton);
        }
        if (Label.text == "0"){ Label.text = ""; }
        Insert("Ans", Num: ans)
        piUsed = true;
        kUsed = false;
    }
    
    @IBAction func prButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (getLastChar(Label.text!) == ")"){ return; }
        if (!inBrackets){
            if (Nums.count < currentNum || Label.text == "0" || isLastSymbol() || isLastPi() || Calculated() || getLastChar(Label.text!) == "√"){ return; }
            if (Nums[currentNum] == "" || Nums[currentNum].containsString("/") || Nums[currentNum].containsString("^")){ return; }
        }
        else
        {
            if (brackets[currentBIndex].count < currentBNum || isLastSymbol()  || isLastPi() || Calculated() || getLastChar(Label.text!) == "√")
            {
                return;
            }
            if (brackets[currentBIndex][currentBNum] == "" || brackets[currentBIndex][currentBNum].containsString("/") || brackets[currentBIndex][currentBNum].containsString("^")){ return; }
        }
        if (Label.text![(Label.text?.characters.count)! - 1] == ","){ Label.text = Label.text! + "0"; }
        if (inBrackets)
        {
            var containssqrt = false;
            if (brackets[currentBIndex][currentBNum].containsString("√"))
            {
                brackets[currentBIndex][currentBNum] = brackets[currentBIndex][currentBNum].stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                containssqrt = true;
            }
            Label.text = Label.text! + "%";
            brackets[currentBIndex][currentBNum] = String(Double(brackets[currentBIndex][currentBNum])! / 100);
            updateScrollviewWidth()
            piUsed = true;
            if (containssqrt)
            {
                brackets[currentBIndex][currentBNum] = "√" + brackets[currentBIndex][currentBNum]
            }
            return;
        }
        var containssqrt = false;
        if (Nums[currentNum].containsString("√"))
        {
            Nums[currentNum] = Nums[currentNum].stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            containssqrt = true;
        }
        Label.text = Label.text! + "%";
        Nums[currentNum] = String(Double(Nums[currentNum])! / 100);
        updateScrollviewWidth()
        piUsed = true;
        if (containssqrt)
        {
            Nums[currentNum] = "√" + Nums[currentNum]
        }
    }
    
    @IBAction func pmButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        var containsPR = false;
        if (getLastChar(Label.text!) == "%")
        {
            bButtonPressed(bButton)
            containsPR = true;
        }
        if (Nums.count < currentNum || Label.text == "0" || piUsed || isLastSymbol() || Calculated() || getLastChar(Label.text!) == ")"){ return; }
        if (Nums.count == 0 && !inBrackets){ return; }
        if (inBrackets)
        {
            if (brackets[currentBIndex][currentBNum].containsString("√"))
            {
                return;
            }
            if (brackets[currentBIndex][currentBNum][0] == "-")
            {
                brackets[currentBIndex][currentBNum].removeAtIndex(brackets[currentBIndex][currentBNum].startIndex)
                Label.text =  removeCharsFromString(Label.text!, count: brackets[currentBIndex][currentBNum].characters.count + 1)
                Label.text = Label.text! + brackets[currentBIndex][currentBNum];
                Label.text = Label.text!.stringByReplacingOccurrencesOfString(".", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil)
                updateScrollviewWidth()
                if (containsPR)
                {
                    prButtonPressed(prButton)
                }
                return;
            }
            brackets[currentBIndex][currentBNum] = "-" + brackets[currentBIndex][currentBNum]
            Label.text =  removeCharsFromString(Label.text!, count: brackets[currentBIndex][currentBNum].characters.count - 1)
            Label.text = Label.text! + brackets[currentBIndex][currentBNum];
            Label.text = Label.text!.stringByReplacingOccurrencesOfString(".", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil)
            updateScrollviewWidth()
            if (containsPR)
            {
                prButtonPressed(prButton)
            }
            return;
        }
        if (Nums[currentNum].containsString("√"))
        {
            return;
        }
        if (Nums[currentNum][0] == "-")
        {
            Nums[currentNum].removeAtIndex(Nums[currentNum].startIndex);
            Label.text =  removeCharsFromString(Label.text!, count: Nums[currentNum].characters.count + 1)
            Label.text = Label.text! + Nums[currentNum];
            Label.text = Label.text!.stringByReplacingOccurrencesOfString(".", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil)
            updateScrollviewWidth()
            if (containsPR)
            {
                prButtonPressed(prButton)
            }
            return;
        }
        Nums[currentNum] = "-" + Nums[currentNum];
        Label.text =  removeCharsFromString(Label.text!, count: Nums[currentNum].characters.count - 1)
        Label.text = Label.text! + Nums[currentNum];
        Label.text = Label.text!.stringByReplacingOccurrencesOfString(".", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil)
        updateScrollviewWidth()
        if (containsPR)
        {
            prButtonPressed(prButton)
        }
    }
    @IBAction func sqrButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (getLastChar(Label.text!) == "√" || Calculated()){ return; }
        if (!isLastSymbol() || getLastChar(Label.text!) == ")"){ symbolButtonPressed(sButton); }
        if (Label.text == "0"){ Label.text = ""; }
        Insert("√", Num: "√")
    }
    @IBAction func sStartButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        if (Calculated() || inBrackets){ return; }
        if (!isLastSymbol()){ symbolButtonPressed(sButton); }
        if (Label.text == "0"){ Label.text = ""; }
        Label.text?.Append("(")
        inBrackets = true;
        brackets.insert([], atIndex: currentBIndex)
        bracketSymbol.insert([], atIndex: currentBIndex)
    }
    @IBAction func sStopButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        if (!inBrackets || Calculated()){ return; }
        if (getLastChar(Label.text!) == "(" || getLastChar(Label.text!) == "√"){ return; }
        if (getLastChar(Label.text!) == ","){ NumButtonPressed(n0Button); }
        if (getLastChar(Label.text!) == " "){ bButtonPressed(bButton) }
        if (getLastChar(Label.text!) == "^"){ NumButtonPressed(n2Button) }
        Label.text?.Append(")")
        inBrackets = false;
        currentBNum = 0;
        
        if (brackets[currentBIndex][0].containsString("/"))
        {
            brackets[currentBIndex][0] = divide(brackets[currentBIndex][0])
        }
        if (brackets[currentBIndex][0].containsString("^"))
        {
            brackets[currentBIndex][0] = getPowerOf(brackets[currentBIndex][0])
            
        }
        if (brackets[currentBIndex][0].containsString("√"))
        {
            brackets[currentBIndex][0] = brackets[currentBIndex][0].stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            brackets[currentBIndex][0] = String(sqrt(Double(brackets[currentBIndex][0])!))
        }
        if (brackets[currentBIndex][0].containsString(","))
        {
            brackets[currentBIndex][0] = brackets[currentBIndex][0].stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
        }
        var num4 = Double(brackets[currentBIndex][0])!;
        for (var i = 1; i < brackets[currentBIndex].count; i++)
        {
            if (brackets[currentBIndex][i].containsString("/"))
            {
                brackets[currentBIndex][i] = divide(brackets[currentBIndex][i])
            }
            if (brackets[currentBIndex][i].containsString("^"))
            {
                brackets[currentBIndex][i] = getPowerOf(brackets[currentBIndex][i])
                
            }
            if (brackets[currentBIndex][i].containsString("√"))
            {
                brackets[currentBIndex][i] = brackets[currentBIndex][i].stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                brackets[currentBIndex][i] = String(sqrt(Double(brackets[currentBIndex][i])!))
            }
            if (brackets[currentBIndex][i].containsString(","))
            {
                brackets[currentBIndex][i] = brackets[currentBIndex][i].stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
            }
            switch (bracketSymbol[currentBIndex][i - 1])
            {
            case "+": num4 += Double(brackets[currentBIndex][i])!;
            case "-": num4 -= Double(brackets[currentBIndex][i])!;
            case "*": num4 *= Double(brackets[currentBIndex][i])!;
            case "/": num4 /= Double(brackets[currentBIndex][i])!;
            default: break;
            }
        }
        currentBIndex++;
        Insert("", Num: String(num4))
    }
    @IBAction func calcTimeButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        if (!Calculated() || Label.text == "0 = 0" || ans == ""){ return; }
        Label.text = removeCharsFromString(Label.text!, count: ans.characters.count)
        let h = Int(Double(ans)!)
        var m = (Double(ans)! - Double(h))
        m = Double(removeCharsFromString(String(m), count: String(m).characters.count - 4))!
        let s = (Double(ans)! - Double(h) - m) / 100 * 60;
        m = m / 100 * 60;
        if ( Label.text?.containsString(":") == true)
        {
            let str = String(h) + ":" + String(Int(m * 100)) + ":" + String(s * 10000)
            let count = str.characters.count - 3
            Label.text = removeCharsFromString(Label.text!, count: count)
            if (getLastChar(Label.text!) == "=")
            {
                Label.text?.Append(" ")
            }
            if (Label.text?.containsString("=") == false)
            {
                Label.text?.Append("= ")
            }
            Label.text = Label.text! + ans
            Label.text = Label.text!.stringByReplacingOccurrencesOfString(".", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil)
            updateScrollviewWidth()
            return;
        }
        Label.text = Label.text! + String(h) + ":" + String(Int(m * 100)) + ":" + String(s * 10000)
        updateScrollviewWidth()
    }
    @IBAction func pxButtonPressed(sender: UIButton) {
        AnimateButton(sender)
        if (Calculated() || isLastSymbol()){ return; }
        if (sender.titleLabel?.text == "x^2")
        {
            Insert("^2", Num: "^2")
            return;
        }
        Insert("^", Num: "^")
    }
    
    
    @IBAction func memoryButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        if (!memoryScrollView.hidden)
        {
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
                self.memoryButton.center.y = 216.5;
                self.sStartButton.center.y = 216.5;
                self.sStopButton.center.y = 216.5;
                self.SettingsButton.center.y = 216.5;
                self.calcTimeButton.center.y = 152.5;
                self.calcTimeButton.alpha = 1.0;
                self.pxButton.center.y = 152.5;
                self.pxButton.alpha = 1.0;
                self.p2Button.center.y = 152.5;
                self.p2Button.alpha = 1.0;
                self.d2Button.center.y = 152.5;
                self.d2Button.alpha = 1.0;
                self.presetButton.center.y = 152.5;
                self.presetButton.alpha = 1.0;
                
                self.memoryScrollView.center.y = 268.5;
                
                }, completion: { finished in self.memoryScrollView.hidden = true; })
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveLinear, animations: {
                self.memoryScrollView.alpha = 0;
                }, completion: nil)
            calcTimeButton.enabled = true
            return;
        }
        memoryScrollView.alpha = 0;
        memoryScrollView.hidden = false;
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
            self.memoryButton.center.y = 152.5;
            self.sStartButton.center.y = 152.5;
            self.sStopButton.center.y = 152.5;
            self.SettingsButton.center.y = 152.5;
            self.calcTimeButton.center.y = 88.5;
            self.calcTimeButton.alpha = 0.6;
            self.pxButton.center.y = 88.5;
            self.pxButton.alpha = 0.6;
            self.p2Button.center.y = 88.5;
            self.p2Button.alpha = 0.6;
            self.d2Button.center.y = 88.5;
            self.d2Button.alpha = 0.6;
            self.presetButton.center.y = 88.5;
            self.presetButton.alpha = 0.6;
            
            self.memoryScrollView.center.y = 216.5;
            }, completion: nil)
        UIView.animateWithDuration(0.1, delay: 0.2, options: .CurveLinear, animations: {
            self.memoryScrollView.alpha = 1;
            }, completion: nil)
        calcTimeButton.enabled = false
    }
    @IBAction func addMemoryButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        
    }
    func AddMemoryScrollViewButton()
    {
        let button = UIButton(type: .System);
        button.frame = CGRectMake(CGFloat(CurrentMemorySVIndex * 64), 0, 63, 63)
        button.tintColor = UIColor.blackColor()
        button.backgroundColor = UIColor.whiteColor();
        button.setTitle(String(CurrentMemorySVIndex), forState: .Normal)
        button.addTarget(self, action: "ButtonTouchDown:", forControlEvents: .TouchDown)
        button.addTarget(self, action: "memoryButtonUp:", forControlEvents: .TouchUpInside)
        button.addTarget(self, action: "ButtonTouchDraggedOutside:", forControlEvents: .TouchDragOutside)
        memoryScrollView.addSubview(button)
        if (CurrentMemorySVIndex == 5)
        {
            memoryScrollView.delaysContentTouches = true
            memoryScrollView.canCancelContentTouches = true
        }
        CurrentMemorySVIndex++;
    }
    @IBAction func d2ButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        if (Calculated() || isLastSymbol()){ return; }
        Insert("/", Num: "/")
    }
    func memoryButtonUp(sender: UIButton)
    {
        AnimateButton(sender)
        if (Calculated()  || getLastChar(Label.text!) == "√"){ return; }
        if (!isLastSymbol()){
            symbolButtonPressed(sButton);
        }
        if (Label.text == "0"){ Label.text = ""; }
        Insert(Memory[Int((sender.titleLabel?.text)!)! - 1], Num: Memory[Int((sender.titleLabel?.text)!)! - 1])
        if (Memory[Int((sender.titleLabel?.text)!)! - 1].containsString(",") || Memory[Int((sender.titleLabel?.text)!)! - 1].containsString("."))
        {
            kUsed = true;
        }
    }
    @IBAction func presetButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        if (presetMode)
        {
            presetMode = false;
            CalcButton.setTitle("=", forState: .Normal)
            Preset.selected = -1;
        }
    }
    func addFromPresets()
    {
        for (var i = currentPresetValue; i < presets[0].values.count; i++)
        {
            switch (presets[0].values[i])
            {
            case "powX": pxButtonPressed(pxButton)
            case "pow2": pxButtonPressed(p2Button)
            case "pi": piButtonPressed(piButton)
            case "minus": symbolButtonPressed(mButton)
            case "plus": symbolButtonPressed(pButton)
            case "tim": symbolButtonPressed(sButton)
            case "div": symbolButtonPressed(dButton)
            case "n0": NumButtonPressed(n0Button)
            case "n1": NumButtonPressed(n1Button)
            case "n2": NumButtonPressed(n2Button)
            case "n3": NumButtonPressed(n3Button)
            case "n4": NumButtonPressed(n4Button)
            case "n5": NumButtonPressed(n5Button)
            case "n6": NumButtonPressed(n6Button)
            case "n7": NumButtonPressed(n7Button)
            case "n8": NumButtonPressed(n8Button)
            case "n9": NumButtonPressed(n9Button)
            case "ac": ACButtonPressed(acButton)
            case "back": bButtonPressed(bButton)
            case "sqr": sqrButtonPressed(sqrButton)
            case "pr": prButtonPressed(prButton)
            case "plmi": pmButtonPressed(pmButton)
            case "value": print("value!"); currentPresetValue = i + 1; return;
            case "div2": d2ButtonPressed(d2Button);
            default: break;
            }
        }
        print("finished")
        presetMode = false;
        Calculate(CalcButton)
        currentPresetValue = 0;
        presetMode = true;
    }
    @IBAction func bButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (Label.text == "0" || Calculated()){ return; }
        if (Label.text?.characters.count == 1 || Label.text == "Ans"){
            if (Label.text! == "π" || Label.text == "Ans"){ piUsed = false; }
            if (Label.text == "(")
            {
                brackets[currentBIndex].removeAll()
                bracketSymbol[currentBIndex].removeAll()
                inBrackets = false;
            }
            Label.text = "0";
            Nums.removeAll()
            updateScrollviewWidth()
            return;
        }
        if (getLastChar(Label.text!) == " ")
        {
            Label.text = removeCharsFromString(Label.text!, count: 3);
            if (inBrackets)
            {
                bracketSymbol[currentBIndex][currentBNum-1].removeAll();
                currentBNum--;
                updateScrollviewWidth()
                if (brackets[currentBIndex][currentBNum].containsString(".") || brackets[currentBIndex][currentBNum].containsString(","))
                {
                    kUsed = true;
                }
                return;
            }
            symbol[currentNum-1].removeAll();
            currentNum--;
            updateScrollviewWidth()
            if (Nums[currentNum].containsString(".") || Nums[currentNum].containsString(","))
            {
                kUsed = true;
            }
            return;
        }
        if (getLastChar(Label.text!) == "%")
        {
            Label.text = removeCharsFromString(Label.text!, count: 1);
            var contaninsSqrt = false;
            if (inBrackets)
            {
                if (brackets[currentBIndex][currentBNum].containsString("√"))
                {
                    brackets[currentBIndex][currentBNum] = brackets[currentBIndex][currentBNum].stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    contaninsSqrt = true;
                }
                brackets[currentBIndex][currentBNum] = String(Double(brackets[currentBIndex][currentBNum])! * 100 )
                if (getLastChar(brackets[currentBIndex][currentBNum]) == "0" && brackets[currentBIndex][currentBNum][brackets[currentBIndex][currentBNum].characters.count - 2] == ".")
                {
                    brackets[currentBIndex][currentBNum] = removeCharsFromString(brackets[currentBIndex][currentBNum], count: 2);
                }
                piUsed = false;
                updateScrollviewWidth()
                if (contaninsSqrt)
                {
                    brackets[currentBIndex][currentBNum] = "√" + brackets[currentBIndex][currentBNum]
                }
                return;
            }
            if (Nums[currentNum].containsString("√"))
            {
                Nums[currentNum] = Nums[currentNum].stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                contaninsSqrt = true;
            }
            Nums[currentNum] = String(Double(Nums[currentNum])! * 100 )
            if (getLastChar(Nums[currentNum]) == "0" && Nums[currentNum][Nums[currentNum].characters.count - 2] == ".")
            {
                Nums[currentNum] = removeCharsFromString(Nums[currentNum], count: 2);
            }
            piUsed = false;
            updateScrollviewWidth()
            if (contaninsSqrt)
            {
                Nums[currentNum] = "√" + Nums[currentNum]
            }
            return;
        }
        if (getLastChar(Label.text!) == "π")
        {
            Label.text = removeCharsFromString(Label.text!, count: 1);
            if (inBrackets)
            {
                brackets[currentBIndex][currentBNum].removeAll()
                piUsed = false;
                updateScrollviewWidth()
                return;
            }
            Nums[currentNum].removeAll();
            piUsed = false;
            updateScrollviewWidth()
            return;
        }
        if (getLastChar(Label.text!) == "(")
        {
            Label.text = removeCharsFromString(Label.text!, count: 1)
            brackets[currentBIndex].removeAll()
            bracketSymbol[currentBIndex].removeAll()
            inBrackets = false;
            return;
        }
        if (getLastChar(Label.text!) == ")")
        {
            Label.text = removeCharsFromString(Label.text!, count: 1)
            currentBIndex--;
            currentBNum = brackets[currentBIndex].count - 1
            inBrackets = true;
            Nums[currentNum].removeAll()
            return;
        }
        if (!inBrackets)
        {
        if (Nums[currentNum] == ans)
        {
            Label.text = removeCharsFromString(Label.text!, count: 3);
            Nums[currentNum] = "";
            piUsed = false;
            updateScrollviewWidth()
            return;
        }
        if (Nums[currentNum] == "√")
        {
            Label.text = removeCharsFromString(Label.text!, count: 1);
            Nums[currentNum] = removeCharsFromString(Nums[currentNum], count: 1)
            updateScrollviewWidth()
            return;
        }
        }
        else
        {
            if (brackets[currentBIndex][currentBNum] == ans && ans != "")
            {
                Label.text = removeCharsFromString(Label.text!, count: 3);
                brackets[currentBIndex][currentBNum] = "";
                piUsed = false;
                updateScrollviewWidth()
                return;
            }
            if (brackets[currentBIndex][currentBNum] == "√")
            {
                Label.text = removeCharsFromString(Label.text!, count: 1);
                brackets[currentBIndex][currentBNum] = removeCharsFromString(brackets[currentBIndex][currentBNum], count: 1)
                updateScrollviewWidth()
                return;
            }
        }
        if (Label.text![(Label.text?.characters.count)! - 1] == ",")
        {
            Label.text?.removeAtIndex(Label.text!.endIndex.predecessor())
            if (inBrackets)
            {
                brackets[currentBIndex][currentBNum].removeAtIndex(brackets[currentBIndex][currentBNum].endIndex.predecessor())
                updateScrollviewWidth()
                kUsed = false;
                return;
            }
            Nums[currentNum].removeAtIndex(Nums[currentNum].endIndex.predecessor())
            updateScrollviewWidth()
            kUsed = false;
            return;
        }
        
        Label.text?.removeAtIndex(Label.text!.endIndex.predecessor())
        updateScrollviewWidth()
        if (inBrackets)
        {
            brackets[currentBIndex][currentBNum].removeAtIndex(brackets[currentBIndex][currentBNum].endIndex.predecessor())
            return;
        }
        Nums[currentNum].removeAtIndex(Nums[currentNum].endIndex.predecessor())
    }
    @IBAction func Calculate(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
        if (presetMode)
        {
            addFromPresets()
            return;
        }
        if (Label.text == "0"){ Label.text = "0 = 0"; return; }
        if (Calculated() || getLastChar(Label.text!) == "√"){ return; }
        if (getLastChar(Label.text!) == "^")
        {
            NumButtonPressed(n2Button)
        }
        if (isLastSymbol())
        {
            bButtonPressed(bButton)
        }
        if (getLastChar(Label.text!) == ",")
        {
            NumButtonPressed(n0Button)
        }
        if (inBrackets)
        {
            sStopButtonPressed(sStopButton)
        }
        
        if (Nums[0].containsString("/"))
        {
            Nums[0] = divide(Nums[0])
        }
        if (Nums[0].containsString("^"))
        {
            Nums[0] = getPowerOf(Nums[0])
            
        }
        if (Nums[0].containsString(","))
        {
            Nums[0] = Nums[0].stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
        }
        if (Nums[0].containsString("√"))
        {
            Nums[0] = Nums[0].stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            Nums[0] = String(sqrt(Double(Nums[0])!))
        }
        var num4 = Double(Nums[0])!;
        for (var i = 1; i < Nums.count; i++)
        {
            if (Nums[i].containsString("/"))
            {
                Nums[i] = divide(Nums[i])
            }
            if (Nums[i].containsString("^"))
            {
                Nums[i] = getPowerOf(Nums[i])
                
            }
            if (Nums[i].containsString("√"))
            {
                 Nums[i] = Nums[i].stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                Nums[i] = String(sqrt(Double(Nums[i])!))
            }
            if (Nums[i].containsString(","))
            {
                Nums[i] = Nums[i].stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)

            }
            switch (symbol[i - 1])
            {
            case "+": num4 += Double(Nums[i])!;
            case "-": num4 -= Double(Nums[i])!;
            case "*": num4 *= Double(Nums[i])!;
            case "/": num4 /= Double(Nums[i])!;
            default: break;
            }
        }
        ans = String(num4);
        if (ans == "nan")
        {
            Label.text?.Append(" = error")
            ans = "";
            return;
        }
        if (getLastChar(ans) == "0" && ans.containsString(".") == true)
        {
            ans = ans.substringToIndex(ans.endIndex.advancedBy(-2))
        }
        Label.text = Label.text!+" = "+ans;
        Label.text = Label.text!.stringByReplacingOccurrencesOfString(".", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil)
        updateScrollviewWidth()
    }
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if (FirstTime)
        {
            UIView.transitionWithView(Label, duration: 1.0, options: .TransitionCrossDissolve, animations: { self.Label.textColor = ButtonColor; }, completion: nil)
            UIView.animateWithDuration(1.0, delay: 0.1, options: .CurveLinear, animations:
                {
                    self.CalcButton.backgroundColor = ButtonColor;
                    self.pButton.backgroundColor = ButtonColor;
                    self.mButton.backgroundColor = ButtonColor;
                    self.sButton.backgroundColor = ButtonColor;
                    self.dButton.backgroundColor = ButtonColor;
                    self.acButton.backgroundColor = ButtonColor;
                    self.SettingsButton.backgroundColor = ButtonColor;
                    self.sStartButton.backgroundColor = ButtonColor;
                    self.sStopButton.backgroundColor = ButtonColor;
                    self.bButton.backgroundColor = ButtonColor;
                    self.memoryButton.backgroundColor = ButtonColor;
                    self.addMemoryButton.backgroundColor = ButtonColor;
                    self.calcTimeButton.backgroundColor = ButtonColor;
                    self.pxButton.backgroundColor = ButtonColor;
                    self.p2Button.backgroundColor = ButtonColor;
                    self.d2Button.backgroundColor = ButtonColor;
                    self.presetButton.backgroundColor = ButtonColor;
                }, completion: nil)
            FirstTime = false;
            return;
        }
        CalcButton.backgroundColor = ButtonColor;
        pButton.backgroundColor = ButtonColor;
        mButton.backgroundColor = ButtonColor;
        sButton.backgroundColor = ButtonColor;
        dButton.backgroundColor = ButtonColor;
        acButton.backgroundColor = ButtonColor;
        SettingsButton.backgroundColor = ButtonColor;
        sStartButton.backgroundColor = ButtonColor;
        sStopButton.backgroundColor = ButtonColor;
        bButton.backgroundColor = ButtonColor;
        Label.textColor = ButtonColor;
        memoryButton.backgroundColor = ButtonColor;
        addMemoryButton.backgroundColor = ButtonColor;
        calcTimeButton.backgroundColor = ButtonColor;
        pxButton.backgroundColor = ButtonColor;
        p2Button.backgroundColor = ButtonColor;
        d2Button.backgroundColor = ButtonColor;
        presetButton.backgroundColor = ButtonColor;
        view.backgroundColor = BackroundColor;
        
        if (CurrentMemory != "")
        {
            Memory.insert(CurrentMemory, atIndex: CurrentMemorySVIndex - 1);
            AddMemoryScrollViewButton();
            CurrentMemory = "";
            updateMemoryScrollviewWidth()
        }
        
        if (Preset.selected != -1)
        {
            presetMode = true;
            CalcButton.setTitle("N", forState: .Normal)
            currentPresetValue = 0;
        }
        
        }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        //DefaultButtonSize = n1Button.bounds.size;
        //Default0ButtonSize = n0Button.bounds.size;
        //DefaultCalcButtonSize = CalcButton.bounds.size;
    }
    
    @IBAction func SettingsButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
    }
    @IBAction func ButtonTouchDown(sender: AnyObject) {
        let button = sender as! UIButton;
        UIView.animateWithDuration(0.1, delay: 0.0, options:[ .AllowUserInteraction, .BeginFromCurrentState], animations: { button.bounds.size = CGSize(width: sender.size.width-10, height: sender.size.height-10); }, completion: nil)
    }
    @IBAction func ButtonTouchDraggedOutside(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
    }
    
    func GetButtonDefaultSize(button: UIButton) -> CGSize
    {
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
        case kButton: return DefaultButtonSize;
        case bButton: return DefaultButtonSize;
        case piButton: return DefaultButtonSize;
        case sqrButton: return DefaultButtonSize;
        case CalcButton: return DefaultCalcButtonSize;
        case acButton: return DefaultButtonSize;
        case SettingsButton: return Default0ButtonSize;
        case ansButton: return DefaultButtonSize;
        default: return DefaultButtonSize;
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false;
    }
    
    func Insert(labelText: String, Num: String)
    {
        if (inBrackets)
        {
            if (currentBNum < brackets[currentBIndex].count)
            {
                let num2 = brackets[currentBIndex][currentBNum]
                brackets[currentBIndex][currentBNum] = num2+Num;
                Label.text = Label.text!+labelText;
                updateScrollviewWidth()
                return;
            }
            brackets[currentBIndex].insert(Num, atIndex: currentBNum)
            Label.text = Label.text!+labelText;
            updateScrollviewWidth()
            return;
        }
        if (Nums.count > currentNum) {
            let num2 = Nums[currentNum];
            Nums[currentNum] = num2+Num;
            Label.text = Label.text!+labelText;
            updateScrollviewWidth()
            return;
        }
        Nums.insert(Num, atIndex: currentNum);
        Label.text = Label.text!+labelText;
        updateScrollviewWidth()
    }
    
    func ConvertSymbolToDisplayChar(symbol: String) -> String
    {
        switch (symbol)
        {
            case "+": return "+";
            case "-": return "-";
            case "*": return "x";
            case "/": return "÷";
            default: return "error";
        }
    }
    
    func removeCharsFromString(var string: String, count: Int) ->String
    {
        for (var i = 0; i < count; i++)
        {
            string.removeAtIndex(string.endIndex.predecessor())
        }
        return string;
    }
    
    func getLastChar(string: String) -> Character
    {
        return string[(string.endIndex.predecessor())];
    }
    
    func ConvertToPRString(n: Double) -> String
    {
        var tmp = n * 100;
        if (getLastChar(String(n)) == "0")
        {
            return String(Int(n)) + "%";
        }
        return String(n).stringByReplacingOccurrencesOfString(".", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil) + "%"
    }
    
    func updateScrollviewWidth()
    {
        if (Label.text?.characters.count < 15){ return; }
        ScrollView.contentSize.width = Label.text!.sizeWithAttributes(([NSFontAttributeName: UIFont.systemFontOfSize(30.0)])).width + 60.0;
        ScrollView.contentOffset.x = ScrollView.contentSize.width - 300;
    }
    func updateMemoryScrollviewWidth()
    {
        if (CurrentMemorySVIndex < 5){ return; }
        memoryScrollView.contentSize.width = CGFloat(CurrentMemorySVIndex * 64);
        //memoryScrollView.contentOffset.x = CGFloat(CurrentMemorySVIndex * 64) - 300;
    }
    func getPowerOf(of: String) -> String
    {
        var num = of.substringToIndex(of.rangeOfString("^")!.startIndex)
        print(num)
        let p = of.substringFromIndex(of.rangeOfString("^")!.endIndex)
        print(p)
        if (num.containsString(","))
        {
            num = num.stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
        if (num.containsString("√"))
        {
            num = num.stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            num = String(sqrt(Double(num)!))
        }
        return String(pow(Double(num)!, Double(p)!))
    }
    func divide(n: String) -> String
    {
        var num = n.substringToIndex(n.rangeOfString("/")!.startIndex)
        print(num)
        var num2 = n.substringFromIndex(n.rangeOfString("/")!.endIndex)
        print(num2)
        
        if (num.containsString(","))
        {
            num = num.stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
        if (num.containsString("√"))
        {
            num = num.stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            num = String(sqrt(Double(num)!))
        }
        if (num.containsString("^"))
        {
            num = getPowerOf(num)
            
        }
        
        if (num2.containsString(","))
        {
            num2 = num2.stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
        if (num2.containsString("√"))
        {
            num2 = num2.stringByReplacingOccurrencesOfString("√", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            num2 = String(sqrt(Double(num2)!))
        }
        if (num2.containsString("^"))
        {
            num2 = getPowerOf(num2)
            
        }
        
        return String(Double(num)!/Double(num2)!)
    }

    func readPlist()
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! String
        let path = documentsDirectory + "/" + "Settings.plist"
        
        let fileManager = NSFileManager.defaultManager()
        
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            print("File foesn't exist")
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("Settings", ofType: "plist") {
                try! fileManager.copyItemAtPath(bundlePath, toPath: path);
            }
        else {
            // use this to delete file from documents directory
            try! fileManager.removeItemAtPath(path)
    }
        }
        
        let myDict = NSDictionary(contentsOfFile: path)
        
        if let dict = myDict {
            //loading values
            ButtonColor = GetColorForString(dict.objectForKey("Color") as! String);
            //...
        } else {
            ButtonColor = view.tintColor;
        }
    }
    
    func GetColorForString(str: String) -> UIColor
    {
        switch (str)
        {
        case " Red": return UIColor.redColor();
            case " Lime Green": return UIColor.greenColor();
            case " Blue": return view.tintColor
            case " Orange": return UIColor.orangeColor();
            case " Yellow": return UIColor.yellowColor();
            case " Green": return UIColor(red: 0.375, green: 0.81, blue: 0.0, alpha: 1.0);
            case " Dodger Blue": return UIColor(red: 0.117, green: 0.564, blue: 1.0, alpha: 1.0);
            case " Orange Red": return UIColor(red: 1.0, green: 0.27, blue: 0, alpha: 1.0);
            case " Spring Green": return UIColor(red: 0, green: 1.0, blue: 0.498, alpha: 1.0);
            case " Dark Red": return UIColor(red: 0.545, green: 0, blue: 0, alpha: 1.0);
            case " Deep Pink": return UIColor(red: 1.0, green: 0.07, blue: 0.576, alpha: 1.0);
            case " Deep Sky Blue": return UIColor(red: 0, green: 0.749, blue: 1.0, alpha: 1.0);
            case " Light blue": return UIColor(red: 0.34, green: 0.53, blue: 0.98, alpha: 1.0);
            case " Purple": return UIColor(red: 0.74, green: 0.0, blue: 1.0, alpha: 1.0);
        default: print(str); return view.tintColor;
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender);
        labelText = Label.text!;
        }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

}

extension String{
    subscript (i: Int) -> Character
    {
        return self[self.startIndex.advancedBy(i)]
    }
    mutating func Append(with: String)
    {
        self = self + with;
    }
}


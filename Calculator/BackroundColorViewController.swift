//
//  BackroundColorViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 2/6/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

var BackroundColor = UIColor.blackColor()

class BackroundColorViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var wButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton)
        switch (sender as! UIButton)
        {
        case wButton: BackroundColor = UIColor.darkGrayColor();
        case bButton: BackroundColor = UIColor.blackColor();
        default: print(sender); break;
        }
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.AllowUserInteraction, .BeginFromCurrentState], animations: { self.view.backgroundColor = BackroundColor; }, completion: nil)
    }
    
    func AnimateButton(button: UIButton)
    {
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { button.alpha = 1.0 }, completion: nil)
    }
    
    @IBAction func ButtonTouchDown(sender: AnyObject) {
        let button = sender as! UIButton
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { button.alpha = 0.7 }, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        TitleLabel.backgroundColor = ButtonColor;
        bButton.backgroundColor = ButtonColor;
        wButton.backgroundColor = ButtonColor;
        view.backgroundColor = BackroundColor;
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

//
//  SettingsMainViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 1/15/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

class SettingsMainViewController: UIViewController {

    @IBOutlet weak var BackroundColorButton: UIButton!
    @IBOutlet weak var DevOptionsButton: UIButton!
    @IBOutlet weak var ColorButton: UIButton!
    @IBOutlet weak var TitleBar: UILabel!
    let tm = TransitionManager();
    var vButtonPresses: Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    @IBAction func ButtonPressed(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
    }
    @IBAction func ButtonTouchDown(sender: AnyObject) {
        let button = sender as! UIButton
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { button.alpha = 0.7; }, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        ColorButton.backgroundColor = ButtonColor;
        TitleBar.backgroundColor = ButtonColor;
        BackroundColorButton.backgroundColor = ButtonColor;
        DevOptionsButton.backgroundColor = BackroundColor;
        view.backgroundColor = BackroundColor;
    }
    
    func AnimateButton(button: UIButton)
    {
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { button.alpha = 1.0; }, completion: nil)
    }
    
    @IBAction func DevOptionsButtonPressed(sender: AnyObject) {
        if (DevMode){
            performSegueWithIdentifier("DevOptions", sender: self)
            return;
        }
        if (vButtonPresses == 5){ DevMode = true; return; }
        vButtonPresses++;
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender);
        let dvc = segue.destinationViewController;
        dvc.transitioningDelegate = tm;
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

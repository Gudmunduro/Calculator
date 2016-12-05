//
//  PresetsViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 11/2/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

class PresetsViewController: UIViewController {

    
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var buttonY: CGFloat = 0, buttons: [UIButton] = [], buttonsCreated = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        titleBar.backgroundColor = ButtonColor;
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        if (buttonsCreated)
        {
            for (var i = 0; i < buttons.count; i++)
            {
                buttons[i].removeFromSuperview()
            }
            buttons = [];
            buttonY = 10;
        }
        if (presets.count > 0)
        {
            for (var i = 0; i < presets.count; i++)
            {
                AddPresetButton(presets[i].name, presetId: i)
            }
        }
        addCreateButton();
        buttonsCreated = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ButtonTouchDraggedOutside(sender: AnyObject) {
        AnimateButton(sender as! UIButton);
    }
    @IBAction func ButtonTouchDown(sender: AnyObject) {
        let button = sender as! UIButton
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { button.alpha = 0.7; }, completion: nil)
    }
    
    @IBAction func presetButtonPressed(sender: UIButton)
    {
        Preset.selected = sender.tag;
    }
    
    @IBAction func CreateButtonPressed(sender: UIButton)
    {
        performSegueWithIdentifier("Create", sender: self)
    }
    
    
    func AddPresetButton(text: String, presetId: Int)
    {
        let button = UIButton(type: .System)
        button.frame = CGRectMake(0, buttonY, 320, 40)
        button.setTitle(" " + text, forState: .Normal)
        button.backgroundColor = ButtonColor
        button.tintColor = UIColor.whiteColor()
        button.titleLabel!.font = UIFont.systemFontOfSize(20.0)
        button.contentHorizontalAlignment = .Left
        button.tag = presetId;
        scrollView.addSubview(button)
        buttons.append(button)
        button.addTarget(self, action: "presetButtonPressed:", forControlEvents: .TouchUpInside)
        button.addTarget(self, action: "ButtonTouchDown:", forControlEvents: .TouchDown)
        button.addTarget(self, action: "ButtonTouchDraggedOutside:", forControlEvents: .TouchDragOutside)
        button.addTarget(self, action: "ButtonTouchDraggedOutside:", forControlEvents: .TouchUpInside)
        buttonY += 41
        scrollView.contentSize.height += 45;
    }
    func addCreateButton()
    {
        let button = UIButton(type: .System)
        button.frame = CGRectMake(0, buttonY, 320, 40)
        button.setTitle(" Create", forState: .Normal)
        button.backgroundColor = ButtonColor
        button.tintColor = UIColor.whiteColor()
        button.titleLabel!.font = UIFont.systemFontOfSize(20.0)
        button.contentHorizontalAlignment = .Left
        scrollView.addSubview(button)
        buttons.append(button)
        button.addTarget(self, action: "CreateButtonPressed:", forControlEvents: .TouchUpInside)
        button.addTarget(self, action: "ButtonTouchDown:", forControlEvents: .TouchDown)
        button.addTarget(self, action: "ButtonTouchDraggedOutside:", forControlEvents: .TouchDragOutside)
        button.addTarget(self, action: "ButtonTouchDraggedOutside:", forControlEvents: .TouchUpInside)
        buttonY += 41
        scrollView.contentSize.height += 45;
    }
    func AnimateButton(button: UIButton)
    {
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { button.alpha = 1.0 }, completion: nil)
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

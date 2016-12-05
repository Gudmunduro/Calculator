//
//  DeveloperOptionsViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 1/16/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

class DeveloperOptionsViewController: UIViewController {

    @IBOutlet weak var ColorPreview: UIButton!
    @IBOutlet weak var BSlider: UISlider!
    @IBOutlet weak var GSlider: UISlider!
    @IBOutlet weak var RSlider: UISlider!
    @IBOutlet weak var BColor: UITextField!
    @IBOutlet weak var GColor: UITextField!
    @IBOutlet weak var RColor: UITextField!
    @IBOutlet weak var LabelTextTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        LabelTextTextField.text = labelText;
        //ColorPreview.backgroundColor = ButtonColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ColorSliderChanged(sender: AnyObject) {
        let r = CGFloat(RSlider.value);
        let g = CGFloat(GSlider.value);
        let b = CGFloat(BSlider.value);
        ButtonColor = UIColor(red: r, green: g, blue: b, alpha: 1);
        ColorPreview.backgroundColor = ButtonColor;
        RColor.text = String(r);
        BColor.text = String(b);
        GColor.text = String(g);
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

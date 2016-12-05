//
//  AddMemoryViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 2/12/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

var CurrentMemory = "";

class AddMemoryViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var TitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        TitleLabel.backgroundColor = ButtonColor;
        TextField.backgroundColor = ButtonColor;
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        TextField.select(self)
    }
    
    @IBAction func AddButtonPressed(sender: AnyObject) {
        CurrentMemory = TextField.text!;
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

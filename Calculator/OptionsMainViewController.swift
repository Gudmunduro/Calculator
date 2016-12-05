//
//  OptionsMainViewController.swift
//  Calculator
//
//  Created by Gudmundur Halldorsson on 2/27/16.
//  Copyright © 2016 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

class OptionsMainViewController: UITableViewController {
    @IBOutlet weak var ThemeButton: UITableViewCell!
    @IBOutlet weak var BackRoundColorButton: UITableViewCell!
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ThemeButton.textLabel?.textColor = ButtonColor
        BackRoundColorButton.textLabel?.textColor = ButtonColor
        self.navigationController?.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: ButtonColor]
    }
    
}

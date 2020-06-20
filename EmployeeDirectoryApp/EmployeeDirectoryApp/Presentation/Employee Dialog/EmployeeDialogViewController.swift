//
//  EmployeeDialogViewController.swift
//  EmployeeDirectoryApp
//
//  Created by Mauricio Esteves on 2020-06-20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class EmployeeDialogViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoHeightConstraint.constant = UIScreen.main.bounds.width - 40
    }

}

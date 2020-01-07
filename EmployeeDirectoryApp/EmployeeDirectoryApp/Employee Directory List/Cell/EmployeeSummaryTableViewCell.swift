//
//  EmployeeSummaryTableViewCell.swift
//  EmployeeDirectoryApp
//
//  Created by Mauricio Esteves on 2019-12-27.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import SDWebImage

/* EmployeeSummaryTableViewCell is responsible to present each employee summary inside a UITableView. */
class EmployeeSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var employeePhotoImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var biographyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.employeePhotoImageView.layer.cornerRadius = 50
        self.containerView.layer.cornerRadius = 8
        applyShadow(view: containerView)
    }
    
    func update(_ fullName: String?, _ emailAddress: String?, _ employeeType: String?, _ phoneNumber: String?, _ biography: String?, _ largePhotoURL: String?, _ smallPhotoURL: String?) {
        self.fullNameLabel.text = fullName
        self.emailAddressLabel.text = emailAddress
        self.employeeTypeLabel.text = employeeType
        
        self.phoneNumberLabel.text = ""
        if let phoneNumber = phoneNumber {
            self.phoneNumberLabel.text = phoneNumber
        }
        
        self.biographyTextView.text = ""
        if let biography = biography {
            self.biographyTextView.text = biography
        }
    }
    
    /** Apply shadow around the view. */
    func applyShadow(view: UIView) {
        self.containerView.layer.borderWidth = 1.0
        self.containerView.layer.borderColor = UIColor.clear.cgColor
        self.containerView.clipsToBounds = true
        
        self.containerView.layer.shadowColor = UIColor.darkGray.cgColor
        self.containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.containerView.layer.shadowRadius = 5
        self.containerView.layer.shadowOpacity = 0.1
        self.containerView.layer.masksToBounds = false
    }
}

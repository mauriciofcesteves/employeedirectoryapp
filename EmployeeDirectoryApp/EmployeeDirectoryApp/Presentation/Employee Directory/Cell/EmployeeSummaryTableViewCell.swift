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

    private static let photoCornerRadius: CGFloat = 50
    private static let viewCornerRadius: CGFloat = 8
    
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
        
        self.employeePhotoImageView.layer.cornerRadius = EmployeeSummaryTableViewCell.photoCornerRadius
        self.containerView.layer.cornerRadius = EmployeeSummaryTableViewCell.viewCornerRadius
        
        containerView.applyShadow()
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
        
        if let photo = smallPhotoURL {
            employeePhotoImageView?.sd_setImage(with: URL(string: photo))
        }
        
        biographyTextView.isUserInteractionEnabled = false
    }
    
}

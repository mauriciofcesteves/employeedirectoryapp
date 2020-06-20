//
//  EmployeeSummaryTableViewCell.swift
//  EmployeeDirectoryApp
//
//  Created by Mauricio Esteves on 2019-12-27.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import SDWebImage

/** EmployeeSummaryTableViewCellDelegate */
protocol EmployeeSummaryTableViewCellDelegate: class {
    
    func didTouchEmployeePhoto(photo: UIImage)
}

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
    
    var largeEmployeePhotoImageView: UIImageView?
    weak var delegate: EmployeeSummaryTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Photo gestureRecognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoTapped(tapGestureRecognizer:)))
        employeePhotoImageView.isUserInteractionEnabled = true
        employeePhotoImageView.addGestureRecognizer(tapGestureRecognizer)
        
        self.employeePhotoImageView.layer.cornerRadius = EmployeeSummaryTableViewCell.photoCornerRadius
        self.containerView.layer.cornerRadius = EmployeeSummaryTableViewCell.viewCornerRadius
        
        containerView.applyShadow()
    }
    
    func update(_ fullName: String?, _ emailAddress: String?, _ employeeType: String?, _ phoneNumber: String?, _ largePhotoURL: String?, _ smallPhotoURL: String?) {
        self.fullNameLabel.text = fullName
        self.emailAddressLabel.text = emailAddress
        self.employeeTypeLabel.text = employeeType
        
        if let largePhoto = largePhotoURL {
            self.largeEmployeePhotoImageView = UIImageView()
            self.largeEmployeePhotoImageView?.sd_setImage(with: URL(string: largePhoto))
        }
        
        self.phoneNumberLabel.text = ""
        if let phoneNumber = phoneNumber {
            self.phoneNumberLabel.text = phoneNumber
        }
        
        if let photo = smallPhotoURL {
            employeePhotoImageView?.sd_setImage(with: URL(string: photo))
        }
    }
    
    @objc func photoTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let photo = largeEmployeePhotoImageView?.image else {
            return
        }
        
        delegate?.didTouchEmployeePhoto(photo: photo)
    }
    
}

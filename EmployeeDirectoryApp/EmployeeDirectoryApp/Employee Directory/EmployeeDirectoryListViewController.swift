//
//  EmployeeDirectoryListViewController.swift
//  EmployeeDirectoryApp
//
//  Created by Mauricio Esteves on 2019-12-27.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

/* EmployeeDirectoryListViewController is responsible to present employee data through an UITableView. */
class EmployeeDirectoryListViewController: BaseViewController {

    /* MARK: STATIC VARIABLES */
    private static let tableViewHeaderHeight: CGFloat = 30
    private static let tableViewRowHeight: CGFloat = 265
    
    @IBOutlet weak var tableView: UITableView!
    
    public var employeesGroupByTeamDictionary: [String: [EmployeeModel]]?
    
    /** The empty state label. */
    public lazy var emptyStateLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor(red: 155 / 255, green: 155 / 255, blue: 155 / 255, alpha: 1)
        label.numberOfLines = 0
        label.text = "There are no employees to be presented."
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        
        // Do any additional setup after loading the view.
        self.emptyStateLabel.isHidden = true
        self.view.addSubview(emptyStateLabel)
        self.navigationController?.isNavigationBarHidden = true
        
        //stick the header to the tableView while scrolling
        let viewHeight = CGFloat(40)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: viewHeight))
        self.tableView.contentInset = UIEdgeInsets(top: -viewHeight, left: 0, bottom: 0, right: 0)
        
        tableView.register(UINib(nibName: "EmployeeSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeSummaryTableViewCell")
    }
    
    /**
     * Request Employee data.
     */
    func requestData() {
        displayActivityIndicator(true)

        NetworkManager.shared.requestEmployeeData(completion: { [weak self] (success, data) -> Void in
            DispatchQueue.main.async {
                if success {
                    if let data = data, !data.isEmpty {
                        self?.employeesGroupByTeamDictionary = self?.buildEmployeeDictionaryGroupByTeam(data)
                        self?.tableView.reloadData()
                    } else {
                        self?.setupEmptyState()
                    }
                } else {
                    //error in the request (caused by malformed data)
                    self?.setupErrorState()
                }
                
                self?.displayActivityIndicator(false)
            }
        })
    }
    
    /* Setup empty state if there is no data to be presented. */
    func setupEmptyState() {
        self.emptyStateLabel.isHidden = false
        
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            ])
    }
    
    /* Setup an error state if there is any connection problem. */
    func setupErrorState() {
        let alertController = UIAlertController(title: "Error", message: "Oops! Something went wrong. Please check your internet and try again later.", preferredStyle: .alert)
        let mainAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            
        })
        alertController.addAction(mainAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /* Return the phone number formatted. */
    func formattingPhoneNumber(_ phoneNumber: String?) -> String? {
        
        if let phoneNumber = phoneNumber, phoneNumber.count == 10 {
            return phoneNumber.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
        }
        
        return nil
    }
    
    /*
     * Gets a list of employee as an input, iterate over it and organize it grouped by team.
     * Return a dictionary that has team name as key and a list of employee as value.
     */
    func buildEmployeeDictionaryGroupByTeam(_ employeeList: [EmployeeModel]) -> [String: [EmployeeModel]]? {
        var result = [String: [EmployeeModel]]()
        
        //iterates over the list of sorted employees
        for employee in employeeList.sorted(by: {$0.fullName < $1.fullName}) {
            
            //check if is the first time adding the team to the dictionary
            if result[employee.team] == nil {
                result[employee.team] = [EmployeeModel]()
            }
            
            //add the employee by team name
            result[employee.team]?.append(employee)
        }
        
        return result
    }
    
    /** Return the employee list based on the given section. */
    func getEmployeeListBySection(_ section: Int) -> [EmployeeModel] {
        
        guard let employeeDictionary = employeesGroupByTeamDictionary else {
            return []
        }
        
        for (index,dictionary) in employeeDictionary.enumerated() {
            if index == section {
                return dictionary.value
            }
        }
        
        return []
    }
}

/* MARK: UITableViewDelegate */
extension EmployeeDirectoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EmployeeDirectoryListViewController.tableViewRowHeight
    }
}

/* MARK: UITableViewDataSource */
extension EmployeeDirectoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of employees inside the dictionary based on the given section
        return getEmployeeListBySection(section).count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //the number of section is represented by the number of entries in the dictionary
        return self.employeesGroupByTeamDictionary?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeSummaryTableViewCell") as? EmployeeSummaryTableViewCell {
            
            //retrieve the employee given the section
            let employees = getEmployeeListBySection(indexPath.section)
            //retrieve the current employee from the employee list
            let employee = employees[indexPath.item]
            
            cell.update(employee.fullName, employee.emailAddress, employee.employeeType?.toString(), formattingPhoneNumber(employee.phoneNumber), employee.biography, employee.largePhotoURL, employee.smallPhotoURL)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    /* Return the UITableView Header, grouped by Team. */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor(red: 249 / 255, green: 249 / 255, blue: 249 / 255, alpha: 1)
        
        let teamLabel = UILabel(frame: CGRect(x: 15, y: 15, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        teamLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        teamLabel.textColor = UIColor(red: 48 / 255, green: 48 / 255, blue: 48 / 255, alpha: 1)
        teamLabel.text = getEmployeeListBySection(section).first?.team
        teamLabel.sizeToFit()
        
        header.addSubview(teamLabel)
        
        return header
    }
    
    /* UITableView header height */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return EmployeeDirectoryListViewController.tableViewHeaderHeight
    }
    
}

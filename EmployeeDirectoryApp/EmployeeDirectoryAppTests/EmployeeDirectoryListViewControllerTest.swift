//
//  EmployeeDirectoryListViewControllerTest.swift
//  EmployeeDirectoryApp
//
//  Created by Mauricio Esteves on 2019-12-29.
//  Copyright © 2019 personal. All rights reserved.
//

import XCTest
@testable import EmployeeDirectoryApp

/*
 * Unit Tests for EmployeeDirectoryListViewController
 * All tests and scenarios were identified before the actual method, using TDD.
 */
class EmployeeDirectoryListViewControllerTest: XCTestCase {
    
    fileprivate var viewController: EmployeeDirectoryListViewController?
    
    override func setUp() {
        viewController = EmployeeDirectoryListViewController()
    }
    
    override func tearDown() {
        viewController = nil
    }
    
    /*
     * 1. Given that I have a list of three employees. The first and the third one are from the 'Sales' team and the second one is from the 'Dev' team.
     * 2. When I call the method 'buildEmployeeDictionaryGroupByTeam'
     * 3. The system should group by team name.
     */
    func testGivenAListOfEmployeeItShouldGroupByTeam() {
        //Step 1.
        let employee1 = EmployeeModel("1", "Employee 1", emailAddress: "employee1@email.com", team: "Sales")
        
        let employee2 = EmployeeModel("2", "Employee 2", emailAddress: "employee2@email.com", team: "Dev")
        
        let employee3 = EmployeeModel("3", "Employee 3", emailAddress: "employee3@email.com", team: "Sales")
        
        let employees = [employee1, employee2, employee3]
        
        //Step 2.
        let resultDictionary = viewController?.buildEmployeeDictionaryGroupByTeam(employees)
        
        //Step 3.
        guard let result = resultDictionary else {
            assertionFailure("Result shouldn't be nil")
            return
        }
        
        assert(result.count == 2, "Dictionary should contains 2 entries")
        assert(result["Sales"]?.count == 2, "Sales key should contain 2 employees")
        assert(result["Dev"]?.count == 1, "Sales key should contain 1 employee")
        
        let salesEmployees = result["Sales"]
        assert(salesEmployees?.contains(employee1) ?? false, "Sales list should contain employee 1")
        assert(salesEmployees?.contains(employee3) ?? false, "Sales list should contain employee 3")
        
        let devEmployees = result["Dev"]
        assert(devEmployees?.contains(employee2) ?? false, "Dev list should contain employee 2")
    }
    
    /*
     * 1. Given that I have a list of three employees (Jesse, Jack, Maria). They are all from the same team (Sales team).
     * 2. When I call the method 'buildEmployeeDictionaryGroupByTeam'
     * 3. The system should return a dictionary grouped by team name and sorted by employees name (following the order Dev, Management and Sales).
     */
    func testGivenAListOfEmployeeItShouldGroupByTeamAndSortByEmployeesName() {
        //Step 1.
        let employee1 = EmployeeModel("1", "Maria", emailAddress: "employee1@email.com", team: "Sales")
        
        let employee2 = EmployeeModel("2", "Jesse", emailAddress: "employee2@email.com", team: "Sales")
        
        let employee3 = EmployeeModel("3", "Jack", emailAddress: "employee3@email.com", team: "Sales")
        
        let employees = [employee1, employee2, employee3]
        
        //Step 2.
        let resultDictionary = viewController?.buildEmployeeDictionaryGroupByTeam(employees)
        
        //Step 3.
        guard let result = resultDictionary else {
            assertionFailure("Result shouldn't be nil")
            return
        }
        
        let salesEmployees = result["Sales"]
        
        assert(result.count == 1, "Dictionary should contain 1 entry")
        assert(result["Sales"]?.count == 3, "Sales key should contain 3 employees")
        
        assert(salesEmployees?[0].fullName == "Jack", "The first name should be Jack")
        assert(salesEmployees?[1].fullName == "Jesse", "The second name should be Jesse")
        assert(salesEmployees?[2].fullName == "Maria", "The third name should be Maria")
    }
    
    /*
     * 1. Given that I have a phone number 6472113535.
     * 2. When I call the method 'formattingPhoneNumber'
     * 3. The system should format it, adding mask and return (647) 211-3535.
     */
    func testGivenAPhoneNumberItShouldFormatAddingMask() {
        //Step 1.
        let phoneNumber = "6472113535"
        
        //Step 2.
        let formattedNumber = viewController?.formattingPhoneNumber(phoneNumber)
        
        //Step 3.
        assert(formattedNumber == "(647) 211-3535", "The phone number should be (647) 211-3535")
    }
    
    /*
     * 1. Given that I have a phone number that contains eleven digits: 64721135351.
     * 2. When I call the method 'formattingPhoneNumber'
     * 3. The system should return nil when the phone number has a total of digits different from 10.
     */
    func testGivenAPhoneNumberWithElevenDigitsItShouldReturnNil() {
        //Step 1.
        let phoneNumber = "64721135351"
        
        //Step 2.
        let formattedNumber = viewController?.formattingPhoneNumber(phoneNumber)
        
        //Step 3.
        assert(formattedNumber == nil, "It should return nil")
    }
    
    /*
     * 1. Given that I have a list of three employees. They are from Sales team.
     * 2. When I call the method 'getEmployeeListBySection' by passing the section number
     * 3. The system should return an employee list related to the passed section number.
     */
    func testGivenASectionItShouldReturnAListOfEmployee() {
        
        //Step 1.
        let employee1 = EmployeeModel("1", "Employee 1", emailAddress: "employee1@email.com", team: "Sales")
        
        let employee2 = EmployeeModel("2", "Employee 2", emailAddress: "employee2@email.com", team: "Sales")
        
        let employee3 = EmployeeModel("3", "Employee 3", emailAddress: "employee3@email.com", team: "Sales")
        
        let employees = [employee1, employee2, employee3]
        
        let resultDictionary = viewController?.buildEmployeeDictionaryGroupByTeam(employees)
        viewController?.employeesGroupByTeamDictionary = resultDictionary
        
        //Step 2.
        let employeeListResult = viewController?.getEmployeeListBySection(0)
        
        //Step 3.
        assert(employeeListResult?.contains(employee1) ?? false, "It should contain employee 1")
        assert(employeeListResult?.contains(employee2) ?? false, "It should contain employee 2")
        assert(employeeListResult?.contains(employee3) ?? false, "It should contain employee 3")
    }
    
    /*
     * 1. Given that I have pass a section and no employees.
     * 2. When I call the method 'getEmployeeListBySection' by passing the section number
     * 3. The system should return an empty list.
     */
    func testGivenANotFoundSectionItShouldReturnAnEmptyList() {
        
        //Step 1.
        let section = 0
        
        //Step 2.
        let employeeListResult = viewController?.getEmployeeListBySection(section)
        
        //Step 3.
        assert(employeeListResult?.isEmpty ?? false, "It should be empty")
    }
}

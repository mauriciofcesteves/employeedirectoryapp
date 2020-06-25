//
//  NetworkManager.swift
//  EmployeeDirectoryApp
//
//  Created by Mauricio Esteves on 2019-12-27.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

/* Manage the network callbacks. */
public class NetworkManager {
    
    /* MARK: ENDPOINTS */
    static let endpoint = "https://run.mocky.io/v3/000c0dda-bbaf-4d52-9e1a-58d3a11e912b"
    
    static let delayEndpoint = "https://run.mocky.io/v3/000c0dda-bbaf-4d52-9e1a-58d3a11e912b?mocky-delay=4000ms"
    
    static let malformedEndpoint = "https://run.mocky.io/v3/000c0dda-bbaf-4d52-9e1a-58d3a11e912b?callback=myfunction"
    
    static let shared = NetworkManager()
    
    public var employees: [EmployeeModel]?
    
    private init() {}
    
    /* Fetch a list of Employees from an endpoint. */
    func requestEmployeeData(completion: @escaping (Bool, [String: [EmployeeModel]]?) -> ()) {
        let urlString = NetworkManager.endpoint
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let `self` = self else {
                completion(false, nil)
                return
            }
            
            if error != nil {
                print(error!.localizedDescription)
                completion(false, nil)
                return
            }
            
            guard let data = data else {
                completion(false, nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    if let jsonEmployees = json["employees"] as? NSArray {
                        self.employees = []
                        for employee in jsonEmployees {
                            if let currentEmployee = employee as? [String: Any] {
                                let newEmployee = EmployeeModel(json: currentEmployee)
                                
                                if newEmployee.id.isEmpty {
                                    completion(false, nil)
                                    return
                                }
                                
                                self.employees?.append(newEmployee)
                            }
                        }
                        
                        completion(true, self.buildEmployeeDictionaryGroupByTeam(self.employees ?? []))
                    }
                }
            } catch {
                print("error casting json")
                completion(false, nil)
                return
            }
            
            }.resume()
        //End of URLSession implementation
    }
    
    /*
     * Gets a list of employee as an input, iterate over it and organize it grouped by team.
     * Return a dictionary that has team name as key and a list of employee as value.
     */
    func buildEmployeeDictionaryGroupByTeam(_ employeeList: [EmployeeModel]) -> [String: [EmployeeModel]]? {
        var result = [String: [EmployeeModel]]()
        
        for employee in employeeList.sorted(by: {$0.fullName < $1.fullName}) {
            
            if result[employee.team] == nil {
                result[employee.team] = [EmployeeModel]()
            }
            
            result[employee.team]?.append(employee)
        }
        
        return result
    }
}

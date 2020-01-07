# Employee Directory App

Employee Directory is an app that presents the employees using UITableView and grouped by Team.

## Highlights
- In this app, I had special attention to the project as a whole. It’s well-commented, clean code and well-structured using MVC pattern. However, my focus was higher in the UI. The way it’s organized it looks like each employee is being presented on ‘Business Cards’.
- It connects with a REST back end to fetch the data using https://www.mocky.io/
- Inside EmployeeDirectoryListViewController, the UITableView presents the employee data grouped by the team. To achieve this result, a dictionary was used and the map key is the team name, as well as its value, is a list of employees.
- Moreover, The BaseViewController can be inherited to share methods that would be common and useful from different view controllers.
- I also would like to point as a highlight, the unit tests using TDD and the way I’m covering different scenarios for a singular method. Please, take a look at EmployeeDirectoryListViewControllerTest.
- The app should be responsive in a way that fits either iPhones and iPads.
- The pod ‘SDWebImage’ was used to manage the image downloading and caching

## Getting Started
To get this project launching and running, read the following instructions.

### Prerequisites
The project was developed using Xcode 10.3 and swift 5.

### Installation
Clone the project

```bash
git clone https://github.com/mauriciofcesteves/employeedirectoryapp.git

pod install
```

## Author
* **Mauricio Esteves** - [mauriciofcesteves (Mauricio Esteves) · GitHub](https://github.com/mauriciofcesteves)

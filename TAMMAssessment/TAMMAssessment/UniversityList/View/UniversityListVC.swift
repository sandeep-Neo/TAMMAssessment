//
//  UniversityListVC.swift
//  TAMMAssessment
//
//  Created by Capgemini on 02/05/24.
//

import UIKit

class UniversityListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate let kCell = "UniversityViewCell"
    var presentor:ViewToPresenterProtocol?
    var universityList: [UniversityListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        presentor?.startFetchingData()
    }
    
    /// Method will setup the UITableView.
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: kCell, bundle: nil), forCellReuseIdentifier: kCell)
    }
    
}

//MARK: - PresenterToViewProtocol Methods
extension UniversityListVC: PresenterToViewProtocol {
    /// Method will set the data and will reload the UITableView.
    /// - Parameter data: UniversityListModel type is required.
    func showList(data: [UniversityListModel]) {
        DispatchQueue.main.async {
            self.universityList = data
            self.tableView.reloadData()
        }
    }
    
    /// Method will display the alert error message.
    func showError(error: CustomError) {
        let alert = UIAlertController(title: Constants.kAlertTitle_ERROR, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.kAlertAction_YES, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate Methods
extension UniversityListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universityList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCell, for: indexPath) as? UniversityViewCell else { return UITableViewCell() }
        
        let data = universityList?[indexPath.row]
        cell.populateCell(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nav = navigationController , let data = universityList?[indexPath.row] {
            presentor?.showViewController(navigationController: nav, with: data)
        }
    }
}

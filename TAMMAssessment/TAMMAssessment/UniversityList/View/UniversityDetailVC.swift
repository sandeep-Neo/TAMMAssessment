//
//  UniversityDetailVC.swift
//  TAMMAssessment
//
//  Created by Capgemini on 02/05/24.
//

import UIKit

protocol UniversityDetailProtocol: AnyObject {
    func refreshListScreen()
}

class UniversityDetailVC: UIViewController {
    
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var webLinkLbl: UILabel!
    
    var universityData: UniversityListModel?
    weak var delegate: UniversityDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setupDataToUI()
    }
    
    /// Method will set the University data on the UI screen.
    private func setupDataToUI() {
        self.universityName.text = universityData?.name ?? ""
        self.stateName.text = universityData?.stateProvince ?? " - "
        self.countryName.text = "\(universityData?.country ?? "") - \(universityData?.alpha_two_code ?? "")"
        self.webLinkLbl.text = universityData?.web_pages.first
    }
    
    /// Button action will make the API call and reload the data on the first screen.
    @IBAction func refreshData(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        delegate?.refreshListScreen()
    }
}

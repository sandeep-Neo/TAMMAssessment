//
//  UniversityViewCell.swift
//  TAMMAssessment
//
//  Created by Capgemini on 02/05/24.
//

import UIKit

class UniversityViewCell: UITableViewCell {
    
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var stateName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /// Method will populate data into cell
    /// - Parameter data: UniversityListModel type.
    func populateCell(data: UniversityListModel?) {
        self.universityName.text = data?.name ?? ""
        self.stateName.text = data?.country ?? ""
    }
}

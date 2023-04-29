//
//  ImageTableViewCell.swift
//  Splash
//
//  Created by Ashwin Somkuwar on 28/04/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var tickButton: UIButton!
    
    weak var delegate: CellButtonTapped?
    var indexPath = IndexPath(row: 0, section: 0)
    var object: ResponseModel = ResponseModel() {
        didSet {
            if object.isSelected {
                self.tickButton.setImage(UIImage(named: "selectedButton"), for: .normal)
            } else {
                self.tickButton.setImage(UIImage(named: "unselectedButton"), for: .normal)
            }
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tickButtonPressed(_ sender: Any) {
        print("Tick button clicked...")
        object.isSelected = !object.isSelected
        delegate?.buttonTapped(indexPath: indexPath, isSelected: object.isSelected)
    }
}

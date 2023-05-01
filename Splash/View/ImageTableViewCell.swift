//
//  ImageTableViewCell.swift
//  Splash
//
//  Created by Ashwin Somkuwar on 28/04/23.
//

import SDWebImage

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
            let imageId = object.url.components(separatedBy: "photos/")[1]
            let finalUrlString = "https://source.unsplash.com/" + imageId
            if let imageUrl = URL(string: finalUrlString) {
                self.picture.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder-image"), options: .continueInBackground)
            }
            self.tickButton.setTitle("", for: UIControl.State.normal)
            if object.isSelected {
                self.tickButton.setImage(UIImage(named: "selectedButton"), for: .normal)
            } else {
                self.tickButton.setImage(UIImage(named: "unselectedButton"), for: .normal)
            }
            
            self.authorLabel.text = object.author
            self.urlLabel.text = object.url
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

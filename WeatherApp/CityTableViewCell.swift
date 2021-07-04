//
//  CityTableViewCell.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    static var identifier: String = "CityTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var iconView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        iconView.setImage(UIImage(named: "chevronRight"), for: .normal)
        iconView.tintColor = UIColor.black
        self.selectionStyle = .none
    }
}

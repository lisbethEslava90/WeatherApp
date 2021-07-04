//
//  DetailCollectionViewCell.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    static var identifier: String = "DetailCollectionViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var dataWeatherTableView: UITableView!
    
    var dataWeather: DetailCityCodable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        dataWeatherTableView.delegate = self
        dataWeatherTableView.dataSource = self
        dataWeatherTableView.register(UINib(nibName: WeatherTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }
}

extension DetailCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell

        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Min"
            cell.subtitleLabel.text = "\(String(Int(dataWeather?.minTemp ?? 0)))º"
        case 1:
            cell.titleLabel.text = "Max"
            cell.subtitleLabel.text = "\(String(Int(dataWeather?.maxTemp ?? 0)))º"
        case 2:
            cell.titleLabel.text = "Wind Speed"
            cell.subtitleLabel.text = (dataWeather?.windSpeed ?? 0.0).twoDecimals()
        case 3:
            cell.titleLabel.text = "Wind Direction"
            cell.subtitleLabel.text = (dataWeather?.windDirection ?? 0).twoDecimals()
        case 4:
            cell.titleLabel.text = "Air Pressure"
            cell.subtitleLabel.text = (dataWeather?.airPressure ?? 0).twoDecimals()
        case 5:
            cell.titleLabel.text = "Humidity"
            cell.subtitleLabel.text = String(dataWeather?.humidity ?? 0)
        case 6:
            cell.titleLabel.text = "Visibility"
            cell.subtitleLabel.text = (dataWeather?.visibility ?? 0).twoDecimals()
        case 7:
            cell.titleLabel.text = "predictability"
            cell.subtitleLabel.text = (dataWeather?.visibility ?? 0).twoDecimals()
        default:
            return UITableViewCell()
        }
        return cell
    }
}

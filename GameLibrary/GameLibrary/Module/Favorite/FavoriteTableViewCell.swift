//
//  FavoriteTableViewCell.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 21/05/24.
//

import UIKit
import GameLibraryCore
import Home

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var gameReleaseDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ game: GameModel) {
        self.gameTitle.text = game.name
        self.gameRating.text = "rating_score".localized().replacingOccurrences(of: "%@", with: "\(game.rating)")
        self.gameReleaseDate.text = CustomDateFormatter.toMMMdYYYY(date: game.released)
        self.gameImage.image = game.image
    }
    
}

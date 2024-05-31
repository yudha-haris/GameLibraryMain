//
//  GameTableViewCell.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 20/05/24.
//

import UIKit
import GameLibraryCore
import Home

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var gameReleaseDate: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ game: GameModel, _ indexPath: IndexPath, completion: @escaping (GameModel) -> Void) {
        gameTitle.text = game.name
        gameRating.text = String(format: NSLocalizedString("rating_score", comment: ""), "\(game.rating)")
        gameReleaseDate.text = CustomDateFormatter.toMMMdYYYY(date: game.released)
        gameImage.image = game.image
        
        let imageDownloader = ImageDownloader()
        if game.state == DownloadState.new {
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            Task {
                do {
                    let url = URL(string: game.backgroundImage)!
                    let image =  try await imageDownloader.downloadImage(url: url)
                    
                    let result = game.copyWith(image: image, state: DownloadState.downloaded)
                    completion(result)
                } catch {
                    let result = game.copyWith(image: nil, state: DownloadState.failed)
                    completion(result)
                }
            }
        } else {
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
        }
    }
    
}

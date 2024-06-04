//
//  DetailViewController.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 21/05/24.
//

import UIKit
import RxSwift
import GameLibraryCore
import Detail

class DetailViewController: UIViewController {
    
    // IBOutlet
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameReleaseDate: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var titleFrame: UIView!
    
    // IBAction
    @IBAction func favoriteButtonAction(_ sender: Any) {
        switch isFavorite {
        case true:
            presenter?.deleteFavoriteGame() { result in
                self.configFavoriteButton(favorite: !result)
            }
            break
        case false:
            presenter?.addFavoriteGame() { result in
                self.configFavoriteButton(favorite: result)
            }
            break
        }
    }
    
    // Dependencies
    private var presenter: DetailPresenter?
    private let disposeBag = DisposeBag()
    
    // Internal Variables
    public var id: Int = 1
    private var isFavorite: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.presenter = AppInjection.provideDetailPresenter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteButton.isEnabled = false
        gameDescription.isHidden = true
        gameReleaseDate.isHidden = true
        gameRating.isHidden = true
        gameTitle.isHidden = true
        imageLoadingIndicator.isHidden = true
        imageLoadingIndicator.stopAnimating()
        
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        titleFrame.layer.cornerRadius = 16
        titleFrame.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bindPresenter()
    }
    
    private func bindPresenter() {
        presenter?.getGame(id)
        presenter?.getFavoriteGame(id)
    }
    
    private func loadGame() {
        presenter?.game
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else {return}
                
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
                self.gameTitle.isHidden = false
                self.gameRating.isHidden = false
                
                switch result {
                case .success(let game):
                    guard let game = game else { return }
                    
                    self.gameTitle.text = game.name
                    self.gameRating.text = game.rating.toRating()
                    self.gameReleaseDate.text = CustomDateFormatter.toMMMdYYYY(date: game.released)
                    self.gameDescription.text = game.description
                    self.gameDescription.isHidden = false
                    self.gameReleaseDate.isHidden = false
                    startDownload(game: game)
                case .failure(let error):
                    self.gameTitle.text = "Gagal Menampilkan Halaman"
                    self.gameRating.text = error.localizedDescription
                    // self.favoriteButton.isEnabled = false
                }
                
            }).disposed(by: disposeBag)
        
        presenter?.isFavorite
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                
                self.favoriteButton.isEnabled = true
                self.favoriteButton.isHidden = false
                
                configFavoriteButton(favorite: result)
            }).disposed(by: disposeBag)
    }
    
    private func configFavoriteButton(favorite: Bool) {
        self.isFavorite = favorite
        
        switch favorite {
        case true:
            self.favoriteButton.image = UIImage(systemName: "heart.fill")
        case false:
            self.favoriteButton.image = UIImage(systemName: "heart")
        }
    }
    

    fileprivate func startDownload(game: GameDetail) {
        let imageDownloader = ImageDownloader()
        
        if game.state == .new {
            Task {
                do {
                    let url = URL(string: game.backgroundImage)!
                    imageLoadingIndicator.isHidden = false
                    imageLoadingIndicator.startAnimating()
                    let image = try await imageDownloader.downloadImage(url: url)
                    game.state = .downloaded
                    game.image = image
                    gameImage.image = image
                    imageLoadingIndicator.isHidden = true
                    imageLoadingIndicator.stopAnimating()
                } catch {
                    
                    imageLoadingIndicator.isHidden = true
                    imageLoadingIndicator.stopAnimating()
                    game.state = .failed
                    game.image = nil
                }
            }
        }
    }

}

//
//  ViewController.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 20/05/24.
//

import UIKit
import RxSwift
import GameLibraryCore
import Home

class ViewController: UIViewController {
    
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    private var games: [GameModel] = []
    private var presenter: HomePresenter?
    private var tableViewCellIdentifier: String = "gameTableViewCell"
    private var moveToDetailIdentifier: String = "moveToDetail"
    private var moveToAccountIdentifier: String = "moveToAccount"
    private var moveToFavoriteIdentider: String = "moveToFavorite"
    
    @IBAction func accountButtonAction(_ sender: Any) {
        performSegue(withIdentifier: moveToAccountIdentifier, sender: nil)
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        performSegue(withIdentifier: moveToFavoriteIdentider, sender: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.presenter = AppInjection.provideHomePresenter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameTableView.delegate = self
        gameTableView.dataSource = self
        gameTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
        
        loadGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorLabel.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        bindPresenter()
    }
    
    private func loadGame() {
        presenter?.games
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
                
                switch result {
                case .success(let games):
                    self.games = games
                    self.gameTableView.reloadData()
                case .failure(let error):
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error.localizedDescription
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindPresenter() {
        presenter?.getGames()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? GameTableViewCell {
            
            let game = games[indexPath.row]
            cell.bind(game, indexPath) { result in
                self.games[indexPath.row] = result
                if(result.state == DownloadState.downloaded) {
                    self.gameTableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: moveToDetailIdentifier, sender: games[indexPath.row].id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == moveToDetailIdentifier {
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.id = sender as! Int
            }
        }
    }
}


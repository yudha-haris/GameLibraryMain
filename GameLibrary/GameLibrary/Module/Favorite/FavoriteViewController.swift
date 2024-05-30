//
//  FavoriteViewController.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 21/05/24.
//

import UIKit
import RxSwift
import GameLibraryCore
import Home

class FavoriteViewController: UIViewController {
    @IBOutlet weak var gameTableView: UITableView!
    
    private let useCase = Injection.init().provideGetListFavoriteGame()
    private let disposeBag = DisposeBag()
    
    private var games: [GameModel] = []
    private var presenter: FavoritePresenter?
    private var tableViewCellIdentifier: String = "favoriteTableViewCell"
    private var moveToDetailIdentifier: String = "favoriteMoveToDetail"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.presenter = AppInjection.provideFavoritePresenter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gameTableView.dataSource = self
        gameTableView.delegate = self
        gameTableView.accessibilityIdentifier = tableViewCellIdentifier
        gameTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
        
        bindPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getFavoriteGames()
    }
    
    private func bindPresenter() {
        presenter?.games
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let games):
                    self.games = games
                    self.gameTableView.reloadData()
                case .failure(_):
                    break
                }
            }).disposed(by: disposeBag)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? FavoriteTableViewCell {
            
            let game = games[indexPath.row]
            cell.bind(game)
            return cell
        }
        return UITableViewCell()
    }
}

extension FavoriteViewController: UITableViewDelegate {
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

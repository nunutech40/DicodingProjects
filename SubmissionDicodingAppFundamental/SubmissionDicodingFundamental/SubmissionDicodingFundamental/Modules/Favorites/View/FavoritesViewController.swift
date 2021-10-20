//
//  FavoritesViewController.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 10/10/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = FavoritesViewModel()
    private lazy var gamesProvider: GameProvider = { return GameProvider() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        // setupTable
        self.tableView.register(UINib(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.gamesProvider.getAllFavGames { data in
            self.viewModel.dataModel = data
            self.tableView.reloadData()
        }
    }
    
    func setupUI() {
        self.title = "Favorites Games"
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedCell", for: indexPath)
        guard let reuseCell = cell as? RecommendedCell else {
            return RecommendedCell()
        }
        self.viewModel.fetchCellRecommGame(self, indexPath, reuseCell)
        return reuseCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.viewModel.dataModel[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = storyBoard.instantiateViewController(identifier: "DetailGameViewController") as? DetailGameViewController {
            nextVC.viewModel.idGame = data.id
            nextVC.viewModel.categoryGames = "Recommended Game"
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

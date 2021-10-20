//
//  ViewController.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 2/10/21.
//

import UIKit

class DashboardGameViewController: UIViewController {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var greetingView: UIView!
    @IBOutlet weak var bestGameStack: UIStackView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var iconMenu: UIImageView!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var bestGameMainView2: UIView!
    @IBOutlet weak var bestGameMainView1: UIView!
    @IBOutlet weak var rateLabelBestGame2: UILabel!
    @IBOutlet weak var rateLabelBestGame1: UILabel!
    @IBOutlet weak var genreLabelBestGame2: UILabel!
    @IBOutlet weak var genreLabelBestGame1: UILabel!
    @IBOutlet weak var imageBestGame1: UIImageView!
    @IBOutlet weak var imageBestGame2: UIImageView!
    @IBOutlet weak var titleBestGame1: UILabel!
    @IBOutlet weak var titleBestGame2: UILabel!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var iconSearch: UIImageView!
    
    var viewModel = DashboardGameViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.getGames(page: "1", completion: { pageList in
            
            self.viewModel.dataModel += pageList.dataList ?? []
            self.viewModel.setupBestGame(self, data: pageList.dataList ?? [])
            self.reloadConstraint()
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        })
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(resetView), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    @objc private func resetView() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.viewModel.page = 1
        self.viewModel.isHasLoad = false
        self.viewModel.dataModel = []
        self.getGames(page: "1", completion: { pageList in
            self.viewModel.dataModel += pageList.dataList ?? []
            self.viewModel.setupBestGame(self, data: pageList.dataList ?? [])
            self.reloadConstraint()
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            DispatchQueue.main.async { 
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func reloadConstraint() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.tableHeightConstraint.constant = self.tableView.contentSize.height + 20
        }
    }
    
    func setupUI() {
        // setup navigation
        self.imageProfile.rounded()
        self.imageProfile.image = UIImage(named: "iconLeft")
        self.searchView.customRounded(AppConfig.ROUND_PRIMARY)
        self.searchView.layer.borderWidth = 0.5
        self.searchView.layer.borderColor = UIColor.gray.cgColor
        self.searchTf.placeholder = "Search Games"
        
        // setupTable
        self.tableView.register(UINib(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        self.bestGameStack.subviews.forEach {
            $0.customRounded(AppConfig.ROUND_PRIMARY)
            $0.dropShadow()
        }
        
        self.greetingView.customRounded(AppConfig.ROUND_PRIMARY)
        self.setupRefreshControl()
        self.setupTap()
    }
    
    func setupTap() {
        self.imageProfile.isUserInteractionEnabled = true
        let tapProfile = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        self.imageProfile.addGestureRecognizer(tapProfile)
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(didSearch(_:)))
        self.iconSearch.addGestureRecognizer(tapSearch)
        self.iconSearch.isUserInteractionEnabled = true
    }
    
    @objc func didSearch(_ sender: UITapGestureRecognizer) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.viewModel.page = 1
        self.viewModel.isHasLoad = true
        self.viewModel.dataModel = []
        self.getGamesSearch(page: "1", text: self.searchTf.text!, completion: { pageList in
            self.viewModel.dataModel += pageList.dataList ?? []
            self.viewModel.setupBestGame(self, data: pageList.dataList ?? [])
            self.reloadConstraint()
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = storyBoard.instantiateViewController(identifier: "MyProfileViewController") as? MyProfileViewController {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }

}

extension DashboardGameViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension DashboardGameViewController: UIScrollViewDelegate {
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        // ini sengaja di mentokin sampe 4 halaman saja.
        guard self.viewModel.page <= 4 else { return }
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            if self.viewModel.isHasLoad == false {
                self.tableView.tableFooterView = createSpinnerFooter()
                self.viewModel.page += 1
                self.getGames(page: String(self.viewModel.page), completion: { pageList in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.viewModel.dataModel += pageList.dataList ?? []
                        if self.tableView.tableFooterView != nil {
                            self.tableView.tableFooterView = nil
                        }
                        self.reloadConstraint()
                    }
                })
                self.viewModel.isHasLoad = true
            }
            
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.viewModel.isHasLoad = false
    }
}

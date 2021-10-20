//
//  DetailGameViewController.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 4/10/21.
//

import UIKit

class DetailGameViewController: UIViewController {

    @IBOutlet weak var favIcon: UIImageView!
    @IBOutlet weak var ggameGenreLabel: UILabel!
    @IBOutlet weak var gameDescLabel: UILabel!
    @IBOutlet weak var gameCategoryLabel: UILabel!
    @IBOutlet weak var imageDetailGame: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = DetailGameViewModel()
    private lazy var gamesProvider: GameProvider = { return GameProvider() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.getDetailGames(id: String(self.viewModel.idGame), completion: { data in
            self.viewModel.dataDetail = data
            self.viewModel.setupDetailGame(self)
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.gamesProvider.checkFav(self.viewModel.dataDetail.id!, completion: { status in
                self.viewModel.ifThisFav = status
                self.setupFav(status)
            })
        })
        
    }
    
    func setupUI() {
        // setup navbar
        self.title = "Detail Game"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        // set navbaritem lefticon
        let backBtn = UIBarButtonItem(image: UIImage(named: "arrow_back_ios"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBtn
        
        // set navbaritem righticon
        let rightBtn = UIBarButtonItem(image: UIImage(named: "share"),
                                       style: .plain, target: self, action: #selector(shareBtn))
        navigationItem.rightBarButtonItem = rightBtn
        
        // setup round
        self.mainView.subviews.forEach {
            $0.customRounded(AppConfig.ROUND_PRIMARY)
        }
        
        self.setupTap()
    }
    
    func setupTap() {
        self.favIcon.isUserInteractionEnabled = true
        let tapFav = UITapGestureRecognizer(target: self, action: #selector(didTapFav(_:)))
        self.favIcon.addGestureRecognizer(tapFav)
    }
    
    @objc func didTapFav(_ sender: UIGestureRecognizer) {
        if !self.viewModel.ifThisFav {
            saveGames()
        } else {
            self.gamesProvider.deleteFavGames(self.viewModel.dataDetail.id!, completion: {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Successful", message: "Game ini sudah di hapus dari daftar favorit.", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        self.navigationController?.popViewController(animated: true)
                    })
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
        
        self.viewModel.ifThisFav = !self.viewModel.ifThisFav
        self.setupFav(self.viewModel.ifThisFav)
    }
    
    func setupFav(_ fav: Bool) {
        if fav {
            self.favIcon.tintColor = UIColor.systemPink
        } else {
            self.favIcon.tintColor = UIColor.lightGray
        }
    }
    
    @objc func shareBtn(_ gesture: UIGestureRecognizer) {
        
        if let strURL = self.viewModel.dataDetail.website {
            let textToShare = "This Game is Awasome!"
                if let myWebsite = NSURL(string: strURL) {
                    let objectsToShare: [Any] = [textToShare, myWebsite]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    activityVC.popoverPresentationController?.sourceView = self.view
                    self.present(activityVC, animated: true, completion: nil)
                }
        }
    }
    
    @IBAction func goToStoreBtn(_ sender: Any) {
        
        if let strURL = self.viewModel.dataDetail.website {
            if let url = URL(string: strURL) {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    func alert(_ message: String) {
        let allertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        allertController.addAction(alertAction)
        self.present(allertController, animated: true, completion: nil)
    }
    
}

extension DetailGameViewController {
    
    private func saveGames() {
        let detailGame = self.viewModel.dataDetail
        if let image = imageDetailGame.image, let data = image.pngData() as NSData? {
            gamesProvider.addToFav(
                detailGame?.id ?? 0,
                detailGame?.name ?? "",
                detailGame?.slug ?? "",
                detailGame?.rating ?? 0.0,
                detailGame?.released ?? "",
                data as Data,
                true,
                ggameGenreLabel.text ?? "") {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Successful", message: "Add To Favorite Success.", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        self.navigationController?.popViewController(animated: true)
                    })
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
}

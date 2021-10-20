//
//  DetailGameViewController.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 4/10/21.
//

import UIKit

class DetailGameViewController: UIViewController {

    @IBOutlet weak var ggameGenreLabel: UILabel!
    @IBOutlet weak var gameDescLabel: UILabel!
    @IBOutlet weak var gameCategoryLabel: UILabel!
    @IBOutlet weak var imageDetailGame: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = DetailGameViewModel()
    
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
    
}

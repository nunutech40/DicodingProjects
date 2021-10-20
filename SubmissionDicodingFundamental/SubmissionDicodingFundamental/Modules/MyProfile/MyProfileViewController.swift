//
//  MyProfileViewController.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 4/10/21.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        // setup navbar
        self.title = "My Profile"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        // set navbaritem lefticon
        let backBtn = UIBarButtonItem(image: UIImage(named: "arrow_back_ios"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBtn
        
        photoImage.customRounded(AppConfig.ROUND_PRIMARY)
        cardView.customRounded(AppConfig.ROUND_PRIMARY)
    }
    
}

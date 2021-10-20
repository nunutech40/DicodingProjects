//
//  MyProfileViewController.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 4/10/21.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descAboutMeLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ProfileModel.syncronize()
        self.nameLabel.text = ProfileModel.name
        self.positionLabel.text = ProfileModel.profession
        self.descAboutMeLabel.text = ProfileModel.aboutMe
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
        
        // set navbaritem righticon
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(edit)
        )
        
        photoImage.rounded()
        cardView.customRounded(AppConfig.ROUND_PRIMARY)
    }
    
    @objc func edit() {
        self.setupDefaultProfile()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let editVC = storyBoard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController else { return }
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func setupDefaultProfile() {
        ProfileModel.name           = self.nameLabel.text ?? ""
        ProfileModel.profession     = self.positionLabel.text ?? ""
        ProfileModel.aboutMe        = self.descAboutMeLabel.text ?? ""
    }
}

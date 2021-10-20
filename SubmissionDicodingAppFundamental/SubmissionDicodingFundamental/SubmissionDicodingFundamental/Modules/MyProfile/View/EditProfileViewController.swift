//
//  EditProfileViewController.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 10/10/21.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var postionText: UITextField!
    @IBOutlet weak var descText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.dataDefault()
    }
    
    func setupUI() {
        // set navbaritem lefticon
        let backBtn = UIBarButtonItem(image: UIImage(named: "arrow_back_ios"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBtn
        
        self.view.subviews.forEach {
            $0.customRounded(AppConfig.ROUND_PRIMARY)
        }
        self.title = "Edit Profile"
    }
    
    func dataDefault() {
        ProfileModel.syncronize()
        self.nameText.text = ProfileModel.name
        self.postionText.text = ProfileModel.profession
        self.descText.text = ProfileModel.aboutMe
    }
    
    @IBAction func updateProfileAct(_ sender: Any) {
        self.updateProfile()
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateProfile() {
        ProfileModel.name           = self.nameText.text ?? ""
        ProfileModel.profession     = self.postionText.text ?? ""
        ProfileModel.aboutMe        = self.descText.text ?? ""
    }
    
}

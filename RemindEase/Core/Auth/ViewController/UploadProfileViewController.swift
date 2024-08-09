//
//  UploadProfileViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 09/08/24.
//

import UIKit

class UploadProfileViewController: UIViewController {

    @IBOutlet weak var imgPlaceholder: UIImageView!
    @IBOutlet weak var btnContiue: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnRemove: UIButton!
    var viewModel: RegisterViewModel?
    
    let imagePickerManager = ImagePickerManager()
    var selectedImageData: Data? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear) { [weak self] in
                    guard let self else { return }
                    if selectedImageData == nil {
                        btnSkip.isHidden = false
                        btnAdd.isHidden = false
                        btnContiue.isHidden = true
                        btnRemove.isHidden = true
                        imgPlaceholder.isHidden = false
                    } else {
                        btnSkip.isHidden = true
                        btnAdd.isHidden = true
                        btnContiue.isHidden = false
                        btnRemove.isHidden = false
                        imgPlaceholder.isHidden = true
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        imgUser.layer.cornerRadius = 10
        lblName.text = UserService.shared.currentUser?.name ?? ""
        lblEmail.text = UserService.shared.currentUser?.email ?? ""
    }
    
    @objc func didTapOnProfileView() {
        
    }
    
    @IBAction func didTapOnAddPhoto(_ sender: Any) {
        imagePickerManager.pickImage(presentingViewController: self) { [weak self] selectedImage in
            guard let self = self else { return }
            if let image = selectedImage {
                imgUser.image = image
                selectedImageData = image.jpegData(compressionQuality: 0.5)
            } else {
                print("Image selection was canceled or an error occurred.")
            }
        }
    }
    
    @IBAction func didTapRemovePhoto(_ sender: Any) {
        selectedImageData = nil
        imgUser.image = UIImage()
    }
    
    @IBAction func didTapSkipForNow(_ sender: Any) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.loadTabScreen()
        }
    }
    
    @IBAction func didTapOnContinue(_ sender: Any) {
        
    }
}

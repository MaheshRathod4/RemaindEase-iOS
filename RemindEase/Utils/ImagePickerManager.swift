//
//  ImagePickerManager.swift
//  RemindEase
//
//  Created by MTPC-206 on 09/08/24.
//

import Foundation
import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var pickerController: UIImagePickerController
    private weak var presentingViewController: UIViewController?
    private var completion: ((UIImage?) -> Void)?

    override init() {
        pickerController = UIImagePickerController()
        super.init()
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    func pickImage(presentingViewController: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.presentingViewController = presentingViewController
        self.completion = completion

        let alert = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.completion?(nil)
        }))

        presentingViewController.present(alert, animated: true, completion: nil)
    }

    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = UIAlertController(title: "Warning", message: "You don't have a camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            presentingViewController?.present(alert, animated: true, completion: nil)
            return
        }
        pickerController.sourceType = .camera
        presentingViewController?.present(pickerController, animated: true, completion: nil)
    }

    private func openPhotoLibrary() {
        pickerController.sourceType = .photoLibrary
        presentingViewController?.present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        picker.dismiss(animated: true) {
            self.completion?(selectedImage)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.completion?(nil)
        }
    }
}

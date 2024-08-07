//
//  LoaderViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 07/08/24.
//

import UIKit

class LoaderViewController: UIViewController {

    @IBOutlet weak var ImageLoaderView: UIImageView!
    
    init() {
        super.init(nibName: "LoaderViewController", bundle: Bundle(for: LoaderViewController.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
    
    private func startAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1.0
        rotation.repeatCount = .infinity
        ImageLoaderView.layer.add(rotation, forKey: "spin")
    }


    private func stopAnimation() {
       // ImageLoaderView.layer.removeAllAnimations()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

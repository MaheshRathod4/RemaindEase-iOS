//
//  RemainderListViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import UIKit
import FSCalendar
import IGListKit

class RemainderListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var calendarView: FSCalendar!
    var selectedFolder: Folder?
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendarView, action: #selector(self.calendarView.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        title = selectedFolder?.name
        view.addGestureRecognizer(self.scopeGesture)
        
        collectionView.panGestureRecognizer.require(toFail: self.scopeGesture)
    }

}

extension RemainderListViewController : UIGestureRecognizerDelegate {
    
}

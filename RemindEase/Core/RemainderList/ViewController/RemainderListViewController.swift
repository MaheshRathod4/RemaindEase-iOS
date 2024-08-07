//
//  RemainderListViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import UIKit
import FSCalendar
import IGListKit
import RealmSwift
import SwiftUI

class RemainderListViewController: UIViewController {

    @IBOutlet weak var heightOfCalendarView: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var calendarView: FSCalendar!
    
    var selectedFolder: Folder?
    private var notificationToken: NotificationToken?
    var viewModel = RemainderListViewModel()
    var isLoading = false
    var hasMoreData = true
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
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
        adapter.scrollViewDelegate = self
        adapter.collectionView = collectionView
        adapter.dataSource = self
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.appearance.weekdayFont = UIFont.preferredFont(forTextStyle: .footnote)
        calendarView.appearance.weekdayTextColor = .subTitle
        calendarView.appearance.titleFont = UIFont.preferredFont(forTextStyle: .body)
        calendarView.appearance.headerTitleFont = UIFont.preferredFont(forTextStyle: .headline)
        calendarView.appearance.eventDefaultColor = .pink
        calendarView.appearance.titlePlaceholderColor = .subTitle
        calendarView.appearance.selectionColor = .accent
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
      //  calendarView.firstWeekday = 2
        collectionView.panGestureRecognizer.require(toFail: self.scopeGesture)
        collectionView.register(UINib(nibName: "RemainderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RemainderCollectionViewCell")
    }
    
    @IBAction func didTapOnAddRemainder(_ sender: Any) {
        let vc = UIHostingController(rootView: AddRemainderView())
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: true)
    }
    
}

extension RemainderListViewController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.collectionView.contentOffset.y <= -self.collectionView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendarView.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            default:
                return velocity.y < 0
            }
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.heightOfCalendarView.constant = bounds.height
        self.view.layoutIfNeeded()
    }
}

extension RemainderListViewController : UIScrollViewDelegate,ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if viewModel.items == nil {
            return [
                Remainder()
            ]
        } else {
            var objects: [ListDiffable] = Array(viewModel.items!) as [ListDiffable]
            if isLoading {
                objects.append(LoadingIndicator() as ListDiffable)
            }
            return objects
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is LoadingIndicator {
            return LoadingSectionController()
        } else {
            return CurrentRemainderSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
       return nil
    }
}

extension RemainderListViewController : FSCalendarDataSource, FSCalendarDelegate {
    
}

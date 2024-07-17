//
//  LoadingIndicatorCell.swift
//  RemindEase
//
//  Created by MTPC-206 on 15/07/24.
//

import UIKit

class LoadingIndicatorCell: UICollectionViewCell {
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

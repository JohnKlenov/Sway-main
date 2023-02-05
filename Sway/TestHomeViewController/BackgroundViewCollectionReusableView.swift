//
//  BackgroundViewCollectionReusableView.swift
//  Sway
//
//  Created by Evgenyi on 1.02.23.
//

import UIKit

class BackgroundViewCollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
//        backgroundColor = UIColor.darkGray.withAlphaComponent(1)
        backgroundColor = .clear
        layer.cornerRadius = 12
    }
    
}

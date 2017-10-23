//
//  NavTitleViewDelegate.swift
//  WeatherApplication
//
//  Created by Shelton on 10/23/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import UIKit
protocol NavTitleViewDelegate: class {
    func navTitleViewDidRequestCredentialPicker(titleView: NavTitleView)
}

final class NavTitleView: UIView {
    
    private lazy var imageView = UIImageView()
     lazy var refreshLabel = UILabel()
    lazy var titleLabel = UILabel()
    weak var delegate: NavTitleViewDelegate?
    
    init() {
        super.init(frame: CGRectZero)
        
        imageView.image = UIImage(named: "icon")
        addSubview(imageView)
        
        
        refreshLabel.font = .systemFontOfSize(12)
        refreshLabel.textColor = Theme.current.color(.textColor)
        addSubview(refreshLabel)
        
        
        titleLabel.font = .systemFontOfSize(12)
        titleLabel.textColor = Theme.current.color(.textColor)
        addSubview(titleLabel)
        
        setupLayoutConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
 
}

extension NavTitleView {
    
    private struct Layout {
        static let margin = 10
        static let spacing: CGFloat = 3
    }
    
    private func setupLayoutConstraints() {
        
        setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Vertical)
        
        refreshLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-Layout.margin)
            make.left.equalTo(self).offset(Layout.spacing)
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(refreshLabel)
            make.right.equalTo(self)
            make.left.equalTo(refreshLabel.snp_right).offset(Layout.spacing)
        }
        
        imageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.bottom.equalTo(refreshLabel.snp_top)
        }
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
}

// MARK: - Actions

extension NavTitleView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        imageView.layer.opacity = 0.8
        refreshLabel.layer.opacity = 0.8
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        imageView.layer.opacity = 1
        refreshLabel.layer.opacity = 1
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        imageView.layer.opacity = 1
        refreshLabel.layer.opacity = 1
        
        delegate?.navTitleViewDidRequestCredentialPicker(self)
    }
    
   
}

//
//  LoadingViewController.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import SnapKit
final public class LoadingViewController: UIViewController {
    
    private lazy var spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    private lazy var label = UILabel()
    private lazy var retryButton = UIButton(type: .Custom)
    
    private var retryAction: (() -> Void)? = nil
    
    override public func loadView() {
        super.loadView()
        
        view.backgroundColor = Theme.current.color(.backgroundColor)
        
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        view.addSubview(spinner)
        
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = Theme.current.color(.textColor)
        label.numberOfLines = 0
        view.addSubview(label)
        
        retryButton.backgroundColor = Theme.current.color(.buttonBackgroundColor)
        retryButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        retryButton.setTitleColor(Theme.current.color(.buttonTextColor), forState: .Normal)
        retryButton.setTitle(LS("GENERAL_RETRY"), forState: .Normal)
        retryButton.addTarget(self, action: #selector(LoadingViewController.didPressRetryButton(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(retryButton)
        
        setupLayoutConstraints()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }
}

// MARK: - Methods

extension LoadingViewController {
    public func startLoading(loading: Bool = true) {
        if loading {
            spinner.startAnimating()
            label.hidden = true
            retryButton.hidden = true
        } else {
            spinner.stopAnimating()
        }
    }
    
    public func stopLoading(text: String?, retryAction: (() -> Void)?) {
        spinner.stopAnimating()
        if let text = text {
            label.hidden = false
            label.text = text
        } else {
            label.hidden = true
        }
        
        self.retryAction = retryAction
        if retryAction != nil {
            retryButton.hidden = false
        } else {
            retryButton.hidden = true
        }
    }
}

// MARK: - Layout

extension LoadingViewController {
    
    private struct Layout {
        static let spacing = 10
        static let buttonWidth: CGFloat = 100
    }
    
    private func setupLayoutConstraints() {
        
        spinner.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
        }
        
        retryButton.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.greaterThanOrEqualTo(Layout.buttonWidth)
        }
        
        label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.left.greaterThanOrEqualTo(view.snp_leftMargin)
            make.right.lessThanOrEqualTo(view.snp_rightMargin)
            make.bottom.equalTo(retryButton.snp_top).offset(-Layout.spacing)
        }
    }
}

// MARK: - Actions

extension LoadingViewController {
    
    func didPressRetryButton(sender: AnyObject) {
        if let action = retryAction {
            action()
            retryAction = nil
        }
    }
}

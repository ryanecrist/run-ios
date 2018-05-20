//
//  RunHeaderView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/19/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class RunHeaderView: UIView {
    
    override static var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    var isCollapsed = true {
        didSet {

            let alpha: CGFloat = isCollapsed ? 0 : 1
            let alphaAnimations = {
                self.stackView.arrangedSubviews.forEach {
                    $0.alpha = alpha
                }
            }

            let hidden = isCollapsed
            let a = !isCollapsed
            let hiddenAnimations = {
                self.stackView.arrangedSubviews.forEach {
                    $0.isHidden = hidden
                }
                self.stackView.isLayoutMarginsRelativeArrangement = a
            }

            if isCollapsed {
                UIView.animate(withDuration: 0.25, animations: alphaAnimations) { _ in
                    UIView.animate(withDuration: 0.25, animations: hiddenAnimations)
                }
            } else {
                UIView.animate(withDuration: 0.25, animations: hiddenAnimations) { _ in
                    UIView.animate(withDuration: 0.25, animations: alphaAnimations)
                }
            }
        }
    }
    
    let durationLabel = UILabel()
    
    let distanceLabel = UILabel()
    
    let paceLabel = UILabel()
    
    private let stackView = UIStackView()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup self.
        backgroundColor = .primary
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2.5
        
        // Setup duration label.
        durationLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 36, weight: .medium)
        durationLabel.text = "00:00:00.00"
        durationLabel.textAlignment = .center
        durationLabel.textColor = .white
        
        // Setup distance label.
        distanceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        distanceLabel.text = "0.00 mi"
        distanceLabel.textColor = .white
        
        // Setup pace label.
        paceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        paceLabel.text = "0:00 / mi"
        paceLabel.textColor = .white
        
        // Setup timer image view.
        let timerImage = #imageLiteral(resourceName: "Timer")
        let timerImageView = UIImageView(image: timerImage)
        timerImageView.tintColor = .white
        
        let topStackView = UIStackView(arrangedSubviews: [timerImageView, durationLabel])
        topStackView.alignment = .center
        topStackView.alpha = 0
        topStackView.isHidden = true
        topStackView.isLayoutMarginsRelativeArrangement = true
        topStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: timerImage.size.width + topStackView.spacing)
        topStackView.spacing = 10
        
        // Setup bottom stack view.
        let bottomStackView = UIStackView(arrangedSubviews: [distanceLabel, paceLabel])
        bottomStackView.alpha = 0
        bottomStackView.isHidden = true
        bottomStackView.spacing = 10
        
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomStackView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            timerImageView.heightAnchor.constraint(equalTo: timerImageView.widthAnchor),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 20), // TODO this may be more appropriate to set on the container view.
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

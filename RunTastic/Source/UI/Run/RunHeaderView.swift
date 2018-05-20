//
//  RunHeaderView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/19/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class RunHeaderView: UIView {
    
    enum State {
        case collapsed
        case expanded
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

                UIView.animate(withDuration: 0.125, animations: alphaAnimations) { _ in
                    UIView.animate(withDuration: 0.125, animations: hiddenAnimations)
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
        
        backgroundColor = .primary
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2.5
        
        // Setup duration label.
        durationLabel.font = UIFont.boldSystemFont(ofSize: 30)
        durationLabel.textColor = .white
        
        distanceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        distanceLabel.textColor = .white
        
        paceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        paceLabel.textColor = .white
        
        let timerImage = #imageLiteral(resourceName: "Timer")
        let timerImageView = UIImageView(image: timerImage)
        timerImageView.tintColor = .white
        
        let topStackView = UIStackView(arrangedSubviews: [timerImageView, durationLabel])
        topStackView.alignment = .center
        topStackView.isHidden = true
        topStackView.alpha = 0
//        topStackView.isLayoutMarginsRelativeArrangement = true
        topStackView.spacing = 10
//        topStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: timerImage.size.width + topStackView.spacing)
//        topStackView.layoutIfNeeded()
        
        let bottomStackView = UIStackView(arrangedSubviews: [distanceLabel, paceLabel])
//        bottomStackView.distribution = .fillEqually
        bottomStackView.isHidden = true
        bottomStackView.alpha = 0
        bottomStackView.spacing = 10
        
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomStackView)
        addSubview(stackView)
        
        let c = timerImageView.heightAnchor.constraint(equalTo: timerImageView.widthAnchor)
//        c.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            timerImageView.widthAnchor.constraint(equalToConstant: timerImage.size.width),
            c,
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

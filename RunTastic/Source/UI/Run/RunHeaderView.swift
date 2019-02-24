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
    
    // MARK: - Public Properties
    
    var isCollapsed: Bool {
        get {
            return _isCollapsed
        }
        set {
            _isCollapsed = newValue
            setCollapsed(newValue, animated: false)
        }
    }
    
    let durationLabel = UILabel()
    
    let distanceLabel = UILabel()
    
    let paceLabel = UILabel()
    
    let targetPaceButton = UIButton()
    
    let targetPaceTextView = UITextView()
    
    // MARK: - Private Properties
    
    private var _isCollapsed = true
    
    private let _stackView = UIStackView()
    
    // MARK: - Initializers
    
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
        paceLabel.textAlignment = .right
        paceLabel.textColor = .white
        
        // Setup target pace button.
        targetPaceButton.setImage(#imageLiteral(resourceName: "Edit"), for: .normal)
        targetPaceButton.tintColor = .secondary
        
        // Setup target pace text view.
        targetPaceTextView.backgroundColor = .clear
        targetPaceTextView.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        targetPaceTextView.isEditable = false
        targetPaceTextView.isScrollEnabled = false
        targetPaceTextView.isSelectable = false
        targetPaceTextView.isUserInteractionEnabled = false
        targetPaceTextView.text = "0:00 / mi"
        targetPaceTextView.textColor = UIColor.white.withAlphaComponent(0.5)
        
        // Setup timer image view.
        let timerImageView = UIImageView(image: #imageLiteral(resourceName: "Timer"))
        timerImageView.tintColor = .white
        
        // Setup spacer views.
        let topSpacerView = UIView()
        let bottomSpacerView = UIView()
        
        // Setup top stack view.
        let topStackView = UIStackView(arrangedSubviews: [timerImageView, durationLabel, topSpacerView])
        topStackView.alignment = .center
        topStackView.spacing = 10
        
        // Setup bottom stack view.
        let bottomStackView = UIStackView(arrangedSubviews: [bottomSpacerView, paceLabel, targetPaceTextView, targetPaceButton])
        bottomStackView.alignment = .center
        bottomStackView.spacing = 10
        
        // Setup stack view.
        _stackView.alignment = .center
        _stackView.axis = .vertical
        _stackView.distribution = .fill
        _stackView.isLayoutMarginsRelativeArrangement = true
        _stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        _stackView.spacing = 5
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews.
        _stackView.addArrangedSubview(topStackView)
        _stackView.addArrangedSubview(distanceLabel)
        _stackView.addArrangedSubview(bottomStackView)
        addSubview(_stackView)
        
        // Add constraints.
        NSLayoutConstraint.activate([
            
            // Constrain stack view.
            _stackView.leftAnchor.constraint(equalTo: leftAnchor),
            _stackView.topAnchor.constraint(equalTo: topAnchor),
            _stackView.rightAnchor.constraint(equalTo: rightAnchor),
            _stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            _stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            // Constrain timer image view.
            timerImageView.heightAnchor.constraint(equalTo: timerImageView.widthAnchor),
            
            // Constrain target pace button.
            targetPaceButton.widthAnchor.constraint(equalToConstant: 24),
            targetPaceButton.heightAnchor.constraint(equalTo: targetPaceButton.widthAnchor),
            
            // Constrain target pace text view.
            targetPaceTextView.widthAnchor.constraint(equalTo: paceLabel.widthAnchor),
            
            // Constrain spacer views.
            topSpacerView.widthAnchor.constraint(equalTo: timerImageView.widthAnchor),
            bottomSpacerView.widthAnchor.constraint(equalTo: targetPaceButton.widthAnchor),
        ])
        
        // Constrain target pace text view.
        targetPaceTextView.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: - Public Methods
    
    func setCollapsed(_ collapsed: Bool, animated: Bool) {
        
        // Setup duration.
        let duration: TimeInterval = animated ? 0.25 : 0
        
        // Setup alpha animations block.
        let alpha: CGFloat = collapsed ? 0 : 1
        let alphaAnimations = {
            self._stackView.arrangedSubviews.forEach {
                $0.alpha = alpha
            }
        }
        
        // Setup layout animations block.
        let hidden = collapsed
        let layoutMarginsEnabled = !collapsed
        let layoutAnimations = {
            self._stackView.arrangedSubviews.forEach {
                $0.isHidden = hidden
            }
            self._stackView.isLayoutMarginsRelativeArrangement = layoutMarginsEnabled
        }
        
        // Animate the changes.
        if collapsed {
            UIView.animate(withDuration: duration, animations: alphaAnimations) { _ in
                UIView.animate(withDuration: duration, animations: layoutAnimations)
            }
        } else {
            UIView.animate(withDuration: duration, animations: layoutAnimations) { _ in
                UIView.animate(withDuration: duration, animations: alphaAnimations)
            }
        }
    }
}

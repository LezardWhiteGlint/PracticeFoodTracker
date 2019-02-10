//
//  RatingControl.swift
//  PracticeBoobsTracker
//
//  Created by Lezardvaleth on 2019/2/10.
//  Copyright © 2019 Lezardvaleth. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStatus()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder:coder)
        setupButtons()
    }
    //MARK: Button Action
    @objc func ratingButtonTapped(button:UIButton) {
//        print("Button pressed")
//        let index = ratingButtons.index(of: button)!
//        print("tapped")
//        print(ratingButtons)
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not the ratingButtons array:\(ratingButtons)")
        }
        
        //Calculate the rating of the selected button
        let selectedRating = index + 1
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButtons(){
        // clear any existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load button images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        //Create the button
        for index in 0..<starCount {
            let button = UIButton()
//            button.backgroundColor = UIColor.red
            //set button images
            button.setImage(emptyStar,for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            //Setup the button to the stack
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add button to the stackview
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStatus()
    }
    
    private func updateButtonSelectionStatus() {
        for (index,button) in ratingButtons.enumerated() {
             // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
        
    }
}

//
//  ViewController.swift
//  02 Guess the flag
//
//  Created by Jacob Molin Nielsen on 27/01/2016.
//  Copyright © 2016 Wussypants. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var countries = [String]()
    var currentAnswer = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds the value to the array with countries. From this array we can load our flag images
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // Adds a border of 1 point around our buttons
        Button1.layer.borderWidth = 1
        Button2.layer.borderWidth = 1
        Button3.layer.borderWidth = 1
        
        // Changes the color of this border to be slightly gray
        Button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        Button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        Button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        // Calls the AskQuestion function to start the game
        AskQuestion()
        
        // Displays the score at the bottom on a label
        displayScore()
    }

    /// Assigns the first three images from the array of countries. This array will be random.
    func AskQuestion(action: UIAlertAction!=nil)
    {
        // Shuffles the array, so the first 3 items will be random
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        
        // Sets the buttons to be the flags of the first 3 items in the array
        Button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        Button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        Button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        
        // randomize the correct answer
        currentAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        title = countries[currentAnswer].uppercaseString
    }
    
    func displayScore()
    {
        scoreLabel.text = "Your score is: \(score)"
    }
    
    func resetGame(action: UIAlertAction!=nil)
    {
        score = 0
        displayScore()
        AskQuestion()
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        var title: String!
        
        if sender.tag == currentAnswer
        {
            title = "Correct"
            score += 10
        } else
        {
            title = "Wrong"
            score -= 10
        }
        
        // Initialize a UIAlertController to display a message on the screen with the score
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .Alert)
        
        // Make an action to the UIAlertController to continue
        let continueAction = UIAlertAction(title: "Continue", style: .Default, handler: AskQuestion)
        
        // Make an action the reset the game
        let resetAction = UIAlertAction(title: "Reset Game", style: .Destructive, handler: resetGame)
        
        // Adds the action buttons to the UIAlertController
        ac.addAction(continueAction)
        ac.addAction(resetAction)
        
        // Call the presenter
        presentViewController(ac, animated: true, completion: nil)
        
        // Update the score displayed on the front view
        displayScore()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // GitHub test

}


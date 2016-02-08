//
//  ViewControllerHard.swift
//  02 Guess the flag
//
//  Created by Jacob Molin Nielsen on 07/02/2016.
//  Copyright © 2016 Wussypants. All rights reserved.
//

import UIKit
import GameKit

class ViewControllerHard: UIViewController {

    // MARK: Properties
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Buttons (flags)
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    // initialize our base game variables
    var countries = [String]()
    var currentAnswer = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us", "afghanistan", "brazil", "canada", "china", "denmark", "england", "greece", "northkorea", "norway", "sweden"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        displayScore()
        
        // Call the askQuestion method
        askQuestion()
        
    }
    
    func askQuestion(alert: UIAlertAction!=nil)
    {
        // shuffles the countries so they are new every time we reload
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        
        // Sets the button to present the flags of the first three elements in our countries array. Since it is random it can be any flag
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        
        // makes the correct answer random
        currentAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        
        // displays the correct answer to our title label
        titleLabel.text = countries[currentAnswer].uppercaseString
    }

    func displayScore()
    {
        scoreLabel.text = "Your score is: \(score)"
    }
    
    func resetGame(action: UIAlertAction!=nil)
    {
        score = 0
        displayScore()
        askQuestion()
    }
    
    @IBAction func buttonAction(sender: UIButton) {
        
        var evaluationTitle: String!
        
        if sender.tag == currentAnswer
        {
            score += 10
            evaluationTitle = "Correct"
        } else
        {
            score -= 10
            evaluationTitle = "Wrong"
        }
        
        let ac = UIAlertController(title: evaluationTitle, message: "Your score is: \(score)", preferredStyle: .Alert)
        
        let continueAction = UIAlertAction(title: "Continue", style: .Default, handler: askQuestion)
        
        let resetAction = UIAlertAction(title: "Reset", style: .Destructive, handler: resetGame)
        
        ac.addAction(continueAction)
        ac.addAction(resetAction)
        
        presentViewController(ac, animated: true, completion: nil)
        displayScore()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

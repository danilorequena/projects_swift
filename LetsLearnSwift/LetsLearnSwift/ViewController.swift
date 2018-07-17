import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func iniciar(sender: UIButton) {
        performSegueWithIdentifier("tutorialSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc:TutorialViewController = segue.destinationViewController as! TutorialViewController
        vc.modulo = sender!.tag
    }

}


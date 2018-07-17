import UIKit

class DynamicsViewController: UIViewController {

    var tipo:String = ""
    
    var animator:UIDynamicAnimator!
    
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        self.title = tipo
    }

    override func viewDidAppear(animated: Bool) {
        
        switch tipo {
            case "Collision":
                showCollision()
                break
            case "Snap":
                showSnap()
                break
            case "Gravity":
                showGravity()
                break
            case "Push":
                showPush()
                break
            case "Attachment":
                showAttachment()
                break
            default:
                break
        }
    }
    
    func showGravity() {
        let view1 = criarView(CGRect(x: 150, y: 100, width: 40, height: 40), cor: UIColor.redColor())
        let view2 = criarView(CGRect(x: 80, y: 180, width: 60, height: 20), cor: UIColor.greenColor())
        let view3 = criarView(CGRect(x: 250, y: 200, width: 10, height: 70), cor: UIColor.blueColor())
        
        let gravidade = UIGravityBehavior(items: [view1,view2,view3])
        
        animator.addBehavior(gravidade)
    }
    
    func showCollision() {
        let view1 = criarView(CGRect(x: 0, y: 0, width: 40, height: 40), cor: UIColor.redColor())
        let view2 = criarView(CGRect(x: 200, y: 160, width: 60, height: 20), cor: UIColor.greenColor())
        let view3 = criarView(CGRect(x: 250, y: 200, width: 10, height: 70), cor: UIColor.blueColor())
        let viewSolida = criarView(CGRect(x: 0, y: 300, width: 220, height: 10), cor: UIColor.blackColor())
        
        let propriedadesDaViewSolida = UIDynamicItemBehavior(items: [viewSolida])
        propriedadesDaViewSolida.allowsRotation = false
        propriedadesDaViewSolida.density = 100000
        animator.addBehavior(propriedadesDaViewSolida)
        
        let gravidade = UIGravityBehavior(items: [view1,view2,view3])
        animator.addBehavior(gravidade)
        
        let colisao = UICollisionBehavior(items: [view1,view2,view3,viewSolida])
        colisao.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(colisao)
        
        let ponto1 = CGPoint(x: viewSolida.frame.origin.x, y: viewSolida.frame.origin.y - 200)
        let ponto2 = CGPoint(x: viewSolida.frame.origin.x +  viewSolida.frame.size.width, y: viewSolida.frame.origin.y - 10)
        colisao.addBoundaryWithIdentifier("barreira", fromPoint: ponto1, toPoint: ponto2)
        
        
        
        
    }
    
    func showSnap() {
        let view1 = criarView(CGRect(x: 100, y: 220, width: 40, height: 40), cor: UIColor.grayColor())
        let pan = UIPanGestureRecognizer(target: self, action: "pan:")
        view1.addGestureRecognizer(pan)
    }
    
    func showAttachment() {
        let ancora = criarView(CGRect(x: 100, y: 100, width: 20, height: 20), cor: UIColor.blackColor())
        ancora.layer.cornerRadius = 10
        
        let view1 = criarView(CGRect(x: 140, y: 200, width: 50, height: 50), cor: UIColor.orangeColor())
        
        let attachment = UIAttachmentBehavior(item: view1, attachedToAnchor: CGPoint(x: ancora.center.x, y: ancora.center.y))
        animator.addBehavior(attachment)
        
        let gravidade = UIGravityBehavior(items: [view1])
        animator.addBehavior(gravidade)
    }
    
    func showPush() {
        let view1 = criarView(CGRect(x: 20, y: self.view.frame.height - 40, width: 40, height: 40), cor: UIColor.orangeColor())
        view1.layer.cornerRadius = 20
        
        let tap = UITapGestureRecognizer(target: self, action: "push:")
        tap.numberOfTapsRequired = 2
        view1.addGestureRecognizer(tap)
    }
    
    func criarView(frame: CGRect, cor: UIColor) -> UIView {
        let view1:UIView = UIView(frame: frame)
        view1.backgroundColor = cor
        view.addSubview(view1)
        return view1
    }

    func pan(recognizer: UIPanGestureRecognizer) {
        print("ok" )
        let pontoDeToque = recognizer.locationInView(self.view)
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        snap = UISnapBehavior(item: recognizer.view!, snapToPoint: pontoDeToque)
        animator.addBehavior(snap)
    }
    
    func push(recognizer: UITapGestureRecognizer) {
        let ball = recognizer.view!
        let angulo:CGFloat = 270
        var anguloEmRadianos:CGFloat!
        
        anguloEmRadianos = angulo * CGFloat(M_PI) / 180.0
        
        let push = UIPushBehavior(items: [ball], mode: UIPushBehaviorMode.Instantaneous)
        push.setAngle(anguloEmRadianos, magnitude: 2)
        animator.addBehavior(push)
        
        let gravidade = UIGravityBehavior(items: [ball])
        animator.addBehavior(gravidade)
    }
    
    

}

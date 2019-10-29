//
//  Level1ViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class Level1ViewController: BaseGameViewController {

  @IBOutlet private weak var playerView: SpriteView!
  @IBOutlet private weak var analogView: AnalogView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()

//    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//      self.playerView.moveTo(x: 400, y: 150)
//    }

    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(throghw), userInfo: nil, repeats: true)
  }

  @objc
  private func throghw() {

    let x = CGFloat(Int.random(in: (0...Int(view.frame.width))))
    let y = CGFloat(Int.random(in: (0...Int(view.frame.height))))
//    let katana = SpriteView(frame: CGRect(x: x, y: y, width: 30, height: 30))
//    katana.frames.idel = [#imageLiteral(resourceName: "katana")]
//    katana.frames.left = [#imageLiteral(resourceName: "katana")]
//    katana.frames.bottom = [#imageLiteral(resourceName: "katana")]
//    katana.frames.right = [#imageLiteral(resourceName: "katana")]
//    katana.frames.bottom = [#imageLiteral(resourceName: "katana")]
//    katana.speed = 10
//    view.addSubview(katana)
//    katana.moveTo(x: playerView.frame.origin.x, y: playerView.frame.origin.y)


    print("\(x), \(y)")
    playerView.moveTo(x: x, y: y)
  }

  private func setupPlayer() {
    playerView.frames.top = [#imageLiteral(resourceName: "top2"), #imageLiteral(resourceName: "top1")]
    playerView.frames.left = [#imageLiteral(resourceName: "left2"), #imageLiteral(resourceName: "left1")]
    playerView.frames.right = [#imageLiteral(resourceName: "right2"), #imageLiteral(resourceName: "right1")]
    playerView.frames.bottom = [#imageLiteral(resourceName: "bottom1"), #imageLiteral(resourceName: "bottom2")]
    playerView.frames.idel = [#imageLiteral(resourceName: "idel"), #imageLiteral(resourceName: "idel2")]
    playerView.stopWhenCollideTyps = [3, 4]
    playerView.attachTo(analogView)
  }

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) {

    if object1.type == 4 || object2.type == 4 {
//      self.performSegue(withIdentifier: "housePage", sender: nil)
      print("och, och")
    }

  }

}

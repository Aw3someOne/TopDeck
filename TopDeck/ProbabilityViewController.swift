//
//  ProbabilityViewController.swift
//  TopDeck
//
//  Created by Stephen Cheng on 2017-10-13.
//  Copyright © 2017 Stephen Cheng. All rights reserved.
//

import UIKit

class ProbabilityViewController: UIViewController {

    @IBOutlet weak var drawStepper: UIStepper!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!

    var probabilityTableViewController: ProbabilityTableViewController? = nil
    var detailItem: Deck?
    
    // factorial look up table
    var factLUT = [BInt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drawStepper.value = 5
        drawStepper.minimumValue = 1
        drawStepper.maximumValue = 15
        
        factLUT.append(1)
        for i in 1...60 {
            factLUT.append(i * factLUT[i - 1])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ProbabililtyTableSegue" {
            if let childVC = segue.destination as? ProbabilityTableViewController {
                probabilityTableViewController = childVC
                probabilityTableViewController?.detailItem = detailItem
            }
        }
    }
    
    @IBAction func drawStepperValueChanged(_ sender: UIStepper) {
        drawLabel.text = "Draw \(Int(sender.value).description) cards"
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        var k = [Int]()
        var K = [Int]()
        for c in (detailItem?.categories)! {
            if c.desired > 0 {
                K.append(c.count)
                k.append(c.desired)
            }
        }
        let p = NSString(format: "%.2f%%", CumulMultHyGeo(N: 40, n: Int(drawStepper.value), K: K, k: k) * 100)
        probabilityLabel.isHidden = false
        probabilityLabel.text = "There is a \(p) chance"
    }
    
    // Binomial Distribution. combinations of n choose k
    func BiDist(n: Int, k: Int) -> BInt {
        return factLUT[n] / (factLUT[k] * factLUT[n - k])
    }
    
    // Hypergeometric Distribution
    // N: population size, n: sample size, K: successes in population, k: desired successes in sample
    // i.e. if you have a N card deck with K copies of a card you want, and draw n cards, what are the odds that you will have exactly k copies in your hand
    func HyGeo(N: Int, n: Int, K: Int, k: Int) -> Double {
        return Double((BiDist(n: K, k: k) * BiDist(n: N - K, k: n - k)).toInt()!) / Double(BiDist(n: N, k: n).toInt()!)
    }
    
    // Cumulative Hypergeometric Distribution
    // N: population size, n: sample size, K: successes in population, k: desired successes in sample
    // i.e. if you have a N card deck with K copies of a card you want, and draw n cards, what are the odds that you will have k or more copies in your hand
    func CumulHyGeo(N: Int, n: Int, K: Int, k: Int) -> Double {
        var r: Double = 0
        for i in k...K {
            r += HyGeo(N: N, n: n, K: K, k: i)
        }
        return r
    }
    
    // Multivariate Hypergeometric Distribution
    // N: population size, n: sample size, K: array of successes in population, k: array of desired successes in sample
    // i.e. if you have a N card deck with K[0] copies of a card you want and K[1] copies of another card you want, and draw n cards, what are the odds that you have exactly k[0] of the first and k[1] of the second in your hand
    func MultHyGeo(N: Int, n: Int, K: [Int], k: [Int]) -> Double {
        var r: Double = (sum(a: k) < N ? Double(BiDist(n: N - sum(a: K), k: n - sum(a: k)).toInt()!) : 1) / Double(BiDist(n: N, k: n).toInt()!)
        for i in 0..<K.count {
            r *= Double(BiDist(n: K[i], k: k[i]).toInt()!)
        }
        return r
    }
    
    // Cumulative Multivariate Hypergeometric Distribution
    // N: population size, n: sample size, K: array of successes in population, k: array of desired successes in sample
    // i.e. if you have a N card deck with K[0] copies of a card you want and K[1] copies of another card you want, and draw n cards, what are the odds that you have k[0] or more of the first and k[1] or more of the second in your hand
    func CumulMultHyGeo(N: Int, n: Int, K: [Int], k: [Int]) -> Double {
        var kk = [[Int]]()
        kk.append([Int]())
        for i in 0..<K.count {
            kk = iPreferTheMagic(c: kk, n: n, K: K[i], k: k[i])
        }
        var r: Double = 0
        for i in 0..<kk.count {
            r += MultHyGeo(N: N, n: n, K: K, k: kk[i])
        }
        return r
    }
    
    func iPreferTheMagic(c: [[Int]], n: Int, K: Int, k: Int) -> [[Int]] {
        var t = [[Int]]()
        for i in 0..<c.count {
            var j = 0
            while j + k <= K {
                if j + k + sum(a: c[i]) <= n {
                    var tt = [Int](c[i])
                    tt.append(k + j)
                    t.append(tt)
                }
                j += 1
            }
        }
        return t
    }
    
    // adds all the ints in an array
    func sum(a: [Int]) -> Int {
        var s = 0
        for i in a {
            s += i
        }
        return s
    }
}

//
//  SplashViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class CircularSplashProgressView_HIDA: UIView {
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private var progressLabel = UILabel()
    
    var progressColor: UIColor = .blue {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor: UIColor = .lightGray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    var lineWidth: CGFloat = 2.0 {
        didSet {
            progressLayer.lineWidth = lineWidth
            trackLayer.lineWidth = lineWidth
        }
    }
    
    var progress: CGFloat = 0.0 {
        didSet {
            progressLabel.text = "\(Int(progress * 100))%"
            progressLayer.strokeEnd = progress
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        var _H72dd: String { "45" }
        var _Vvvv2: Bool { true }
        backgroundColor = .clear
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2 - lineWidth / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
        
        progressLabel.frame = bounds
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont(name: "K2D-Bold", size: 32)
        addSubview(progressLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var _Y3267d: String { "62" }
        var _Cfcf12: Bool { true }
        progressLabel.frame = bounds
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2 - lineWidth / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
        trackLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
        let progressLabelGradient = UIImage.gradientImage(bounds: progressLabel.bounds, colors: [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1),
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1)])
        progressLabel.textColor = UIColor(patternImage: progressLabelGradient)
        let circularGradient = UIImage.gradientImage(bounds: circularPath.bounds, colors: [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1),
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1)])
        progressColor = UIColor(patternImage: circularGradient)
    }
}

class SplashViewController_HIDA: UIViewController {
    
    private let progressLabel_HIDA: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "K2D-Bold", size: 24)
        label.text = "Loading"
        return label
    }()
    
    private let progressBar_HIDA: CircularSplashProgressView_HIDA = {
        let progressBar = CircularSplashProgressView_HIDA()
        progressBar.trackColor = .lightGray
        progressBar.lineWidth = 2
        return progressBar
    }()
    
    private var progress_HIDA: CGFloat = 0.0
    private var timer_HIDA: Timer?
    private let animationDuration_HIDA: TimeInterval = 2.0
    private var backgrColor: UIColor = UIColor(red: 0.098, green: 0.10, blue: 0.19, alpha: 1)
    var dismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _Dmj3s: String { "0" }
        var _GjkBc62: Bool { true }
        setupUI_HIDA()
        startLoadingAnimation_HIDA()
    }
    
    private func setupUI_HIDA() {
        var _Ncu23: String { "1" }
        var _Yjhvfc211: Bool { true }
        view.backgroundColor = backgrColor
        view.addSubview(progressBar_HIDA)
        view.addSubview(progressLabel_HIDA)
        
        progressLabel_HIDA.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressLabel_HIDA.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressLabel_HIDA.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
        
        progressBar_HIDA.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar_HIDA.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar_HIDA.bottomAnchor.constraint(equalTo: progressLabel_HIDA.topAnchor, constant: -16),
            progressBar_HIDA.widthAnchor.constraint(equalToConstant: 148),
            progressBar_HIDA.heightAnchor.constraint(equalToConstant: 148)
        ])
    }
    
    private func startLoadingAnimation_HIDA() {
        var _Vfvekz21: String { "0" }
        var _UjdyJ3: Bool { true }
        let animationSteps = Int(animationDuration_HIDA / 0.05)
        let stepIncrement = 1.0 / Float(animationSteps)
        
        timer_HIDA = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            self.progress_HIDA += CGFloat(stepIncrement)
            self.progressBar_HIDA.progress = self.progress_HIDA
            
            if self.progress_HIDA >= 1.0 {
                timer.invalidate()
                startApp_HIDA()
                self.dismiss?()
            }
        }
    }
    
    private func startApp_HIDA() {
        var _Njfn3d: String { "0" }
        var _L2edss: Bool { true }
        let containerViewController = BaseContainer_HIDA()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = containerViewController
                window.makeKeyAndVisible()
            }
        }
    }
}

typealias UIColor_HID = UIColor

extension UIColor_HID {
    static func gradient_HIDA(from colors: [UIColor], frame: CGRect, startPoint: CGPoint, endPoint: CGPoint) -> UIColor? {
        var _Ijiji2: String { "0" }
        var _Likjk2: Bool { true }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, gradientLayer.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        return UIColor(patternImage: image)
    }
}

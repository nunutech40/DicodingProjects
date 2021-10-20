//
//  ViewController.swift
//  TestingChartGrafik
//
//  Created by mac on 13/9/21.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!

    var data: LineChartData = LineChartData()
    var entriesLeads: [ChartDataEntry] = []
    var entriesOrders: [ChartDataEntry] = []
    var setLeads: LineChartDataSet?
    var setOrders: LineChartDataSet?
    var xvalues: [String] = [String]()
    var yValus = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        xvalues.append("00:00")
        xvalues.append("04:00")
        xvalues.append("08:00")
        xvalues.append("12:00")
        xvalues.append("16:00")
        xvalues.append("20:00")
        xvalues.append("23:59")
        
       
        for i in 0...30 {
            yValus.append(String(i))
        }
//
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.gridLineWidth = 1
        xAxis.axisMinimum = 0.0
        xAxis.granularity = 1
       
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xvalues)
        
        lineChartView.leftAxis.enabled = true
        lineChartView.leftAxis.granularity = 5
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.valueFormatter = IndexAxisValueFormatter(values: yValus)
        lineChartView.legend.enabled = false
        
        //
        
        let data = generateLineData()
        lineChartView.data = data
        lineChartView.delegate = self
    }
    
    func generateLineData() -> LineChartData {
        
        let dataArr: [Int] = [10, 5, 8, 20, 23, 25, 30]
        let dataArr2: [Int] = [15, 8, 2, 10, 22, 30, 33]
        
        for index in 0..<self.xvalues.count {
            entriesLeads.append(ChartDataEntry(x: Double(index),  y: Double(dataArr[index])))
            entriesOrders.append(ChartDataEntry(x: Double(index), y: Double(dataArr2[index])))
        }
        
        setLeads = LineChartDataSet(entries: entriesLeads, label: "Leads")
        setLeads?.setColor(UIColor.blue)
        setLeads?.lineWidth = 2
        setLeads?.drawCircleHoleEnabled = false
        setLeads?.drawCirclesEnabled = false
        setLeads?.drawValuesEnabled = false
        
        setLeads?.mode = Charts.LineChartDataSet.Mode.horizontalBezier
        data.addDataSet(setLeads)
        
        
        setOrders = LineChartDataSet(entries: entriesOrders, label: "Orders")
        setOrders?.setColor(UIColor.green)
        setOrders?.lineWidth = 2
        setOrders?.drawCircleHoleEnabled = false
        setOrders?.drawCirclesEnabled = false
        setOrders?.drawValuesEnabled = false
        //setOrders?.draw
        setOrders?.mode = Charts.LineChartDataSet.Mode.horizontalBezier
        data.addDataSet(setOrders)
        
        return data
    }
    
    
}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        let dataLine = data.dataSets[highlight.dataSetIndex]
        var circleColor: UIColor?
        if highlight.dataSetIndex == 0 {
            circleColor = UIColor.blue
        } else {
            circleColor = UIColor.green
        }
        let x: Int = Int(entry.x)
        let time = xvalues[x]
        
        let markerFloating = PillMarker(
            color: .white,
            font: UIFont.boldSystemFont(ofSize: 14),
            textColor: .black,
            circleColor: circleColor!,
            labelLineChart: dataLine.label ?? "No Label",
            time: time)
        
        chartView.marker = markerFloating
        
        chartView.setNeedsDisplay()
        
    }
    
}

class PillMarker: MarkerImage {

    private (set) var color: UIColor
    private (set) var font: UIFont
    private (set) var textColor: UIColor
    private var labelText: String = ""
    private var attrs: [NSAttributedString.Key: AnyObject]!
    private var label: String!
    private var time: String = ""
    
    @objc var circleColor: UIColor
    @objc var radius: CGFloat = 4

    init(color: UIColor, font: UIFont, textColor: UIColor, circleColor: UIColor, labelLineChart: String, time: String) {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.label = labelLineChart
        self.time = time
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
       
        attrs = [.font: font, .paragraphStyle: paragraphStyle, .foregroundColor: UIColor.blue, .baselineOffset: NSNumber(value: -4)]
        
        // circle color
        self.circleColor = circleColor
        super.init()
    }

    override func draw(context: CGContext, point: CGPoint) {
        
        // place pill above the marker, centered along x
        var rectangle = CGRect(x: point.x, y: point.y, width: 74, height: 44)
        rectangle.origin.x -= rectangle.width / 2.0
        let spacing: CGFloat = 20
        rectangle.origin.y -= rectangle.height + spacing

        // rounded rect
        let clipPath = UIBezierPath(roundedRect: rectangle, cornerRadius: 6.0).cgPath
        context.addPath(clipPath)
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
        context.closePath()
        context.setLineWidth(0)
        context.drawPath(using: .fillStroke)

        // add the text
//        let (nsAttrbute, key) = attrs
//        halfTextColorChange(fullText: nsAttrbute, changeText: "Orders")
        labelText.draw(with: rectangle, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        
        // circle color
        let circleRect = CGRect(x: point.x - (radius + 1), y: point.y - (radius + 1), width: radius * 3, height: radius * 3)
        context.setFillColor(circleColor.cgColor)
        context.fillEllipse(in: circleRect)
        
        context.restoreGState()
    }

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        labelText = customString(entry.y)
    }

    private func customString(_ value: Double) -> String {
        let formattedString = "\(Int(value)) \(label ?? "") \r \(time)"
        return "\(formattedString)"
    }
    
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText.lowercased() as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.blue , range: range)
    }
}

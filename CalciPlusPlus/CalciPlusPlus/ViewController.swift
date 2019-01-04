//
//  ViewController.swift
//  CalciPlusPlus
//
//  Created by Sharan Narasimhan on 11/11/18.
//  Copyright © 2018 Sharan Narasimhan. All rights reserved.
//

// last sender.tag = 21



import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var sinButton: UIButton!
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var displayAnswer: UILabel!
    
    var nativeMemory: [Double] = []
    var bracketsMemory: [Double] = []
    var bracketsMemoryforOperators: [Int] = []
    var numberIndex: Int = 0
    var operatorIndex: Int = 0
    var nativeMemoryforOperators: [Int] = []
    var numberBuffer: Double = 0
    var finalAnswer: Double = 0
    var i: Int = 0
    var numberOfBrackets: Int = 0
    var temporaryNativeMemory: [Double] = []
    var temporaryNativeMemoryforOperators: [Int] = []
    
    var bracketSolution: Double = 0
    var locationOfCloseBracket: Int = 0
    
    var memoryPlus: Double = 0
    
    var decimalOn: Double = 0

    
    var firstHit: Bool = true
    
    let impact = UIImpactFeedbackGenerator();
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded...")
        
    }
    
    
    @IBAction func mathFunctions(_ sender: UIButton) {
        if(sender.tag == 22){
            print("sin() hit")
        }
    }
    
    

    @IBAction func switchHIt(_ sender: UIButton) {
        print("Switch Hit!")
        sinButton.isHidden = false
        sinButton.isEnabled = true
    }
    
    
    @IBAction func backSpaceHit(_ sender: UIButton) {
    }
    
    @IBAction func memoryPlus(_ sender: UIButton) {
        if (firstHit == true){
            memoryPlus = finalAnswer
            displayAnswer.text = display.text! + String("Answer Stored")
        }
        else{
            print("nothing to save!")
        }
    }
    
    
    @IBAction func memoryClear(_ sender: UIButton) {
        
        memoryPlus = 0;
        displayAnswer.text = String(" (Memory Cleared)")
        
        
    }
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        impact.impactOccurred()
        
        
        if( firstHit == true) // first time we hit button on cleared display
        {
            display.text = ""
            firstHit = false
        
        }
         // holds memory of latest number
        
        if (sender.tag == 21 && displayAnswer.text! != ""){ //Ans button is hit
            print("Answer pasted...")
            display.text = display.text! + String("Ans")
            numberBuffer = memoryPlus
            
        }
        else if(sender.tag == 20){
            
            display.text = display.text! + String(".")
            decimalOn += 1
            
        }
        else { // if 0-9 pressed
            
            if(decimalOn == 0){// . not present
            display.text = display.text! + String(sender.tag-1)
            numberBuffer = numberBuffer*10 + Double(sender.tag-1)
            }
            else{
                display.text = display.text! + String(sender.tag-1)
                numberBuffer += Double(sender.tag-1)/pow(10, decimalOn)
                decimalOn += 1
            }
            
        }
        
        
        
        //numberOnDisplay = Double(display.text!)!
    }
    
    
    @IBAction func bracketsHiot(_ sender: UIButton) {
        
        
        if( firstHit == true) // first time we hit button on cleared display
        {
            display.text = ""
            firstHit = false
            
        }
        
        if(sender.tag == 17)
        {
            display.text = display.text! + String("(")
            nativeMemoryforOperators.append(5)
            operatorIndex+=1
        }
        if(sender.tag == 18)
        {
            display.text = display.text! + String(")")
            nativeMemoryforOperators.append(6)
            operatorIndex+=1
        }
        
    }
    
    
    
    @IBAction func operations(_ sender: UIButton) { // when an operator is pressed, memory has to be stores.
        
        impact.impactOccurred()
        
        nativeMemory.append(numberBuffer)
        numberBuffer = 0
        decimalOn = 0
        
        print(nativeMemory[numberIndex])
        numberIndex+=1
        
        
        
        if(sender.tag == 11)
        {
            display.text = display.text! + String("+")
            nativeMemoryforOperators.append(1) //1,2,3,4. 4-> max priority, 0->min priority
            operatorIndex+=1
        
        }
        if(sender.tag == 12)
        {
            display.text = display.text! + String("-")
            nativeMemoryforOperators.append(2)
            operatorIndex+=1
            
        }
        if(sender.tag == 13)
        {
            display.text = display.text! + String("*")
            nativeMemoryforOperators.append(3)
            operatorIndex+=1
            
        }
        if(sender.tag == 14)
        {
            display.text = display.text! + String("/")
            nativeMemoryforOperators.append(4)
            operatorIndex+=1
        }
        if(sender.tag == 19)
        {
            display.text = display.text! + String("^")
            nativeMemoryforOperators.append(7)
            operatorIndex+=1
        }
        

        
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        
        impact.impactOccurred()
        impact.impactOccurred()
        
        print("clearing display...")
        displayAnswer.text = String("(Answer goes here)")
        display.text = String("0.0")
        
        nativeMemory = []
        nativeMemoryforOperators = []
        numberIndex = 0
        operatorIndex = 0
        firstHit = true
        finalAnswer = 0
        bracketsMemory = []
        bracketsMemoryforOperators = []
        numberOfBrackets = 0
        temporaryNativeMemoryforOperators = []
        temporaryNativeMemory = []
        
    
    }
    
    func clearNativeMemory() {
        nativeMemoryforOperators = []
        nativeMemory = []
        numberIndex = 0
        operatorIndex = 0
    }
    
    
    @IBAction func equalToPressed(_ sender: UIButton) { //POP operator and nativeMemory list and compute
        
        display.text = ""
        
        nativeMemory.append(numberBuffer)
        numberBuffer = 0
        print(nativeMemory[numberIndex])
        
        print("equal to presssed...")
        
        computeExpression()
        
        finalAnswer = getFinalAnswer() // after computeExpression is executed, finalAnswer has no other use
        // IMPORTANT: Memory Plus is hit only after equalToPressed is executed, final answer is used to store for this operation
        
        clearNativeMemory()
        
    }
    
    func displayFinalAnswer(){
        
        print("final answer is:")
        print(nativeMemory.last!)
        displayAnswer.text = String(nativeMemory.last!)

        
    }
    
    func getFinalAnswer() -> Double{
        
        return nativeMemory.last!
    }
    
    func computeExpression(){
        
        popBrackets()
        
        popPower()
        
        popProduct()
        
        popDivision()
        
        popSubtraction()
        
        popAddition()
        
        print("computed expression...")
        
        displayFinalAnswer()
        
        firstHit = true
        
        
    }
    
    func popPower(){
        while (i <= nativeMemoryforOperators.count-1){
            
            
            if(nativeMemoryforOperators[i]==7){
                
                finalAnswer = pow(nativeMemory[i],nativeMemory[i+1])
                
                
                
                nativeMemory[i+1] = finalAnswer
                
                nativeMemory.remove(at: i)
                
                
                nativeMemoryforOperators.remove(at: i)
                
                finalAnswer = 0
                print("after ",i," iteration")
                print(nativeMemory)
                print(nativeMemoryforOperators)
                
                i = i-1
            }
            i = i+1
        }
        i=0
        
    }
    func popAddition(){
        
        while (i <= nativeMemoryforOperators.count-1){
            
            
            if(nativeMemoryforOperators[i]==1){
                finalAnswer = nativeMemory[i] + nativeMemory[i+1]
                nativeMemory[i+1] = finalAnswer
                
                nativeMemory.remove(at: i)
                
                
                nativeMemoryforOperators.remove(at: i)
                
                finalAnswer = 0
                print("after ",i," iteration")
                print(nativeMemory)
                print(nativeMemoryforOperators)
                
                i = i-1
            }
            i = i+1
        }
        i=0
    }
    
    func popSubtraction(){
        while (i <= nativeMemoryforOperators.count-1){
            
            if(nativeMemoryforOperators[i]==2){
                finalAnswer = nativeMemory[i] - nativeMemory[i+1]
                nativeMemory[i+1] = finalAnswer
                
                nativeMemory.remove(at: i)
                
                
                nativeMemoryforOperators.remove(at: i)
                
                finalAnswer = 0
                print("after ",i," iteration")
                print(nativeMemory)
                print(nativeMemoryforOperators)
                
                i = i-1
            }
            i = i+1
        }
        i=0
    }
    
    func popDivision(){
        while (i <= nativeMemoryforOperators.count-1){
            
            if(nativeMemoryforOperators[i]==4){
                finalAnswer = nativeMemory[i] / nativeMemory[i+1]
                nativeMemory[i+1] = finalAnswer
                
                nativeMemory.remove(at: i)
                
                
                nativeMemoryforOperators.remove(at: i)
                
                finalAnswer = 0
                print("after ",i," iteration")
                print(nativeMemory)
                print(nativeMemoryforOperators)
                
                i = i-1
            }
            i = i+1
        }
        i=0
        
    }
    
    func popProduct(){
        while (i <= nativeMemoryforOperators.count-1){
            
            if(nativeMemoryforOperators[i]==3){
                finalAnswer = nativeMemory[i] * nativeMemory[i+1]
                nativeMemory[i+1] = finalAnswer
                
                nativeMemory.remove(at: i)
                
                
                nativeMemoryforOperators.remove(at: i)
                
                finalAnswer = 0
                print("after ",i," iteration")
                print(nativeMemory)
                print(nativeMemoryforOperators)
                
                i = i-1
            }
            i = i+1
        }
        i=0
    }
    
    func popBrackets(){
        
        var saveMe: Int = 0
        while (i <= nativeMemoryforOperators.count-1){// Check for brackets first
            
            if(nativeMemoryforOperators[i]==5){ // open bracket found
                
                numberOfBrackets += 1
                print ("brackets found at", i)
                saveMe = i
                
                (bracketSolution,locationOfCloseBracket) = computeBrackets(currentElement: i+1)
                
                print("location of closed bracket is...", locationOfCloseBracket)
                print("location of open bracket is...", saveMe)
                
                reloadNativeMemory()
                
                fixExpression(start: saveMe, end: locationOfCloseBracket, answer: bracketSolution)
                
                print("expression fixed...")
                
                
                i = i-1
            }
            i = i+1
        }
        i=0
    }
    
    func computeBrackets( currentElement: Int) -> ( Double,  Int){
        
        print ("computing brackets...")
        
        temporaryNativeMemory = nativeMemory
        temporaryNativeMemoryforOperators = nativeMemoryforOperators
        
        var currentElementNew = currentElement
        
        while(nativeMemoryforOperators[currentElementNew] != 6) // run till closing bracket found...
        {
            // store the next operator
            bracketsMemoryforOperators.append(nativeMemoryforOperators[currentElementNew])
            
            //store the corresponding data elements
            bracketsMemory.append(nativeMemory[currentElementNew-numberOfBrackets])
            
            
            //increment counter
            currentElementNew += 1
        }
        
        
    
        
        bracketsMemory.append(nativeMemory[currentElementNew-numberOfBrackets])
        
        
        numberOfBrackets += 1
        
        print("finsihed popping elements inside the bracket(data and expressions)...")
        
        
        
        //store the main expression in temporary storage
        
        print("native memory is...")
        print(nativeMemory)
        print(nativeMemoryforOperators)
        
        
        
        print ("finsihed popping contents inside the bracket...")
        print ("printing brackets memory...")
        print (bracketsMemory)
        print (bracketsMemoryforOperators)
        
        
        nativeMemory = bracketsMemory
        nativeMemoryforOperators = bracketsMemoryforOperators
        
        print("computing brackets expression...")
        
        computeExpression()
        
        
        //displayFinalAnswer()
        
        
        return (getFinalAnswer(), currentElementNew)
    
    }
    func reloadNativeMemory(){
        nativeMemory = temporaryNativeMemory
        nativeMemoryforOperators = temporaryNativeMemoryforOperators
    }
    
    func fixExpression(start: Int, end: Int, answer: Double){ // to remove the brackets and everything inside it
        
        var j: Int = 1
        let x = start - numberOfBrackets + 2
        let y = end - numberOfBrackets + 1
        let numberOfIterations = y-x + 1
        
        
        
        // removing the opening bracket...
        nativeMemoryforOperators.remove(at: start)
        //removing all the old operators
        while (nativeMemoryforOperators[start] != 6){ // runs till it meets a closing bracket
            nativeMemoryforOperators.remove(at: start)
        }
        nativeMemoryforOperators.remove(at: start)
        //removing all the old data elements
        
        /*for i in stride(from: start - numberOfBrackets+2, to: end - numberOfBrackets, by: 1){
            
            nativeMemory.remove(at: i)
            
        }*/
        
        
        
        print ("number of data elements to be deleted", numberOfIterations)
        
        while(j <= numberOfIterations) // from 1 -> numberOfIterations
        {
            print ("removing", j, "element")
            nativeMemory.remove(at: x)
            j += 1
        }
        
        
        nativeMemory.insert(answer, at: start)
        
        print("expression fixed, printing new expression...")
        
        print(nativeMemory)
        print(nativeMemoryforOperators)
        
        bracketsMemory = []
        bracketsMemoryforOperators = []
        numberOfBrackets = 0
        
        //temporaryNativeMemory = nativeMemory
        //temporaryNativeMemoryforOperators = nativeMemoryforOperators
        
    }
}


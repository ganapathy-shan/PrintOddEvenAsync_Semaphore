//
//  PrintOddEvenAsync.swift
//  PrintOddEven_Sempahore
//
//  Created by Shanmuganathan on 01/11/19.
//  Copyright © 2019 Shanmuganathan. All rights reserved.
//

import UIKit

class PrintOddEvenAsync: NSObject
{

    let oddSemaphore = DispatchSemaphore(value: 1)
    let evenSemaphore = DispatchSemaphore(value: 0)
    
    let globalQueue = DispatchQueue(label: "Global", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)

    func createOddEvenAsyncTasks()
    {
        globalQueue.async {
            self.printEven()
        }
        globalQueue.async {
            self.printOdd()
        }
    }
        
        
    func printEven()
    {
        for i in 1...100
        {
            if(i % 2 == 0)
            {
                evenSemaphore.wait()
                print(i)
                oddSemaphore.signal()
            }
        }
    }
    
    func printOdd()
    {
        for i in 1...100
        {
            if(i % 2 == 1)
            {
                oddSemaphore.wait()
                print(i)
                evenSemaphore.signal()
            }
        }
    }
}


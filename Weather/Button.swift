//
//  Button.swift
//  Weather
//
//  Created by Siddhant Paliwal on 7/3/23.
//

import SwiftUI

struct CustomButton: View {
    var text:String;

    var body: some View {
        VStack(alignment: .leading) {
            Button (action:{
                print("hello");
            }).padding(10).background(Color.blue)
                Text(text).foregroundStyle(Color.white)
            }
            }
        }
    

    


struct Button_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Some shit")
    }
}

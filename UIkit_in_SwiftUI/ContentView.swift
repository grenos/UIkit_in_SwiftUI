//
//  ContentView.swift
//  UIkit_in_SwiftUI
//
//  Created by Vasileios Gkreen on 29/02/2020.
//  Copyright © 2020 Vasileios Gkreen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShowImagePicker = false
    @State var image: Image? = nil
    
    var body: some View {
        
        VStack{
            
            if image == nil {
                Image(systemName: "person.fill")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding(.bottom, 10)
            } else {
                     image?.resizable()
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding(.bottom, 10)
            }
            
            Button("Choose Profile Image"){
                self.isShowImagePicker.toggle()
            }
            
        }
        .sheet(isPresented: $isShowImagePicker, content: {
            ImagePicker.shared.view
        }).onReceive(ImagePicker.shared.$image) { image in
            self.image = image
        }
           
            
        
 
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

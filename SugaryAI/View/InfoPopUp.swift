//
//  InfoPopUp.swift
//  SugaryAI
//
//  Created by Shatha Almukhaild on 11/09/1446 AH.
//

import SwiftUI

struct InfoPopUp: View {
    //   public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    @Binding var showPopUp : Bool
    @State private var selection = 0
    let images = ["1","2","3","4"]
    let Instruction = ["Not multi labels showing","Not too far ","Not too close","Best shot !" ]

    

    var body: some View {
        ZStack{
        
          //  if showPopUp{
                Color(.black)
                    .opacity(0.7)
                    .ignoresSafeArea()
                
            
                VStack{
                    
                    TabView(selection: $selection){
                        
                        ForEach(0..<images.count,id:\.self){ i in
                            VStack{
                                Image(images[i])
                                    .resizable().padding()
                                 //   .scaledToFill()
                                    //.aspectRatio(contentMode: .fit)
                                    .frame(width: 340, height: 300)
                                    
                            
                                
                                Text(Instruction[i])
                                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                                 
                               
                                    .padding(.bottom,50)
                                    
                               
                            }
                         
                            
                        }
                        
                   
                        
                    }.tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                        .padding(.bottom,10)

//                        .onReceive(timer, perform: { _ in
//                            withAnimation{
//                                print("Selection is ", selection)
//                                selection = selection < 4 ? selection + 1 : 0
//                            }
//                        })//
           
                    
                 
                 
                        
                    Button("OK"){
                        showPopUp=false
                    }.buttonStyle(PrimaryButton())

                    Spacer()
                
                }
                .frame(width:310,height: 450)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
               
                
           // }
        }
    }
}

// to force the indicator colors 
struct InfoPopUpPreviewWrapper: View {
    @State private var showPopUp = true
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.blue  // Active indicator color
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray   // Inactive indicator color
        UIPageControl.appearance().backgroundStyle = .minimal  // Controls background visibility
    }
    
    var body: some View {
        InfoPopUp(showPopUp: $showPopUp)
    }
}

#Preview {
    InfoPopUpPreviewWrapper()
}

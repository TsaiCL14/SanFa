## 可以撰寫進貨
## 需要有當天的日期

## 使用的資料會是 getPurchase

fluidPage(
  column(4,
         fluidRow(
           dateInput('Purchase_date','日期',language = 'zh-TW',format = 'yyyy-mm-dd'), # 需要有日期，可以為「忘記填寫」這件事情做準備。
           selectizeInput('Purchase_item', '品項', choices = unique(NewStock_df$品項),selected = '',  # 進貨這件事情是可以發生進新的品項，是需要creat的。
                          options = list(creat = TRUE,placeholder = '挑選一個或新增')),
           numericInput('Purchase_cost','成本',value = 0,min = 0,max = Inf), # 進貨時如果可以需要每次都加成本(進貨的價格)。
           textAreaInput('Purchase_remark','備註',placeholder = '寫下你想為這個品項紀錄的事項！'), 
           actionButton('Purchase_go',label = '上傳資料',class = 'btn_success'),
           textOutput('Purchase_goText')
         )# fluidRow
  ), # column
  column(8,
         fluidRow(
           DTOutput('Purchase_table') # 可能需要注意每次填入的資料的日期編排。
         )# colse fluidRow
  )# column
  
) #close fluidPage
## 可以撰寫進貨
## 需要有當天的日期

## 使用的資料會是 getPurchase

fluidPage(
  column(4,
         fluidRow(
           dateInput('Purchase_date','日期',language = 'zh-TW',format = 'yyyy-mm-dd'),
           # 需要先挑選一個品項；有把creat的參數拿掉，在這個位置不可以發生新增
           selectizeInput('Purchase_item', '品項', choices = unique(NewStock_df$品項),selected = '', 
                          options = list(creat = TRUE,placeholder = '挑選一個或新增')),
           # numericInput('Purchase_price','售價',value = 0,min = 0,max = Inf),
           numericInput('Purchase_cost','成本',value = 0,min = 0,max = Inf),
           textAreaInput('Purchase_remark','備註',placeholder = '寫下你想為這個品項紀錄的事項！'),
           actionButton('Purchase_go',label = '上傳資料',class = 'btn_success'),
           textOutput('Purchase_goText')
         )# fluidRow
  ), # column
  column(8,
         fluidRow(
           DTOutput('Purchase_table')
         )# colse fluidRow
  )# column
  
) #close fluidPage
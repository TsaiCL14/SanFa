## 把得到的所有品項 加入價格的資料
## 需要有填寫價格時的時間點

## 要使用的資料是 NewStock
## NewStock_df (在ui_getNewStock中有用到，就不再讀了)
fluidPage(
  column(4,
    fluidRow(
      dateInput('StockPrice_date','日期',language = 'zh-TW'),
      # 需要先挑選一個品項；有把creat的參數拿掉，在這個位置不可以發生新增
      selectizeInput('StockPrice_item', '品項', choices = unique(NewStock_df$品項),selected = '', 
                     options = list(creat = TRUE,placeholder = '挑選一個或新增')),
      numericInput('StokPrice_price','售價',value = 0,min = 0,max = Inf),
      numericInput('StokPrice_cost','成本',value = 0,min = 0,max = Inf),
      textAreaInput('StokPrice_remark','備註',placeholder = '寫下你想為這個品項紀錄的事項！'),
      actionButton('StockPrice_go',label = '上傳資料',class = 'btn_success'),
      textOutput('StockPrice_goText')
    )# fluidRow
  ), # column
  column(8,
    fluidRow(
      DTOutput('StockPrice_table')
    )# colse fluidRow
  )# column
  
) #close fluidPage
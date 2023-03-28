## 把得到的所有品項 加入價格的資料
## 需要有填寫價格時的時間點
# 已經有 NewStock的資料 
NewStock_cement <- readRDS('data/NewStock_cement.rds') # 會用到的資料目前只有cement
## 要使用的資料是 NewStock
## NewStock_df (在ui_getNewStock中有用到，就不再讀了)
fluidPage(
    #### column1 ########
    column(2,
           style = 'background-color: #E8E8E8',
           # 左邊欄位的title 
           div(style = 'display: inline-block;vertical-align:top;text-align:center; width: 100%;',
               strong("建立價格"),
           ),# close div
           br(),
           ####### input ############
           ## set 日期 input (都會有預設當天，但需要有一個紀錄) 
           div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
               dateInput('StockPrice_date','日期',
                         language = 'zh-TW',
                         format = 'yyyy-mm-dd')
           ),# close div
           br(),
           ## set 品項名稱 input
           div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
               selectizeInput('StockPrice_item', '品項', 
                              choices = c('',unique(NewStock_cement$品項)),
                              selected = "", 
                              options = list(# create = TRUE,
                                             placeholder = '挑選一個'))
           ),# close div
           br(),
           ## set 品項規格 input
           div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
               selectizeInput('StockPrice_specification', '規格', 
                              choices = c('',unique(NewStock_cement$規格)),
                              selected = "", 
                              options = list(# create = TRUE,
                                             placeholder = '挑選一個'))
           ),# close div
           br(),
           ## set 售價 input
           div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
               numericInput('StockPrice_price','售價',
                            value = 0,
                            min = 0,
                            max = Inf)
           ),# close div
           br(),
           ## set 貨品的成本 input
           div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
               numericInput('StockPrice_cost','成本',
                            value = 0,
                            min = 0,
                            max = Inf)
           ),# close div
           br(),
           ## set 備註 input
           div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
               textAreaInput('StockPrice_remark','備註',
                             placeholder = '寫下你想為這個品項紀錄的事項！')
               
           ),# close div
           br(),
           div(
             style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             div(
               style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
               actionButton('StockPrice_go', '上傳資料(更新表格)', class = 'btn_success')
             ),
             div(
               style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
               textOutput('StockPrice_goText')
             )
           )
    ), # close column
    ###### column 2 (output)####################
  column(8,
    fluidRow(
      DTOutput('StockPrice_table')
    )# colse fluidRow
  )# column
  
) #close fluidPage
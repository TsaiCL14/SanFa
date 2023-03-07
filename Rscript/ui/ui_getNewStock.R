## 一個從新撰寫現有存貨的頁面

## 在假設沒有資料的時候
NewStock_df <- if(!file.exists("data/NewStock.rds")){
  ""
}else{
 readRDS("data/NewStock.rds") 
}

fluidPage(
  #### column1 ########
  column(2,
         style = 'background-color: #E8E8E8',
         # 左邊欄位的title 
         div(style = 'display: inline-block;vertical-align:top;text-align:center; width: 100%;',
             strong("建立存貨"),
         ),# close div
         br(),
         ####### input ############
         ## set 品項 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('NewStock_type', '品項的種類', 
                            choices = '',
                            options = list(maxOptions = 5, 
                                           create = TRUE,
                                           placeholder = '挑選一個或新增')
                            ) 
         ),# close div
         br(),
         ## set 品項名稱 input
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('NewStock_item', '品項的名稱', 
                            choices = '', 
                            options = list(maxOptions = 5, 
                                           create = TRUE,
                                           placeholder = '新增')
                            )
         ),# close div
         br(),
         ## set 數量 input
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             numericInput('NewStock_quantity', '品項的數量',
                          value = 0,
                          min = 0,
                          max = 10000)
         ),# close div
         br(),
         ## set 品項的單位 input
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('NewStock_unit', '品項的單位',
                            choices = '',
                            options = list(maxOptions = 5, 
                                           create = TRUE,
                                           placeholder = '挑選一個或新增')
                            )
             
         ),# close div
         br(),
         div(
           style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
           div(
             style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             actionButton('MakeNewStock_go', '上傳資料', class = 'btn_success')
           ),
           div(
             style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             textOutput('MakeNewStoc_goText')
           )
         )
         
  ), # close column
  ######### column 2  (output) ###################
  column(10,
    fluidRow( # 放現在有輸入的資料
      DTOutput('NewStock_table')
    )# close fluidRow
  )
  
  
)# close fluidPage
## 可以撰寫進貨
## 需要有當天的日期

## 使用的資料會是 getPurchase

fluidPage(
  #### column1 ########
  column(2,
         style = 'background-color: #E8E8E8',
         # 左邊欄位的title 
         div(style = 'display: inline-block;vertical-align:top;text-align:center; width: 100%;',
             strong("建立進貨"),
         ),# close div
         br(),
         ####### input ############
         ## set 日期 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             dateInput('Purchase_date','日期',
                       language = 'zh-TW',
                       format = 'yyyy-mm-dd')
         ),# close div
         br(),
         ## set 品項 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('Purchase_type', '品項的種類', 
                            choices = '',selected = '',
                            options = list(maxOptions = 5, 
                                           create = TRUE,
                                           placeholder = '挑選一個或新增')
             ) 
         ),# close div
         br(),
         ## set 品項名稱 input
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             conditionalPanel(
               condition = 'input.Purchase_type == "磁磚"',
               selectizeInput('Purchase_item','廠商名稱',
                              choices = '',selected = '',
                              options = list(creat = TRUE,
                                             placeholder = '挑選一個或新增')
                              ),
               selectizeInput('Purchase_item', '編號',
                              choices = unique(NewStock_df$品項),
                              selected = '',
                              options = list(creat = TRUE,
                                             placeholder = '挑選一個或新增')

                              )
             ),
             conditionalPanel(
               condition = 'input.Purchase_type == "泥作"',
               selectizeInput('Purchase_item', '品項名稱',
                              choices = unique(NewStock_df$品項),
                              selected = '',  
                              options = list(creat = TRUE,
                                             placeholder = '挑選一個或新增')
               ) 
             )
            
         ),# close div
         br(),
         ## set 數量 input
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             numericInput('Purchase_quantity', '品項的數量',
                          value = 0,
                          min = 0,
                          max = 10000)
         ),# close div
         br(),
         ## set 成本 input
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             numericInput('Purchase_cost','成本', # 暫時先沒有考慮進貨的部份
                          value = 0,
                          min = 0,
                          max = Inf)
         ),# close div
         br(),
         ## set 品項的單位 input
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('Purchase_unit', '品項的單位',
                            choices = '',selected = '',
                            options = list(maxOptions = 5, 
                                           create = TRUE,                         
                                           placeholder = '挑選一個或新增')
             )
             
         ),# close div
         br(),
         ## set 備註 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             textAreaInput('Purchase_remark','備註',
                           placeholder = '寫下你想為這個品項紀錄的事項！')
         ),# close div
         br(),
         div(style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
           div(style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
               actionButton('Purchase_go', '上傳資料', class = 'btn_success')
               ),
           div(style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             textOutput('Purchase_goText')
             )
         ) # close div 
         ), # close column
  ######### column2 (output)#########
  column(8,
         fluidRow(
           DTOutput('Purchase_table') # 可能需要注意每次填入的資料的日期編排。
         )# colse fluidRow
  )# column
  
) #close fluidPage
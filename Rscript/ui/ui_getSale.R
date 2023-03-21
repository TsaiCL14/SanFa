## 撰寫出售的ui

# 需要紀錄的資料有：購買人(固定客戶、外來客)、地點(工地簡稱)、購買的品項(需要依次不斷增加，可以先設定10個項目，如果超過就下一筆資料就好)
# 每一次的紀錄(一張三聯單)
# 在這裡需要有條件
# 



fluidPage(
  #### column1 ########
  column(2,
         style = 'background-color: #E8E8E8',
         # 左邊欄位的title 
         div(style = 'display: inline-block;vertical-align:top;text-align:center; width: 100%;',
             strong("建立出售"),
         ),# close div
         br(),
         ####### input ############
         ## set 日期 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             dateInput('Sale_date','日期',
                       language = 'zh-TW',
                       format = 'yyyy-mm-dd')
         ),# close div
         br(),
         ## set 客戶 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('Sale_guest','客戶',
                            choices = '外來客', # 需要有一個外來客的選項
                            options = list(create = TRUE,
                                           placeholder = '挑選一個'))
         ),# close div
         br(),
         ## set 品項 input 主要是針對長期配合的師傅，可以方便管理跟他們收得貨款內容
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('Sale_location','地點',
                            choices = '', 
                            options = list(create = TRUE,
                                           placeholder = '挑選一個'))
         ),# close div
         br(),
         ### 品項 跟 數量 1
         fluidRow(
           column(8,
                  selectizeInput('Sale_item1', '品項名稱',
                                 choices = unique(NewStock_df$品項),
                                 selected = '',
                                 options = list(create = TRUE,placeholder = '挑選一個或新增'))
           ),
           column(4,
                  numericInput('Sale_quantity1', '數量',
                               value = 0,
                               min = 0,
                               max = 10000),
           )
         ), # close fluidRow
         ## 新增的品項跟數量 2 
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 0'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item2', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity2', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         ## 新增的品項跟數量 3 
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 1'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item3', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity3', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         ## 新增的品項跟數量 4 
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 2'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item4', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity4', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         ## 新增的品項跟數量 5 
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 3'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item5', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity5', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         ## 新增的品項跟數量 6 
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 4'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item6', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity6', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         ## 新增的品項跟數量 7 
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 5'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item7', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity7', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         ## 新增的品項跟數量 8 
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 6'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item8', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity8', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         ## 新增的品項跟數量 9
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 7'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item9', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity9', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         ## 新增的品項跟數量 10
         conditionalPanel(
           condition = paste0('input.Sale_NewItem > 8'),
           fluidRow(
             column(8,
                    selectizeInput('Sale_item10', '品項名稱',
                                   choices = unique(NewStock_df$品項),
                                   selected = '',
                                   options = list(create = TRUE,placeholder = '挑選一個或新增'))
             ),
             column(4,
                    numericInput('Sale_quantity10', '數量',
                                 value = 0,
                                 min = 0,
                                 max = 10000),
             )
           ), # close fluidRow
         ), # close conditionalPanel
         # 新增的品項的按鈕
         div(style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             div(style = 'display: inline-block;vertical-align:top;text-align: center; width: 100%;',
                 actionButton('Sale_NewItem', '新增購買品項', class = 'btn_success')
             )
         ),
         
         ## set 備註 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             textAreaInput('Sale_remark','備註',
                           placeholder = '寫下你想為這個品項紀錄的事項！')
         ),
         br(),
         ## set 上傳按鈕 
         div(style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             div(
               style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
               actionButton('Sale_go', '上傳資料', class = 'btn_success')
             ),
             div(
               style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
               textOutput('Sale_goText')
             )
         )
  ), # close column
  #### column 2 (output)###############
  column(8,
         fluidRow(
           DTOutput('Sale_table') # 可能需要注意每次填入的資料的日期編排。
         )# colse fluidRow
  )# column
  
) #close fluidPage
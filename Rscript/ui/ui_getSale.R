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
                            options = list(creat = TRUE,
                                           placeholder = '挑選一個'))
         ),# close div
         br(),
         ## set 品項 input 主要是針對長期配合的師傅，可以方便管理跟他們收得貨款內容
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('Sale_location','地點',
                            choices = '', 
                            options = list(creat = TRUE,
                                           placeholder = '挑選一個'))
         ),# close div
         br(),
         # ## set 品項名稱 input
         # div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
         #     selectizeInput('Sale_item', '品項名稱',
         #                    choices = unique(NewStock_df$品項),
         #                    selected = '',  
         #                    options = list(creat = TRUE,
         #                                   placeholder = '挑選一個或新增')
         #     ) 
         # ),# close div
         # br(),
         # ## set 數量 input
         # div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
         #     numericInput('Sale_quantity', '品項的數量',
         #                  value = 0,
         #                  min = 0,
         #                  max = 10000)
         # ),# close div
         
           div(style = 'display: flex; align-items: center;',
           # div(style = 'display: inline-block; align-items: center;',
               div(style = 'flex: 0.5; margin-right: 50%;',
                   selectizeInput('Sale_item', '品項名稱',
                                  choices = unique(NewStock_df$品項),
                                  selected = '',
                                  options = list(create = TRUE,
                                                 placeholder = '挑選一個或新增')
                   )
               ),
               div(style = 'flex: 0.5; margin-left:50%;',
                   numericInput('Sale_quantity', '品項的數量',
                                value = 0,
                                min = 0,
                                max = 10000
                   )
               )
           ),
         
         br(),
         ## set 備註 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             textAreaInput('Purchase_remark','備註',
                           placeholder = '寫下你想為這個品項紀錄的事項！')
         ),
         br(),
         ## set 上傳按鈕 
         div(style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
         div(
           style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             actionButton('Purchase_go', '上傳資料', class = 'btn_success')
         ),
         div(
           style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             textOutput('Purchase_goText')
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
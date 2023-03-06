## 撰寫出售的ui

# 需要紀錄的資料有：購買人(固定客戶、外來客)、地點(工地簡稱)、購買的品項(需要依次不斷增加，可以先設定10個項目，如果超過就下一筆資料就好)
# 每一次的紀錄(一張三聯單)
# 在這裡需要有條件
# 



fluidPage(
  column(4,
         fluidRow(
           dateInput('Sale_date','日期',language = 'zh-TW',format = 'yyyy-mm-dd'), # 需要有日期，可以為「忘記填寫」這件事情做準備。
           selectizeInput('Sale_guest','客戶',choices = '外來客', options = list(creat = TRUE, placeholder = '挑選一個')), # 客人有可能會有新的，需要填寫。
           selectizeInput('Sale_location','地點',choices = '', options = list(creat = TRUE, placeholder = '挑選一個')), # 需要根據上面的客戶做變化，同時可以新增。
           
           
             selectizeInput('Sale_item', '品項', choices = unique(NewStock_df$品項),selected = '',  # 每一筆購買的品項，不可能會買到沒有的東西，不用creat。
                            options = list(placeholder = '挑選一個')),
             numericInput('Sale_count','數量',value = 0,min = 0,max = Inf), # 購買的數量。  
             # 第二個品項，在填寫第一個品項後會新增的
             conditionalPanel(
                   condition = paste0("input.",'Sale_goGetNew', "> 0 "),
                   numericInput('Sale_count',
                             label = '數量',value = 0,min = 0,max = Inf
                   )# , # close input
                 ), # close conditionalPanel
            # 購買的品項 跟 數量 可能會需要有很多 所以先隔開來
           
           actionButton('Sale_goGetNew',label = '新增品項',class = 'btn_success'),
           textAreaInput('Sale_remark','備註',placeholder = '寫下你想為這個品項紀錄的事項！'), # 預留在最後的
           actionButton('Sale_go',label = '上傳資料',class = 'btn_success'),
           textOutput('Sale_goText')
         )# fluidRow
  ), # column
  column(8,
         fluidRow(
           DTOutput('Sale_table') # 可能需要注意每次填入的資料的日期編排。
         )# colse fluidRow
  )# column
  
) #close fluidPage
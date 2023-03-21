## 一個從新撰寫現有存貨的頁面

## 在假設沒有資料的時候
## read data 
NewStock_cement <- readRDS(file = 'data/NewStock_cement.rds') 
NewStock_tiles <- readRDS(file = 'data/NewStock_tiles.rds')

fluidPage(
  #### column1 ########
  column(2,
         style = 'background-color: #E8E8E8',
         div(style = 'display: inline-block;vertical-align:top;text-align:center; width: 100%;',
             strong("建立存貨"),
         ),# close div
         br(),
         ## set 種類 input 
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             selectizeInput('NewStock_type', '品項的種類', 
                            choices = c('泥作','磁磚'),
                            options = list( 
                              # create = TRUE,
                              maxOptions = 1000,
                              placeholder = '挑選一個或新增'
                            )
             ) 
         ),# close div
         ## 第一個conditionPanel
         div(style = 'display: inline-block;vertical-align:top;text-align:left; width: 100%;',
             conditionalPanel(
               condition = 'input.NewStock_type == "泥作"',
               selectizeInput('NewStock_item_cement', '品項名稱',
                              choices = c(''),
                              options = list(create = TRUE,
                                             maxOptions = 1000,
                                             placeholder = '挑選一個或新增')
               ),
               selectizeInput('NewStock_specification_cement', '規格',
                              choices = c(''),
                              options = list(create = TRUE,
                                             maxOptions = 1000,
                                             placeholder = '挑選一個或新增')
               ),
               numericInput('NewStock_quantity_cement','數量',
                            value = 0,
                            min = 0,
                            max = 10000),
               selectizeInput('NewStock_unit_cement','單位',
                              choices = c(''),
                              options = list(create = TRUE,
                                             maxOptions = 1000,
                                             placeholder = '挑選一個或新增'
                              )
               ) # 每一個品項的單位可能都會不同
             ), # close conditionalPanel
             conditionalPanel(
               condition = 'input.NewStock_type == "磁磚"',
               selectizeInput('NewStock_item_tiles','廠商名稱',
                              choices = c(""),
                              options = list(create = TRUE,
                                             maxOptions = 1000,
                                             placeholder = '挑選一個或新增'
                              )
               ), # close selectizeInput
               selectizeInput('NewStock_specificaiton_tiles', '規格',
                              choices = c(""),
                              options = list(create = TRUE,
                                             maxOptions = 1000,
                                             placeholder = '挑選一個或新增'
                              )
               ), # close selectizeInput
               selectizeInput('NewStock_number_tiles', '編號',
                              choices = c(''),
                              options = list(create = TRUE,
                                             maxOptions = 1000,
                                             placeholder = '挑選一個或新增'
                              )
               ),# close selectizeInput
               numericInput('NewStock_quantity_tiles','數量',
                            value = 0,
                            min = 0,
                            max = 10000),
               numericInput('NewStock_boxes_tiles','箱數',
                            value = 0,
                            min = 0,
                            max = Inf),
               numericInput('NewStock_capacity_tiles','容量',
                            value = 0,
                            min = 0,
                            max = Inf),
               numericInput('NewStock_piece_tiles','散片',
                            value = 0,
                            min = 0,
                            max = Inf)
             )# close conditionalPanel
         ), # close div
         br(),
         br(),
         div(
           style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
           div(
             style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             actionButton('NewStock_go', '上傳資料', class = 'btn_success')
           ),
           div(
             style = 'display: inline-block; vertical-align: top; text-align: center; margin: auto; width: 100%;',
             textOutput('NewStock_goText')
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
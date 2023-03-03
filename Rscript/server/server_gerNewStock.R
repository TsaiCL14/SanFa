## 建立新倉庫時需要的反應
source('Rscript/function/AutoTable.R')
## 寫入資料時需要疊起來的部分
######## Prepare ################

## 字串的反應 / AutoTable的資料更新
text_Reactive <-  eventReactive(input$MakeNewStock_table,{
  # 只要有一項沒有輸入或錯誤時就不會新增資料
  if(input$NewStock_type == ''|input$NewStock_item == ''|input$NewStock_quantity == 0|input$NewStock_unit == ''){
    print('未填寫完成')
  }else{
    AutoTable(TableName = 'NewStock',
              '種類' = input$NewStock_type,
              '品項' = input$NewStock_item,
              '數量' = input$NewStock_quantity,
              '單位' = input$NewStock_unit)
    print("upload")
  }
})

## 可以不斷的更新DT讀取資料表 
loading_NewStock <- eventReactive(input$MakeNewStock_table,{
  ## 可以讀資料的部分
  df <- readRDS('data/NewStock.rds')
  return(df)
})
###### output #################
## output 上傳資料後會出來的字
output$Button_NewStock <- renderText({
  text_Reactive()
})
## output 右邊的資料表
output$NewStock_table <- renderDataTable({
  df <- if(input$MakeNewStock_table == 0){
    readRDS('data/NewStock.rds')
  }else{
    loading_NewStock()
  }
  DT::datatable(df)
})

######## reset input ####################
observeEvent(input$MakeNewStock_table,{ # 用按鈕反應要更新的內容
  ### 需要隨時更新複選資料中會多的東西
  df <- readRDS('data/NewStock.rds')
  updateSelectizeInput(session,inputId = 'NewStock_type',choices = unique(df$種類), server = TRUE,selected = '')
  updateSelectizeInput(session,inputId = 'NewStock_item',choices = unique(df$品項), server = TRUE,selected = '')
  updateSelectizeInput(session,inputId = 'NewStock_unit',choices = unique(df$單位), server = TRUE,selected = '')
  updateNumericInput(session,inputId = 'NewStock_quantity',value = 0)
})
######### reset output ###################
# output$Button_NewStock <- renderText({
#   text_Reactive()
# })
# observeEvent(input$NewStock_type != '',{
#   updateTextInput(session,inputId = 'Button_NewStock',)
# })

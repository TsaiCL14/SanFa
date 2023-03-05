## 紀錄現在有的品項的售價
source('Rscript/function/AutoTable.R')
AutoTable('StockPrice')
######## Prepare ################
## 把需要有的反應式 eventReactive、observer...

## 當按了上傳會做的事情
SP_goText <- eventReactive(input$StockPrice_go,{
  if(input$StockPrice_price == 0){
    print('未填寫完成')
  }else{
    AutoTable(TableName = 'StockPrice',
              '日期' = paste0(input$StockPrice_date),
              '品項' = input$StockPrice_item,
              '售價' = input$StockPrice_price,
              '成本' = input$StockPrice_cost,
              '備註' = input$StockPrice_remark)
    print(input$StockPrice_date)
    print("upload")
  }
  
})

## 要匯出的表格

loading_StockPrice <- eventReactive(input$StockPrice_go,{
  ## 可以讀資料的部分
  df <- readRDS('data/StockPrice.rds')
  return(df)
})

######## output #################

output$StockPrice_goText <- renderText({
  SP_goText()
})
## output 右邊的資料表
output$StockPrice_table <- renderDataTable({
  df <- if(input$StockPrice_go == 0){
    readRDS('data/StockPrice.rds')
  }else{
    loading_StockPrice()
  }
  
  DT::datatable(df)
})

######## reset ################
observeEvent(input$StockPrice_go,{ # 用按鈕反應要更新的內容
  ### 需要隨時更新複選資料中會多的東西
  df <- readRDS('data/NewStock.rds')
  updateSelectizeInput(session,inputId = 'StockPrice_item',choices = unique(df$品項), server = TRUE,selected = '')
  updateNumericInput(session,inputId = 'StockPrice_price',value = 0,min = 0,max = Inf)
  updateNumericInput(session,inputId = 'StockPrice_cost',value = 0,min = 0,max = Inf)
  updateTextAreaInput(session,inputId = 'StockPrice_remark',placeholder = '寫下你想為這個品項紀錄的事項！' )
})
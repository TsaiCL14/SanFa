## 紀錄現在有的品項的售價
source('Rscript/function/AutoTable.R')
AutoTable('StockPrice')
######## Prepare ################
## 把需要有的反應式 eventReactive、observer...

## 當按了上傳會做的事情
SP_goText <- eventReactive(input$StockPrice_go,{
  if(input$StokPrice_price == 0|input$StokPrice_cost == 0){
    print('未填寫完成')
  }else{
    AutoTable(TableName = 'StockPrice',
              '日期' = input$StcokPrice_date,
              '品項' = input$StcokPrice_item,
              '售價' = input$StcokPrice_price,
              '成本' = input$StcokPrice_cost,
              '備註' = input$StcokPrice_remark)
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
  updateNumericInput(session,inputId = 'StokPrice_price',value = 0)
  updateNumericInput(session,inputId = 'StokPrice_cost',value = 0)
})
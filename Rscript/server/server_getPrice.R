# 這一張的目的是想要保留資料裡面的成本 跟 價格
# 價格為目的 ，在看成本
# 表格有 泥作  跟  磁磚 
# 先針對泥作就好 

## 建立新倉庫時需要的反應
source('Rscript/function/AutoTable.R')
## 需要先資料表創建出來
AutoTable(TableName = "getPrice_cement") # 先確定有沒有泥作價格的表格

# 寫入資料時需要疊起來的部分
#### input 的分類
## NewStock_type 有兩種 
## 泥作：cement

######## Prepare ################

## 字串的反應 / AutoTable的資料更新
## 需要有兩個反應
getPrice_text_Reactive <-  eventReactive(input$StockPrice_go,{
  ### 分成兩個
  # 1. cement
  # if(input$NewStock_type == '泥作'){
    # print('進行泥作')
    if(input$StockPrice_item == ''|input$StockPrice_price == 0){
      print('未填寫完成')
    }else{
      print("do AutoTable")
      AutoTable(TableName = 'getPrice_cement',
                '日期' = paste0(input$StockPrice_date), # cha
                '品項' = input$StockPrice_item, # cha
                '規格' = input$StockPrice_specification, # cha
                '售價' = input$StockPrice_price, # num
                '成本' = input$StockPrice_cost, # cha
                '備註' = input$StockPrice_remark
      )
      print('上傳成功')
    }
  # } # close if '泥作'
  
}) # close eventReactive

## 可以不斷的更新DT讀取資料表 
loading_getPrice <- eventReactive(input$StockPrice_go,{
  ## 可以讀資料的部分
  df <- readRDS('data/getPrice_cement.rds')
  
  return(df)
})

###### output #################
## output 上傳資料後會出來的字
output$StockPrice_goText <- renderText({
  getPrice_text_Reactive()
})
## output 右邊的資料表
output$StockPrice_table <- renderDataTable({
  df <- loading_getPrice()
  DT::datatable(df)
})

######## reset input ####################
observeEvent(input$StockPrice_go,{ # 用按鈕反應要更新的內容
  ### 需要隨時更新複選資料中會多的東西
  ## 泥作
  # updateConditionalPanel(session, condition = "input.NewStock_type")
  # getPrice_cement <- readRDS('data/getPrice_cement.rds')
  NewStock_cement <- readRDS('data/NewStock_cement.rds') # 會用到的資料目前只有cement
  # if(dim(getPrice_cement)[1]>0){
    updateDateInput(session,inputId = 'StockPrice_date')
    updateSelectizeInput(session,inputId = 'StockPrice_item',choices = unique(NewStock_cement$品項), server = TRUE,selected = '')
    updateSelectizeInput(session,inputId = 'StockPrice_specification',choices = unique(NewStock_cement$規格), server = TRUE,selected = '')
    updateNumericInput(session,inputId = 'StockPrice_price',value = 0,min = 0,max = Inf)
    updateNumericInput(session,inputId = 'StockPrice_cost',value = 0,min = 0,max = Inf)
    updateTextAreaInput(session,inputId = 'StockPrice_remark',placeholder = '寫下你想為這個品項紀錄的事項！' )
  # }
  
  
})
######### reset output ###################

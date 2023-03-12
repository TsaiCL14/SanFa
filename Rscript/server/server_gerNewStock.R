## 建立新倉庫時需要的反應
source('Rscript/function/AutoTable.R')
## 需要先資料表創建出來
AutoTable(TableName = "NewStock_cement") # 先確定有沒有泥作的表格
AutoTable(TableName = "NewStock_tiles") # 先確定有沒有磁磚的表格
## 寫入資料時需要疊起來的部分
#### input 的分類
## NewStock_type 有兩種 
## 泥作：cement
## 磁磚：tiles
######## Prepare ################

## 字串的反應 / AutoTable的資料更新
## 需要有兩個反應
text_Reactive <-  eventReactive(input$MakeNewStock_table,{
  ### 分成兩個
  # 1. cement
  if(input$NewStock_type == '泥作'){
    if(input$NewStock_item_cement == ''|input$NewStock_quantity_cement == 0|input$NewStock_unit_cement == ""){
      print('未填寫完成')
    }else{
      AutoTable(TableName = 'NewStock_cement',
                '品項' = input$NewStock_item_cement, # cha
                '規格' = input$NewStock_specification_cement, # cha
                '數量' = input$NewStock_quantity_cement, # num
                '單位' = input$NewStock_unit_cement # cha
      )
    }
  }
  # 2. tiles
  if(input$NewStock_type == '磁磚'){
    if(input$NewStock_item_tiles == ""|input$NewStock_number_tiles == ""|input$NewStock_boxes_tiles == 0){
      print('未填寫完成')
    }else{
      AutoTable(TableName = 'NewStock_tiles',
                '廠商名稱' = input$NewStock_item_tiles, # cha
                '規格' = input$NewStock_specificaiton_tiles, # cha
                '編號' = input$NewStock_number_tiles, # cha
                # '數量' = input$NewStock_quantity_tiles,
                '箱數' = input$NewStock_boxes_tiles, # num
                # 如果下面兩個為0時用NA替代
                '容量' = ifelse(input$NewStock_capacity_tiles == 0,NA,input$NewStock_capacity_tiles), # num
                '散片' = ifelse(input$NewStock_piece_tiles == 0,NA,input$NewStock_piece_tiles) # num
      )
    }
    
  }
  
})

## 可以不斷的更新DT讀取資料表 
loading_NewStock <- eventReactive(input$MakeNewStock_go,{
  ## 可以讀資料的部分
  if(input$NewStock_type == '泥作'){
    df <- readRDS('data/NewStock_cement.rds')
  }
  if(input$NewStock_type == '磁磚'){
    df <- readRDS('data/NewStock_tiles.rds')
  }
  return(df)
})

###### output #################
## output 上傳資料後會出來的字
output$Button_goText <- renderText({
  text_Reactive()
})
## output 右邊的資料表
output$NewStock_table <- renderDataTable({
  df <- if(input$MakeNewStock_go == 0){
    if(input$NewStock_type == '泥作'){
      readRDS('data/NewStock_cement.rds')
    }
    if(input$NewStock_type == '磁磚'){
      readRDS('data/NewStock_tiles.rds')
    }
  }else{
    loading_NewStock()
  }
  DT::datatable(df)
})

######## reset input ####################
observeEvent(input$MakeNewStock_go,{ # 用按鈕反應要更新的內容
  ### 需要隨時更新複選資料中會多的東西
  ## 泥作
  cement <- readRDS('data/NewStock_cement.rds')
  updateSelectizeInput(session,inputId = 'NewStock_item_cement',choices = unique(cement$品項), server = TRUE,selected = '')
  updateSelectizeInput(session,inputId = 'NewStock_specification_cement',choices = unique(cement$規格), server = TRUE,selected = '')
  updateNumericInput(session,inputId = 'NewStock_quantity_cement',value = 0,min = 0,max = Inf)
  updateSelectizeInput(session,inputId = 'NewStock_unit_cement',choices = unique(cement$單位), server = TRUE,selected = '')
  ## 磁磚s
  tiles <- readRDS('data/NewStock_tiles.rds')
  updateSelectizeInput(session,inputId = 'NewStock_item_tiles',choices = unique(df$廠商名稱), server = TRUE,selected = '')
  updateSelectizeInput(session,inputId = 'NewStock_specificaiton_tiles',choices = unique(df$規格), server = TRUE,selected = '')
  updateSelectizeInput(session,inputId = 'NewStock_number_tiles',choices = unique(df$編號), server = TRUE,selected = '')
  updateNumericInput(session,inputId = 'NewStock_boxes_tiles',value = 0,min = 0, max = Inf)
  updateNumericInput(session,inputId = 'NewStock_capacity_tiles',value = 0,min = 0, max = Inf)
  updateNumericInput(session,inputId = 'NewStock_piece_tiles',value = 0,min = 0, max = Inf)
})
######### reset output ###################

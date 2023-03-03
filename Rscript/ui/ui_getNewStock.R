## 一個從新撰寫現有存貨的頁面

## 在假設沒有資料的時候
NewStock_df <- if(!file.exists("data/NewStock.rds")){
  ""
}else{
 readRDS("data/NewStock.rds") 
}
readRDS("data/NewStock.rds")
fluidPage(
  column(4,
    fluidRow(
      # 新增品項的種類
      selectizeInput('NewStock_type', '品項的種類', choices = '', options = list(maxOptions = 5, create = TRUE,placeholder = '挑選一個或新增')),
      # 新增品項的名稱
      selectizeInput('NewStock_item', '品項的名稱', choices = '', options = list(maxOptions = 5, create = TRUE)),
      # 新增 現有的數量
      numericInput('NewStock_quantity', '品項的數量', 0, min = 0, max = 10000),
      # 新增 該品項所要使用的單位
      selectizeInput('NewStock_unit', '品項的單位', choices = '', options = list(maxOptions = 5, create = TRUE)),
      # 上傳資料
      actionButton('MakeNewStock_table','上傳資料',class = 'btn_success'),
      # 上傳資料會有的反應(text)
      textOutput('Button_NewStock') # 
    )# close fluidRow
  ),
  column(8,
    fluidRow( # 放現在有輸入的資料
      DTOutput('NewStock_table')
    )# close fluidRow
  )
  
  
)# close fluidPage
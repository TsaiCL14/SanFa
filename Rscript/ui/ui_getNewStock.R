## 一個從新撰寫現有存貨的頁面

fluidPage(
  column(4,
    fluidRow(
      selectizeInput('NewStock_type', '品項的種類', choices = '', options = list(maxOptions = 5)),
      selectizeInput('NewStock_item', '品項的名稱', choices = '', options = list(maxOptions = 5)),
      numericInput('NewStock_quantity', '品項的數量', 0, min = 0, max = 10000),
      selectizeInput('NewStock_unit', '品項的單位', choices = '', options = list(maxOptions = 5)),
      actionButton('MakeNewStock_table','上傳資料',class = 'btn_success')
    )# close fluidRow
  ),
  column(8,
    fluidRow( # 放現在有輸入的資料
      DTOutput('NewStock_table')
    )# close fluidRow
  )
  
  
)# close fluidPage
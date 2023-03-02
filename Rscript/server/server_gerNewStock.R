## 建立新倉庫時需要的反應

## 寫入資料時需要疊起來的部分
source('Rscript/function/AutoTable.R')
eventReactive(input$MakeNewStock_table,{
  AutoTable('NewStock','種類' = input$NewStock_type,'品項' = input$NewStock_item, '數量' = input$NewStock_quantity, '單位' = input$NewStock_unit)
})

print(input$NewStock_type)
print(input$NewStock_item)
print(input$NewStock_quantity)
print(input$NewStock_unit)
## 觀察已經寫好的表

output$NewStock_table <- renderDT({
  datatable(readRDS('data/NewStock.rds'))
})
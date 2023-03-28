# 製作一個可以讓觀察資料
# 同時可以為自己撰寫筆記的 shinyapp
# 
# 
#
#### 參考模板：https://shiny.rstudio.com/gallery/mote-effect-size.html
library(shiny)
library(knitr)
library(DT)
library(shinyjs)
options(shiny.usecairo = FALSE)
# options(shiny.usecairo = FALSE) # 讓shiny出現中文用

### 事前準備####
## 可以考慮使否在這邊先設置資料表格
############### UI ###############
ui <- fluidPage(
  shinyUI(
    # 主頁
    navbarPage(title = "大倉儲", # 首頁左上角的字
               # 
               navbarMenu('後台',
                 tabPanel(title = '建立一個新的倉庫',
                          source("Rscript/ui/ui_getNewStock.R",local = TRUE)$value
                 ),
                 tabPanel(title = '品項的價格',
                          source('Rscript/ui/ui_getPrice.R',local = TRUE)$value
                          
                 )
               ), # close navbarMenu
               tabPanel(title = '進貨',
                        source('Rscript/ui/ui_getPurchase.R',local = TRUE)$value
               ),
               tabPanel(title = '銷售',
                        source('Rscript/ui/ui_getSale.R',local = TRUE)$value
                        # source('UFO/testInUI.R',local = TRUE)$value
               )
               # ,
               # tabPanel(title = 'test',
               #           source('UFO/testInUI.R',local = TRUE)$value)
               
    ) # navbarPage
  ) # shinyUI
) # fluiPage




############### server #############
server <- function(input, output, session){
  source('Rscript/server/server_getNewStock.R',local = TRUE)$value
  source('Rscript/server/server_getPrice.R',local = TRUE)$value
  source('Rscript/server/server_Purchase.R',local = TRUE)$value
} # close server 


########## RUN #############
# Run the application
shinyApp(ui = ui, server = server)
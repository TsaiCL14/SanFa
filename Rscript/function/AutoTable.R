### 寫一個function可以用在輸入資料時

# 在按下按鈕的時候會將資料自動的寫入資料表中
AutoTable <- function(TableName,...){
  FilePath <- file.path(paste0('data/',TableName,'.rds'))
  doit <- 1
  ## 沒有資料的話就要做一個資料檔出來
  if(!file.exists(FilePath)){
    DirPath <- strsplit(FilePath,'/')[[1]]
    for(Path in DirPath[-length(DirPath)]){
      if(!dir.exists(Path)){
        dir.create(Path)
        } # 
    } # 依檔案層級建立dir
    ## 要怎麼在這個時候為欄位命名 ?????
    saveRDS(as.data.frame(do.call(cbind, list(...))),file = FilePath)
    doit <- 0
  }
  if(doit == 1){
    ## 有了資料後需要先讀取
    useData <- readRDS(FilePath)
    # print(list(...))
    # print(useData)
    # print(as.data.frame(do.call(cbind, list(...))))
    df <- as.data.frame(do.call(cbind, list(...)))
    useData <- rbind(df,useData) # 要讓新的資料可以放在上面
    saveRDS(useData,file = FilePath)
  }
  
}

### 測試
# AutoTable(TableName = 'test','種類' = '泥作','品項' = '台泥','數量' = 15,'單位' = '包')
# AutoTable(TableName = 'test','種類' = '裝潢','品項' = "磁磚",'數量' = 30,'單位' = '箱')
# readRDS('data/test.rds')

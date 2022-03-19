library(tm) 
library(jiebaR)
library(magrittr)
library(dplyr)
# 分词并提取动词、名词
# 创建jieba分词引擎（引擎设置参数较多，此处不赘述，tag 参数表示进行词性标注）
engine1<-worker("tag")
createBag<-function(doc_name){
 # 从文件中读入文本
 chr<-readLines(doc_name)
 # 分词并进行词性标注
 words<- engine1[chr]
 # 将分词结果转换为data.frame格式
 words<-data.frame(part=names(unlist(words)),word=unlist(words))
 # 方便直接调用 data.frame 中的变量（若不使用attach，则需要使用words$part的形式）
 attach(words)
 # 提取名词和动词（还可以使用which语句）
 word_list<-words[part=='n' | part=='v','word']
 detach(words)
 # 将提取的动词和名词拼接成单个长字符串，用于生成语料库
 word_string<-paste(word_list,collapse = " ")
 # 构建语料库
 corpus<-Corpus(VectorSource(word_string),readerControl = 
list(language="SMART"))
 # 可以对corpus进行一些列转换操作，如转换为纯文本，转换为小写等
 # 转换为纯文本：corpus1 <- tm_map(corpus, PlainTextDocument)
 tdm <- TermDocumentMatrix(corpus,control = list(weighting =
 function(x)
 weightTf(x),
 stopwords=TRUE,
 removeNumbers = TRUE,
 removePunctuation = TRUE))
 tdm_frame<-as.data.frame(as.matrix(tdm))
 tdm_frame$Terms<-row.names(tdm_frame)
 # 将词频列重命名为文档名
 colnames(tdm_frame)[1]<-doc_name
 return(tdm_frame)
}
beiying<-createBag("data/txt/shadow.txt")
nahan<-createBag("data/txt/nahan.txt")
xueguo<-createBag("data/txt/yukikuni.txt")
# 全连接构建词袋
beiying<- beiying %>% full_join(nahan,by="Terms") %>% full_join(xueguo,by="Terms")
# 替换空值
beiying[is.na(beiying)] <- 0
# 将 Terms 列作为行号列
row.names(beiying)<-beiying$Terms
beiying<-beiying[,c("data/txt/shadow.txt","data/txt/nahan.txt","data/txt/yukikuni.txt")]
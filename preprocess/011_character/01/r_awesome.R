setwd("C:\\Users\\CT\\Desktop\\翻译12.22\\翻译12.21\\翻译\\译稿\\chapter11_code\\011_character\\01")
# 导入jiebaR包
library(jiebaR)
# 创建jieba分词引擎（引擎设置参数较多，此处不赘述，tag参数表示进行词性标注）
engine1<-worker("tag")
# 从文件中读入文本
chr<-readLines("data/txt/shadow.txt")
# 分词并进行词性标注
words<- engine1[chr]
# 将分词结果转换为data.frame格式
words<-data.frame(part=names(unlist(words)),word=unlist(words))
# 方便直接调用data.frame中的变量（若不使用attach，则需要使用words$part的形式）
attach(words)
# 提取名词和动词
word_list<-words[part=='n' | part=='v','word']
detach(words)

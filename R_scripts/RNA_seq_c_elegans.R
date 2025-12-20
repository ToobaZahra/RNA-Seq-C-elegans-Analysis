# Differential Expression Analysis
# Before doing DE, make a metadata sheet (open excel, make two cols [sample,gender] save as metadata.csv)

setwd('E:/RNA-Seq-C-elegans-Analysis')

#libraries
library(DESeq2)
library(pheatmap)

#count file
c_e_count <- read.delim('count.txt',header=T)
c_e_meta <- read.delim('metadata.tsv',header=T,stringsAsFactors = T)

#preview
head(c_e_count)
head(c_e_meta)

# Extract only the numeric count columns (the sample columns)
raw_counts <- c_e_count[, c("fm_1", "fm_2", "fm_3", "m_4", "m_5", "m_6")]
head(raw_counts)

# add row names
rownames(raw_counts)<-c_e_count$Geneid
head(raw_counts)

#create deseqdataset
dds <- DESeqDataSetFromMatrix(countData = raw_counts, colData = c_e_meta, design = ~gender)
dds$sample
dds$gender

#perform the diff expression analysis
dds <- DESeq(dds)
final_res <- results(dds)

# look at results
head(final_res)

#we have truncated data, let's see the distro of p-values
plot(density(x=na.omit(final_res$pvalue)))

#let's look at our Diff expressed genes
plot(x=final_res$log2FoldChange,
     y=-log10(final_res$padj),
     cex = 0.25,
     pch = 19,
     col = 'grey',
     ylim = c(0,20),
     ylab = 'Adjusted P-value',
     xlab = 'Log2 FC'
     )

abline(v=c(-2,2) ,h=-log10(0.05), lwd =0.5, lty=2)

#where are the upregulated 
upregulated <- subset(final_res, padj<0.05&log2FoldChange> 2)
points(upregulated$log2FoldChange,
       y=-log10(upregulated$padj),
       cex = 0.35,
       pch = 19,
       col = 'salmon'
)

#where are the downregulated
downregulated <- subset(final_res,padj<0.05&log2FoldChange< -2)
points(downregulated$log2FoldChange,
       y=-log10(downregulated$padj),
       cex = 0.35,
       pch = 19,
       col = 'lightblue'
)

mtext('A simple volcano')

# we can merge the two to do a clean and less memory efficient heatmap
degs <- rbind(raw_counts[rownames(upregulated),],raw_counts[rownames(downregulated),])

pheatmap(degs,
         cluster_rows=F,
         cluster_cols = F,
         show_rownames = F,
         scale='row',
         show_colnames = T
         )

# what are the genes that are upregulated and downregulated
rownames(upregulated)
rownames(downregulated)

#exporting the files
write.csv(upregulated,'upregulated.csv')
write.csv(downregulated,'downregulated.csv')
write.csv(raw_counts,'raw_counts.csv')
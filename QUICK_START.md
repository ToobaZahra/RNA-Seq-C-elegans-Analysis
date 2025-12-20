# 🚀 Quick Start Guide

Get up and running with the *C. elegans* RNA-Seq analysis in under 10 minutes!

## ⚡ Fast Track (For Recruiters)

**Just want to see the results?** Check out:
- 📊 [Results folder](results/) - See upregulated/downregulated genes
- 🎨 [Figures](results/figures/) - Volcano plot and heatmap visualizations
- 📓 [Colab Notebook](notebooks/rna_seq_analysis_c_elegans_md.ipynb) - Complete preprocessing pipeline
- 📈 [R Script](scripts/RNA_seq_c_elegans.R) - DESeq2 analysis code

## 🔬 Full Analysis Workflow

### Prerequisites Checklist

- [ ] Google account (for Colab)
- [ ] R installed (version 4.0+)
- [ ] RStudio installed (recommended)
- [ ] ~5GB free space on Google Drive

### Step 1: Preprocessing in Google Colab (30 minutes)

1. **Open the notebook:**
   ```
   Go to: https://colab.research.google.com/
   Upload: notebooks/rna_seq_analysis_c_elegans_md.ipynb
   ```

2. **Connect and mount Drive:**
   - Click "Connect" in top right
   - Run first cell to mount Google Drive
   - Authorize when prompted

3. **Run the complete pipeline:**
   ```python
   # The notebook will automatically:
   # ✓ Install all tools (FastQC, fastp, STAR, featureCounts)
   # ✓ Download C. elegans genome and annotation
   # ✓ Download 6 FASTQ files
   # ✓ Perform QC, trimming, alignment, quantification
   # ✓ Generate count.txt file
   ```

4. **Download results:**
   - Navigate to `rna_seq_analysis_c_elegans/counts/`
   - Download `count.txt` to your computer

**Time:** ~30 minutes (mostly waiting for alignment)

### Step 2: Differential Expression in R (5 minutes)

1. **Prepare your workspace:**
   ```bash
   # Create project directory
   mkdir c_elegans_analysis
   cd c_elegans_analysis
   
   # Copy files
   # - count.txt (from Colab)
   # - RNA_seq_c_elegans.R (from this repo)
   ```

2. **Create metadata file:**
   
   Open Excel/Notepad and create `metadata.tsv`:
   ```
   sample	gender
   fm_1	female
   fm_2	female
   fm_3	female
   m_4	male
   m_5	male
   m_6	male
   ```
   
   Save as tab-delimited text (.tsv)

3. **Install R packages (first time only):**
   ```R
   # In R console
   source("environment/R_packages.R")
   ```

4. **Run the analysis:**
   ```R
   # Set working directory
   setwd("path/to/c_elegans_analysis")
   
   # Run complete analysis
   source("RNA_seq_c_elegans.R")
   ```

5. **View results:**
   - Volcano plot appears automatically
   - Heatmap appears automatically
   - Files created:
     - `upregulated.csv` - Genes higher in males
     - `downregulated.csv` - Genes higher in females
     - `raw_counts.csv` - Normalized counts

**Time:** ~5 minutes

## 📊 Expected Results

### Console Output
```R
> # You should see:
> dim(upregulated)
[1] XX  6    # Number of upregulated genes

> dim(downregulated)
[1] YY  6    # Number of downregulated genes
```

### Plots
1. **P-value distribution** - Should look approximately uniform
2. **Volcano plot** - Shows DEGs in color, non-DEGs in gray
3. **Heatmap** - Clear clustering of female vs male samples

## 🐛 Troubleshooting

### Issue: "Cannot mount Google Drive"
**Solution:** 
```python
from google.colab import drive
drive.mount('/content/drive', force_remount=True)
```

### Issue: "STAR command not found"
**Solution:** Re-run the first cell that installs tools

### Issue: "Error: object 'c_e_count' not found"
**Solution:** Check your working directory:
```R
getwd()  # Should show where count.txt is located
setwd("correct/path/here")
```

### Issue: "Package 'DESeq2' not found"
**Solution:**
```R
if (!require("BiocManager")) install.packages("BiocManager")
BiocManager::install("DESeq2")
```

### Issue: Metadata doesn't load correctly
**Solution:**
```R
# Make sure it's TAB-delimited, not comma-separated
meta <- read.delim("metadata.tsv", header=T, stringsAsFactors=T)
str(meta)  # Check structure
```

## 💡 Tips for Success

1. **Save your work frequently** in Colab (File → Save)
2. **Keep Colab session active** - It disconnects after ~90 min idle
3. **Check file paths** - Use `list.files()` in R to verify
4. **Use consistent naming** - Sample names must match exactly
5. **Document your changes** - Add comments if you modify code

## 📈 What's Next?

After completing the basic analysis:

1. **Explore the genes:**
   ```R
   # Look at top upregulated genes
   head(upregulated[order(upregulated$log2FoldChange, decreasing=T), ])
   
   # Look at top downregulated genes  
   head(downregulated[order(downregulated$log2FoldChange), ])
   ```

2. **Customize visualizations:**
   - Adjust volcano plot thresholds
   - Change heatmap colors
   - Add gene labels to plots

3. **Functional analysis:**
   - Gene Ontology enrichment
   - KEGG pathway analysis
   - Literature search for top genes

4. **Extended analysis:**
   - Add more samples
   - Compare different conditions
   - Time-series analysis

## 🎓 Learning Resources

**Understanding the output:**
- [DESeq2 vignette](http://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html)
- [RNA-Seq analysis guide](https://www.bioconductor.org/help/course-materials/2016/CSAMA/lab-3-rnaseq/rnaseq_gene_CSAMA2016.html)

**Interpreting results:**
- **padj**: Adjusted p-value (significance)
- **log2FoldChange**: Expression difference (+ = higher in males)
- **baseMean**: Average normalized count

**Statistical concepts:**
- [Understanding FDR](https://www.statisticshowto.com/false-discovery-rate/)
- [Log fold change](https://en.wikipedia.org/wiki/Fold_change)

## ❓ Getting Help

1. **Check the README** - Most questions answered there
2. **Review the code comments** - Detailed explanations in scripts
3. **Open an issue** - Use GitHub issues for bugs/questions
4. **Email me** - tooba.zahra19@gmail.com

## ✅ Verification Checklist

Before considering your analysis complete:

- [ ] All 6 samples processed successfully
- [ ] Count matrix has 19,985 genes
- [ ] DESeq2 analysis completed without errors
- [ ] Volcano plot shows clear separation
- [ ] Heatmap shows clustering by sex
- [ ] Output CSV files generated
- [ ] P-value distribution looks reasonable

---

**Estimated total time:** 35-40 minutes for complete analysis

**Questions?** Open an issue or contact me directly!

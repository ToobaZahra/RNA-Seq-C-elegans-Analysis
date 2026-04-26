# RNA-Seq Differential Expression Analysis: *C. elegans* Sex-Specific Gene Expression

An end-to-end RNA-Seq analysis pipeline to identify sex-specific differentially expressed genes in *Caenorhabditis elegans* — comparing gene expression between male and female worms.

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)
[![R](https://img.shields.io/badge/R-4.0+-green.svg)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🔬 Project Overview

This was a project I did to explore how gene expression differs between male and female *C. elegans* worms using RNA-Seq data. I built the entire pipeline from raw reads to final visualizations — it helped me learn a lot about bioinformatics workflows and statistical analysis.

The analysis covers quality control, read alignment, quantification, and differential expression testing using DESeq2.

### Key Facts
- **Samples:** 6 RNA-Seq samples (3 female, 3 male)
- **Genome:** *C. elegans* WBcel235 (100 Mb)
- **Genes analyzed:** 19,985 protein-coding genes
- **Alignment rate:** 76–84% across samples
- **DEG thresholds used:** padj < 0.05, |log2FC| > 2

---

## 📊 Pipeline Workflow

```
Raw FASTQ Files (6 samples: fm_1, fm_2, fm_3, m_4, m_5, m_6)
    ↓
Quality Control (FastQC v0.11.9)
    ↓
Read Trimming (fastp v0.20.1)
    ↓
Genome Alignment (STAR v2.7.10b)
    ↓
Read Quantification (featureCounts v2.0.3)
    ↓
counts.txt (19,985 genes × 6 samples)
    ↓
Differential Expression Analysis (DESeq2)
    ↓
Statistical Testing & Normalization
    ↓
Results: Upregulated & Downregulated Genes
    ↓
Visualizations: Volcano Plot & Heatmap
```

---

## 📁 Repository Structure

```
RNA-Seq-C-elegans-Analysis/
├── notebooks/
│   └── rna_seq_analysis_c_elegans_md.ipynb    # Colab preprocessing pipeline
├── scripts/
│   └── RNA_seq_c_elegans.R                    # DESeq2 differential expression
├── data/
│   ├── count.txt                              # Gene count matrix (2.5 MB)
│   ├── metadata.tsv                           # Sample information
│   └── README.md                              # Data documentation
├── results/
│   ├── upregulated.csv                        # Genes higher in males
│   ├── downregulated.csv                      # Genes higher in females
│   ├── raw_counts.csv                         # Normalized counts
│   └── figures/
│       ├── volcano_plot.png
│       └── heatmap.png
├── environment/
│   └── R_packages.R                           # R dependencies installer
├── .gitignore
├── README.md                                  # This file
├── QUICK_START.md                             # Fast setup guide
└── LICENSE
```

---

## 🚀 Quick Start

### What You Need
- Google account (for Colab)
- R ≥ 4.0 with RStudio (recommended)
- ~5 GB Google Drive space

### Part 1: Preprocessing in Google Colab (~30 min)

1. Upload `notebooks/rna_seq_analysis_c_elegans_md.ipynb` to Colab
2. Run all cells — it will:
   - Mount your Google Drive
   - Install FastQC, fastp, STAR, featureCounts
   - Download the *C. elegans* genome + 6 FASTQ files
   - Run QC → Trim → Align → Quantify
3. Download `count.txt` from the `counts/` output folder

### Part 2: Differential Expression in R (~5 min)

1. Set up your working folder:
```bash
mkdir c_elegans_analysis
cd c_elegans_analysis
# Place count.txt here
```

2. Create `metadata.tsv`:
```tsv
sample	gender
fm_1	female
fm_2	female
fm_3	female
m_4	male
m_5	male
m_6	male
```

3. Install R packages (only needed once):
```r
source("environment/R_packages.R")
```

4. Run the analysis:
```r
setwd("path/to/c_elegans_analysis")
source("scripts/RNA_seq_c_elegans.R")
```

5. Outputs:
   - Volcano plot and heatmap open automatically
   - `upregulated.csv`, `downregulated.csv`, `raw_counts.csv` are saved

---

## 📈 Analysis Details

### Sample Information

| Sample ID | Condition | Read Count | Aligned | Assignment Rate |
|-----------|-----------|------------|---------|-----------------|
| fm_1      | Female    | 49,515     | 45,381  | 83.6%           |
| fm_2      | Female    | 47,730     | 43,648  | 84.2%           |
| fm_3      | Female    | 46,495     | 41,497  | 83.7%           |
| m_4       | Male      | 48,412     | 42,363  | 76.9%           |
| m_5       | Male      | 47,112     | 41,627  | 77.3%           |
| m_6       | Male      | 45,263     | 39,653  | 76.3%           |

**Data source:** [josoga2/bash-course](https://github.com/josoga2/bash-course) RNA-Seq module

### Reference Genome
- **Organism:** *Caenorhabditis elegans*
- **Assembly:** WBcel235 (Ensembl)
- **Annotation:** Ensembl release 114 GFF3
- **Genome size:** 100,286,401 bp
- **Features:** 19,985 genes

### Quality Metrics
- **Read length:** 36 bp (single-end)
- **Q20:** > 95%, **Q30:** > 90%
- **Duplication rate:** 3.1–4.1%
- **Trimming:** Adapter removal + quality filter (Q20)

### Statistical Method
- **Package:** DESeq2 (negative binomial model)
- **Normalization:** Median-of-ratios
- **Test:** Wald test
- **Multiple testing correction:** Benjamini-Hochberg FDR
- **Thresholds:** padj < 0.05, |log2FC| > 2

---

## 🛠️ Tools Used

### Preprocessing (Google Colab)
| Tool | Version | Purpose |
|------|---------|---------|
| FastQC | 0.11.9 | Quality control |
| fastp | 0.20.1 | Adapter trimming |
| STAR | 2.7.10b | Genome alignment |
| featureCounts | 2.0.3 | Gene quantification |
| samtools | 1.13 | BAM processing |

### Differential Expression (R)
| Package | Purpose |
|---------|---------|
| DESeq2 | Differential expression |
| pheatmap | Heatmap |
| Base R | Volcano plot, data handling |

---

## 📊 Results & Interpretation

### 🔬 Differential Expression Summary

Using thresholds (padj < 0.05, |log2FC| > 2):

| Group | DEG Count |
|-------|-----------|
| Upregulated in males | 765 genes |
| Upregulated in females | 182 genes |
| **Total DEGs** | **947 genes** |

> 👉 This shows a strong male-biased transcriptional signature in this dataset.

---

### 📈 Volcano Plot

<p align="center">
  <img src="results/figures/volcano_plot.png" width="600">
</p>

**Figure 1.** Volcano plot showing differential gene expression between male and female samples.

**Interpretation:**
- Right side → genes upregulated in males
- Left side → genes upregulated in females
- Clear spread indicates strong effect sizes (log2FC up to ~6)
- Significant clustering confirms robust statistical signal

---

### 🔥 Expression Heatmap

<p align="center">
  <img src="results/figures/heatmap.png" width="600">
</p>

**Figure 2.** Heatmap of differentially expressed genes across samples.

**Interpretation:**
- Samples cluster into distinct male vs female groups
- Strong consistency across replicates
- Indicates low technical noise and high biological relevance

---

### 🧬 Top Differentially Expressed Genes

#### ⬆️ Upregulated in Males

| Gene ID | log2FC | padj |
|---------|--------|------|
| WBGene00004969 | 6.16 | 2.2e-05 |
| WBGene00022162 | 4.66 | 0.017 |
| WBGene00021212 | 4.65 | 0.017 |
| WBGene00022032 | 4.35 | 0.049 |
| WBGene00001196 | 2.04 | 0.031 |

#### ⬇️ Upregulated in Females

| Gene ID | log2FC | padj |
|---------|--------|------|
| WBGene00003229 | -3.47 | 1.4e-05 |
| WBGene00021763 | -4.32 | 0.010 |
| WBGene00021005 | -4.43 | 0.019 |
| WBGene00020091 | -4.08 | 0.018 |
| WBGene00003156 | -4.06 | 0.0036 |

---

### 📊 Key Observations

- Strong asymmetry in regulation — many more male-upregulated genes than female
- High fold changes (up to log2FC ~6) suggest biologically meaningful differences
- Clear sample clustering by sex confirms the signal is real, not noise
- No evidence of p-value inflation or batch effects

---

### ✅ Statistical Confidence

- FDR-adjusted p-values control for false positives across thousands of tests
- DEG patterns are consistent across all three replicates per group
- Volcano plot distribution shows no inflation or bias
- Alignment and QC metrics support data reliability

---

### 🧬 Biological Interpretation

Based on these results:

- **Male-specific gene activation** is much more extensive — 765 vs 182 genes
- Male-upregulated genes likely include:
  - Spermatogenesis-related genes
  - Male mating behavior pathways
- Female-upregulated genes likely relate to:
  - Oogenesis
  - Developmental regulation

*Full gene lists are in `upregulated.csv` and `downregulated.csv`*

---

## 🔍 Quality Control Summary

✅ Pre- and post-trimming FastQC reports generated  
✅ Alignment rates verified with STAR logs  
✅ BAM files validated with samtools  
✅ P-value distribution checked — no inflation  
✅ Replicates show consistent expression patterns  
✅ Sample clustering matches experimental design  

---

## 💾 Data Availability

Raw files are not included to keep the repo lightweight, but everything is reproducible by running the pipeline.

### Included in this repo
✅ Colab preprocessing notebook  
✅ DESeq2 R script  
✅ Gene count matrix (`count.txt`)  
✅ Sample metadata  
✅ Final results (CSV files)  
✅ Figures (PNG)  

### Not included (auto-generated by pipeline)
❌ Raw FASTQ files (~36 MB)  
❌ BAM alignment files (~18 MB)  
❌ Genome FASTA (~100 MB)  
❌ STAR genome indices (~1 GB)  

---

## 🎓 What I Learned

Working on this project taught me:
- How to set up and run a full RNA-Seq pipeline
- Using STAR for splice-aware alignment and DESeq2 for statistical testing
- How FDR correction works in practice (and why it matters)
- Interpreting volcano plots and heatmaps biologically
- Managing a bioinformatics project with proper folder structure and documentation
- Running computationally heavy tasks on Google Colab

---

## 🤝 Contributing

This is a personal portfolio project, but if you spot a mistake or have suggestions, feel free to open an issue or pull request!

---

## 📄 License

Licensed under the MIT License — see [LICENSE](LICENSE) for details.

---

## 👤 About Me

**Tooba Zahra** — Bioinformatics graduate passionate about combining biology with code.

- GitHub: [@ToobaZahra](https://github.com/ToobaZahra)
- LinkedIn: [Tooba Zahra](https://linkedin.com/in/tooba-zahra-ab2015246)
- Email: tooba.zahra19@gmail.com

---

## 🙏 Acknowledgments

- **Data:** [josoga2/bash-course](https://github.com/josoga2/bash-course) RNA-Seq training module
- **Reference genome:** Ensembl Metazoa (WBcel235)
- **DESeq2:** Love, Huber & Anders (2014)
- **Google Colab** for free GPU/CPU access

---

## 📚 References

1. Love MI, Huber W, Anders S (2014). DESeq2. *Genome Biology*, 15:550. [DOI](https://doi.org/10.1186/s13059-014-0550-8)
2. Dobin A et al. (2013). STAR aligner. *Bioinformatics*, 29(1):15–21. [DOI](https://doi.org/10.1093/bioinformatics/bts635)
3. Liao Y, Smyth GK, Shi W (2014). featureCounts. *Bioinformatics*, 30(7):923–930. [DOI](https://doi.org/10.1093/bioinformatics/btt656)
4. Chen S et al. (2018). fastp. *Bioinformatics*, 34(17):i884–i890. [DOI](https://doi.org/10.1093/bioinformatics/bty560)
5. WormBase: https://wormbase.org

---

**Status:** ✅ Complete  
**Last updated:** April 2026  
**Keywords:** RNA-Seq · DESeq2 · Bioinformatics · C. elegans · Differential Expression · Python · R · Genomics

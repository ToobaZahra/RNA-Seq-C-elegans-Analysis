# R Package Installation Script for RNA-Seq Analysis
# C. elegans Differential Expression Analysis
# Author: ToobaZahra
# Date: December 2025

cat("Installing required R packages for RNA-Seq analysis...\n\n")

# Check if BiocManager is installed
if (!require("BiocManager", quietly = TRUE)) {
  cat("Installing BiocManager...\n")
  install.packages("BiocManager")
}

# Load BiocManager
library(BiocManager)

# List of required packages
required_packages <- c(
  "DESeq2",      # Differential expression analysis
  "pheatmap"     # Heatmap visualization
)

# Install packages
cat("\nInstalling Bioconductor and CRAN packages...\n")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(paste("Installing", pkg, "...\n"))
    if (pkg %in% c("DESeq2")) {
      BiocManager::install(pkg, update = FALSE)
    } else {
      install.packages(pkg)
    }
  } else {
    cat(paste(pkg, "is already installed.\n"))
  }
}

# Verify installation
cat("\n=== Verifying Installation ===\n")
for (pkg in required_packages) {
  if (require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(paste("✓", pkg, "successfully loaded\n"))
  } else {
    cat(paste("✗", pkg, "failed to load\n"))
  }
}

cat("\n=== Installation Complete! ===\n")
cat("You can now run the RNA_seq_c_elegans.R script.\n")

# Print session info
cat("\n=== Session Information ===\n")
sessionInfo()
#!/usr/bin/Rscript

beta = read.csv("~/beta-div.tsv", sep="\t")
beta$comparison1 <- as.character(beta$comparison1)
beta$comparison2 <- as.character(beta$comparison2)
bc_mat <- beta[,c(2,3,4)]

# Get unique sample names
samples <- unique(c(bc_mat$comparison1, bc_mat$comparison2))

# Create an empty matrix with NAs
triangular_matrix <- matrix(NA, nrow = length(samples), ncol = length(samples), dimnames = list(samples, samples))

# Fill in the matrix with the distance values
for (i in 1:nrow(bc_mat)) {
  row_name <- bc_mat$comparison1[i]
  col_name <- bc_mat$comparison2[i]
  value <- bc_mat$braycurtis[i]
  triangular_matrix[row_name, col_name] <- value
}

# Replace missing values (diagonal and lower triangle) with 0
triangular_matrix[is.na(triangular_matrix) | lower.tri(triangular_matrix)] <- 0
print(triangular_matrix)

pcoa <- as.data.frame(cmdscale(triangular_matrix, k = 2))
names(pcoa) <- c("PCoA1", "PCoA2")

my_labels = gsub("[_].*", "", rownames(pcoa))
plot(pcoa$PCoA1, pcoa$PCoA2, col=as.factor(my_labels), xlab="PCoA1", ylab="PCoA2")
legend("top", unique(my_labels), pch=1, col=(unique(as.factor(my_labels))))
#text(pcoa$PCoA1, pcoa$PCoA2, samples, pos=3)

my_labels = gsub("[_].*", "", rownames(pcoa))
pcoa$Label <- my_labels

plot(pcoa$PCoA1, pcoa$PCoA2, col=as.factor(my_labels), xlab="PCoA1", ylab="PCoA2")
legend("top", unique(my_labels), pch=1, col=(unique(as.factor(my_labels))))

# Definir os grupos baseados no nome das amostras
pcoa$Group <- ifelse(grepl("Bir", pcoa$Label), "Bir", 
                     ifelse(grepl("W36", pcoa$Label), "W36", 
                            ifelse(grepl("M1", pcoa$Label), "M1", "Other")))

# Distribuir formas por grupos
shape_values <- c("Bir" = 16, "W36" = 17, "M1" = 4)

pcoa_plot <- ggplot(pcoa, aes(x = PCoA1, y = PCoA2, color = Label, shape = Group)) +
  geom_point(aes(fill = Group), size = 3) +
  theme_minimal() +
  scale_shape_manual(values = shape_values) +
  labs(title = "PCoA Plot", x = "PCoA1", y = "PCoA2", color = "Groups", shape = "Groups", fill = "Groups") +  # Personalizar nome do título, eixos e a legenda
  theme(plot.title = element_text(hjust = 0.5))
print(pcoa_plot)

# Boxplot PCoA1

ggplot(pcoa, aes(x = Label, y = PCoA1, fill = Label)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Boxplot of PCoA1 by Groups", x = "Groups", y = "PCoA1", fill= "Groups") +
  theme(plot.title = element_text(hjust = 0.5))

# Boxplot PCoA2

ggplot(pcoa, aes(x = Label, y = PCoA2, fill = Label)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Boxplot of PCoA2 by Groups", x = "Groups", y = "PCoA2", fill= "Groups") +
  theme(plot.title = element_text(hjust = 0.5))


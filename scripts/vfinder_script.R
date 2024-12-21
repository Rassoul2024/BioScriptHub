#!/usr/bin/Rscript
args = commandArgs(trailingOnly=TRUE)

# validating if there were arguments
if (length(args)>2) {
  stop("Les deux arguments nécessaires sont le fichier d'entrée et le dossier de sortie", call.=FALSE)
}

input <- args[1]
output <- args[2]

library(VirFinder)

sink(output)
predResult <- VF.pred(input)
sink()
q()
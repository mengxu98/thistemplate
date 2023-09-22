#!/bin/bash

# Build website to preview template
Rscript -e 'pkgdown::build_site()'

# Build new document
Rscript -e 'devtools::document()'

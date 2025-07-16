#' Use thistemplate theme for pkgdown
#'
#' This function helps you set up the thistemplate theme for your package's pkgdown site.
#' It will:
#' 1. Create or update _pkgdown.yml with the necessary template configuration
#' 2. Add thistemplate to the Config/Needs/website field in DESCRIPTION
#'
#' @param github_url Optional. The GitHub URL of your package. If provided, will be added to the navbar.
#' @param author Optional. The author name. If not provided, will be extracted from DESCRIPTION.
#' @export
use_thistemplate <- function(
    github_url = NULL,
    author = NULL) {
  root_pkgdown <- "_pkgdown.yml"
  if (file.exists(root_pkgdown)) {
    pkgdown_path <- root_pkgdown
  } else {
    pkgdown_files <- list.files(
      path = ".",
      pattern = "_pkgdown\\.yml$",
      recursive = TRUE,
      full.names = TRUE
    )

    if (length(pkgdown_files) == 0) {
      pkgdown_path <- root_pkgdown
    } else {
      inst_pkgdown <- pkgdown_files[grepl("inst/pkgdown", pkgdown_files)]
      if (length(inst_pkgdown) > 0) {
        pkgdown_path <- inst_pkgdown[1]
      } else {
        pkgdown_path <- pkgdown_files[1]
        warning(
          sprintf(
            "No _pkgdown.yml found in root or inst/pkgdown. Using %s instead.",
            pkgdown_path
          )
        )
      }
    }
  }

  if (is.null(author)) {
    author_info <- desc::desc_get_author()
    author <- gsub("^([^<]+).*$", "\\1", author_info)
    author <- trimws(author)
  }

  if (is.null(github_url)) {
    github_url <- desc::desc_get_urls()
    if (length(github_url) > 0) {
      github_url <- github_url[grepl("github", github_url)]
      if (length(github_url) > 0) {
        github_url <- github_url[1]
      }
    } else {
      warning("No GitHub URL found in DESCRIPTION")
      github_url <- NULL
    }
  }

  if (!file.exists(pkgdown_path)) {
    yaml_content <- list(
      template = list(
        bootstrap = 5,
        `light-switch` = TRUE,
        package = "thistemplate"
      )
    )

    yaml_content$navbar <- list(
      structure = list(
        left = c("articles", "reference", "tutorials", "news"),
        right = c("github", author, "lightswitch")
      ),
      components = list(
        github = list(
          icon = "fab fa-github fa-lg",
          href = github_url
        )
      )
    )

    yaml::write_yaml(yaml_content, pkgdown_path)
    message("Created _pkgdown.yml with thistemplate configuration")
  } else {
    yaml_content <- yaml::read_yaml(pkgdown_path)

    if (is.null(yaml_content$template)) yaml_content$template <- list()
    if (is.null(yaml_content$template$package)) yaml_content$template$package <- "thistemplate"
    if (is.null(yaml_content$template$`light-switch`)) yaml_content$template$`light-switch` <- TRUE
    if (is.null(yaml_content$template$bootstrap)) yaml_content$template$bootstrap <- 5

    if (!is.null(yaml_content$navbar) && !is.null(yaml_content$navbar$structure)) {
      right <- yaml_content$navbar$structure$right
      if (is.null(right)) right <- character()
      if (!"lightswitch" %in% right) {
        yaml_content$navbar$structure$right <- c(right, "lightswitch")
      }
    }

    yaml_content$navbar$components$github <- list(
      icon = "fab fa-github fa-lg",
      href = github_url
    )

    yaml::write_yaml(yaml_content, pkgdown_path)
    message(sprintf("Updated %s with thistemplate configuration", pkgdown_path))
  }

  desc_path <- "DESCRIPTION"
  if (!file.exists(desc_path)) {
    stop("DESCRIPTION file not found")
  }

  desc <- desc::description$new(desc_path)
  desc$set("Config/Needs/website", "mengxu98/thistemplate")
  desc$write()
  message("Updated DESCRIPTION with thistemplate dependency")

  invisible(TRUE)
}

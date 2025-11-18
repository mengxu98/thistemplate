# ***thistemplate***

A theme and template for [pkgdown](https://github.com/r-lib/pkgdown/)
page. See [thistemplate](https://mengxu98.github.io/thistemplate/).

## Usage

### Two way

### 1. Automatic setting

``` r
if (!require("pak", quietly = TRUE)) {
  install.packages("pak")
}
pak::pak("mengxu98/thistemplate")

library(thistemplate)
use_thistemplate()
```

### 2. Manual setting

#### `_pkgdown.yml` file

``` yaml
template:
  package: thistemplate

navbar:
  components:
    github:
      icon: fab fa-github fa-lg
      href: The link of package # eg.: https://github.com/usrname/package
```

#### `DESCRIPTION` file

``` yaml
Config/Needs/website: mengxu98/thistemplate
```

## Acknowledge

The [thistemplate](https://github.com/mengxu98/thistemplate) package
referred [bslib](https://github.com/rstudio/bslib/tree/main) package,
[gadenbuie](https://github.com/gadenbuie)’s
[grkgdown](https://github.com/gadenbuie/grkgdown) package and
[mlr3pkgdowntemplate](https://github.com/mlr-org/mlr3pkgdowntemplate)
package.


# ***thistemplate***

<!-- badges: start -->

[![pkgdown](https://github.com/mengxu98/thistemplate/actions/workflows/pkgdown.yaml/badge.svg)](https://mengxu98.github.io/thistemplate/index.html)

<!-- badges: end -->

A theme and template for
[*`pkgdown`*](https://github.com/r-lib/pkgdown/) page. Such as:
[*`inferCSN`*](https://mengxu98.github.io/inferCSN/).

## Usage

#### *\_pkgdown.yml*

``` yaml
template:
  package: thistemplate

navbar:
  components:
    github:
      icon: fab fa-github fa-lg
      href: The link of package # Such as: https://github.com/mengxu98/inferCSN
```

#### *DESCRIPTION*

``` yaml
Config/Needs/website: mengxu98/thistemplate
```

## Acknowledge

The [*`thistemplate`*](https://github.com/mengxu98/thistemplate) package
referred [*`bslib`*](https://github.com/rstudio/bslib/tree/main)
package, [*`gadenbuie`*](https://github.com/gadenbuie)’s
[*`grkgdown`*](https://github.com/gadenbuie/grkgdown) package and
[*`mlr3pkgdowntemplate`*](https://github.com/mlr-org/mlr3pkgdowntemplate)
package.

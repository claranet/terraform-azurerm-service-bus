## 8.0.0 (2025-01-24)

### ⚠ BREAKING CHANGES

* **AZ-1088:** module v8 structure and updates

### Features

* **AZ-1088:** module v8 structure and updates d8f20c9

### Miscellaneous Chores

* **deps:** update dependency claranet/diagnostic-settings/azurerm to v7 52565b0
* **deps:** update dependency opentofu to v1.8.3 8095151
* **deps:** update dependency opentofu to v1.8.4 6871d1c
* **deps:** update dependency opentofu to v1.8.6 31e0d63
* **deps:** update dependency opentofu to v1.8.8 9081f0e
* **deps:** update dependency opentofu to v1.9.0 6331bb4
* **deps:** update dependency pre-commit to v4 4a3c5d9
* **deps:** update dependency pre-commit to v4.0.1 407ef56
* **deps:** update dependency pre-commit to v4.1.0 05ef5a9
* **deps:** update dependency tflint to v0.54.0 97ce3b9
* **deps:** update dependency tflint to v0.55.0 013cd7a
* **deps:** update dependency trivy to v0.56.1 0a2ec94
* **deps:** update dependency trivy to v0.56.2 1703346
* **deps:** update dependency trivy to v0.57.1 114fd01
* **deps:** update dependency trivy to v0.58.1 7b43c7b
* **deps:** update dependency trivy to v0.58.2 91b2316
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 a965a1f
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 3fd9c25
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 f777640
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 c793e4e
* **deps:** update tools f6f9743
* **deps:** update tools 6d5a39a
* prepare for new examples structure c887689
* update examples structure 9d38cc4
* update tflint config for v0.55.0 28f2a80

## 7.5.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 246afe6

### Documentation

* update README badge to use OpenTofu registry ec294b1
* update README with `terraform-docs` v0.19.0 e141c6f

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.7.0 1f5c0fe
* **deps:** update dependency opentofu to v1.7.1 92e5490
* **deps:** update dependency opentofu to v1.7.2 fa54cb1
* **deps:** update dependency opentofu to v1.7.3 b5d0ac7
* **deps:** update dependency opentofu to v1.8.0 b3e5ba7
* **deps:** update dependency opentofu to v1.8.1 ae9a3b3
* **deps:** update dependency pre-commit to v3.7.1 831f840
* **deps:** update dependency pre-commit to v3.8.0 53c0fcc
* **deps:** update dependency terraform-docs to v0.18.0 6e201ae
* **deps:** update dependency terraform-docs to v0.19.0 d2a1fad
* **deps:** update dependency tflint to v0.51.0 eee87e7
* **deps:** update dependency tflint to v0.51.1 71f9821
* **deps:** update dependency tflint to v0.51.2 69c7223
* **deps:** update dependency tflint to v0.52.0 3e2c5b0
* **deps:** update dependency tflint to v0.53.0 990adca
* **deps:** update dependency trivy to v0.51.0 21ad56f
* **deps:** update dependency trivy to v0.51.1 194426c
* **deps:** update dependency trivy to v0.51.2 4c86174
* **deps:** update dependency trivy to v0.51.4 dae84fc
* **deps:** update dependency trivy to v0.52.0 bd6dafb
* **deps:** update dependency trivy to v0.52.1 69e5f5d
* **deps:** update dependency trivy to v0.52.2 a450524
* **deps:** update dependency trivy to v0.53.0 9f58a36
* **deps:** update dependency trivy to v0.54.1 369d2f7
* **deps:** update dependency trivy to v0.55.0 aa70fb3
* **deps:** update dependency trivy to v0.55.1 c22b58c
* **deps:** update dependency trivy to v0.55.2 ea5fa1c
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 36d12df
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 ba3b411
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 518c65b
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 bc7e7c2
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 6817438
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 04ccfbc
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 0524a68
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 f979563
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 a7cf17f
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 733934c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 8faef44
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 a8f6f87
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 8ebf1e0
* **deps:** update tools 42ce889
* **release:** remove legacy `VERSION` file ea6556e

## 7.4.0 (2024-04-26)


### Features

* **AZ-1401:** add parameter premium_messaging_partitions for azurerm_servicebus_namespace 4b8757e


### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] 627eff7
* **AZ-1391:** update semantic-release config [skip ci] 7f61d28


### Miscellaneous Chores

* **deps:** add renovate.json 43083bb
* **deps:** enable automerge on renovate c498cac
* **deps:** update dependency trivy to v0.50.2 7bf6c83
* **deps:** update dependency trivy to v0.50.4 9a720ad
* **deps:** update renovate.json e2583b6
* **pre-commit:** update commitlint hook 117587a

# v7.3.0 - 2023-09-08

Breaking
  * AZ-1153: Remove `retention_days` parameters, it must be handled at destination level now. (for reference: [Provider issue](https://github.com/hashicorp/terraform-provider-azurerm/issues/23051))

# v7.2.1 - 2023-06-30

Fixed
  * AZ-1107: Fix regression on topics subscriptions

# v7.2.0 - 2023-06-23

Fixed
  * AZ-1107: Fix variable type for `auto_delete_on_idle`

Changed
  * AZ-1107: Add possibility to write with ISO8601 format like `P1D` for several variables

# v7.1.1 - 2023-02-13

Fixed
 * [GH-5](https://github.com/claranet/terraform-azurerm-service-bus/pull/5): Fix sensitive outputs

# v7.1.0 - 2022-11-25

Added
  * AZ-916: Add Authorization Rules naming option for Queues and Topics

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

Fixed
  * AZ-916: Fix Queue `default_message_ttl_in_minutes` parameter and revamp some variables

# v7.0.0 - 2022-11-14

Breaking
  * AZ-840: Require Terraform 1.3+
  * AZ-900: Rework module code, minimum AzureRM version to `v3.28`

Added
  * AZ-900: Add Topics and Subscriptions management
  * AZ-900: Add authentication rules for both queues and topics entities

# v6.2.0 - 2022-11-09

Breaking
  * AZ-898: Fix Service Bus Queue Authorization Rule default name (generated by Azurecaf)

# v6.1.1 - 2022-10-28

Fixed
  * AZ-888: Fix `zone_redundant` parameter in namespaces

# v6.1.0 - 2022-08-29

Added
  * [GH-4](https://github.com/claranet/terraform-azurerm-service-bus/issues/4): Add `zone_redundant` parameter in namespaces

# v6.0.0 - 2022-06-24

Breaking
  * AZ-717: Require Terraform 1.0+
  * AZ-717: Bump AzureRM provider version to `v3.0+`

# v5.0.0 - 2022-03-31

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources
  * AZ-515: Require Terraform 0.13+

Added
  * AZ-589: Add and enable `diagnostics` for each Service Bus namespace

# v4.1.0 - 2022-03-18

Added
  * AZ-615: Add an option to enable or disable default tags

Changed
  * AZ-572: Revamp examples and improve CI

# v4.0.1/v3.0.2 - 2021-08-27

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool

# v3.0.1/v4.0.0 - 2020-12-30

Updated
  * AZ-273: Module now compatible terraform `v0.13+`

Fixed
  * AZ-411: Fix outputs

# v2.0.0/v3.0.0 - 2020-03-30

Added
  * AZ-192: Azure Service Bus - First Release

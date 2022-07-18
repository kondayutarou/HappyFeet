PRODUCT_NAME := HappyFeet

.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-57s%s\n", $$1 $$3, $$2}'

.PHONY: generate-swiftgen
generate-swiftgen:
	mkdir -p HF/Generated
	mint run swiftgen

.PHONY: generate-xcodeproj
generate-xcodeproj: # Generate project with XcodeGen
	$(MAKE) generate-swiftgen
	mint run xcodegen generate
	$(MAKE) open

.PHONY: open
open: # Open workspace in Xcode
	open ./${PRODUCT_NAME}.xcodeproj

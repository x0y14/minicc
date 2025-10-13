.DEFAULT_GOAL := help

OUT_DIR = bin
DOWNLOAD_DIR = downloads
SRC_DIR = src
# MINIVM系
MINIVM_VERSION = v0.2.1
MINIVM_MAIN_GO_PATH = $(DOWNLOAD_DIR)/minivm/cmd/minivm/main.go

# ref: https://qiita.com/po3rin/items/7875ef9db5ca994ff762
.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Remove Tmp Folders and Files
	yes | rm -r $(OUT_DIR) $(DOWNLOAD_DIR)

# ======
# 準備系

.PHONY: setup-download-minivm
setup-download-minivm: ## Download minivm
	mkdir -p $(DOWNLOAD_DIR)
	cd $(DOWNLOAD_DIR); \
		git clone --depth 1 https://github.com/x0y14/minivm -b $(MINIVM_VERSION)

.PHONY: setup-build-minivm
setup-build-minivm: ## Build minivm
	@if [ -f $(MINIVM_MAIN_GO_PATH) ]; then \
		echo "Building minivm..."; \
		mkdir -p $(OUT_DIR); \
		cd $(DOWNLOAD_DIR)/minivm && go build -o ../../$(OUT_DIR)/minivm ./cmd/minivm; \
		echo "minivm built successfully in $(OUT_DIR)/minivm"; \
	else \
		echo "Error: $(MINIVM_MAIN_GO_PATH) not found. Please run 'make setup-download-minivm' first."; \
		exit 1; \
	fi


# =====
# CC系

.PHONY: build-minicc
build-minicc:
	cc -o $(OUT_DIR)/minicc $(SRC_DIR)/minicc.c

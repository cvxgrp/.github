# Define color variables for formatted console output
BLUE := \033[36m  # Blue color for highlighting commands
BOLD := \033[1m   # Bold text for headings
RESET := \033[0m  # Reset formatting

# Set the default target to help (runs when make is called without arguments)
.DEFAULT_GOAL := help

# Declare all phony targets (targets that don't represent files)
.PHONY: help fmt clean

##@ Development Setup

# Create a Python virtual environment using uv
venv:
	@printf "$(BLUE)Creating virtual environment...$(RESET)\n"
	@curl -LsSf https://astral.sh/uv/install.sh | sh  # Install uv package manager
	@uv venv --python 3.12  # Create a virtual environment with Python 3.12

##@ Code Quality

# Run code formatting and linting tools
fmt: venv ## Run code formatting and linting
	@printf "$(BLUE)Running formatters and linters...$(RESET)\n"
	@uv pip install pre-commit  # Install pre-commit hooks manager
	@uv run pre-commit install  # Set up git hooks for pre-commit
	@uv run pre-commit run --all-files  # Run all pre-commit hooks on all files

##@ Cleanup

# Clean generated files and directories
clean: ## Clean generated files and directories
	@printf "$(BLUE)Cleaning project...$(RESET)\n"
	@git clean -d -X -f  # Remove all files ignored by git, including directories

##@ Help

# Display help information about available make targets
help: ## Display this help message
	@printf "$(BOLD)Usage:$(RESET)\n"
	@printf "  make $(BLUE)<target>$(RESET)\n\n"
	@printf "$(BOLD)Targets:$(RESET)\n"
	@awk 'BEGIN {FS = ":.*##"; printf ""} /^[a-zA-Z_-]+:.*?##/ { printf "  $(BLUE)%-15s$(RESET) %s\n", $$1, $$2 } /^##@/ { printf "\n$(BOLD)%s$(RESET)\n", substr($$0, 5) }' $(MAKEFILE_LIST)  # Parse and display formatted help from comments

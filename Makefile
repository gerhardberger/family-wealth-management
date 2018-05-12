help: ## Show this help
	@echo "Targets:"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/\(.*\):.*##[ \t]*/    \1 ## /' | sort | column -t -s '##'
	@echo

up: ##Starts docker
	./build.sh
	./copyKeys.sh
	./run.sh

down: ##Stops docker
	rm -R -- ./chainData/*/

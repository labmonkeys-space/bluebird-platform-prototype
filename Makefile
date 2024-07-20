.DEFAULT_GOAL := compile

ARTIFACT_DIR := target/artifacts

.PHONY: help
help:
	@echo ""
	@echo "help:        Show this help"
	@echo "compile:     Compile the source code"
	@echo "tests:       Build the source code and run tests."
	@echo "build:       Run a clean build with mvn install -DskipTests"
	@echo "clean:       Clean build artifacts"
	@echo ""

.PHONY: deps
deps:
	command -v java
	command -v mvn
	@echo "Check Java JDK version 21"
	@java -version 2>&1 | grep "version \"21\..*\""
	@echo "Create artifacts directory"
	mkdir -p $(ARTIFACT_DIR)

.PHONY: deps-docker
deps-docker:
	@echo "Verify if Docker is installed"
	command -v docker
	@echo "Verify if Docker daemon is running"
	docker ps

.PHONY: compile
compile: deps
	mvn compile

.PHONY: tests
tests:
	mvn test

.PHONY: build
build:
	mvn install -DskipTests
	cp target/eventbus-*.jar $(ARTIFACT_DIR)/eventbus.jar

.PHONY: oci
oci: deps-docker build
	docker build -t symbiote .

.PHONY: clean
clean:
	mvn clean
	rm -rf $(ARTIFACT_DIR)

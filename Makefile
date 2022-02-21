# This code requires a few keys to be set in the environment
ifeq ($(AWS_DEFAULT_REGION),)
$(error "You must set the AWS_DEFAULT_REGION variable")
endif
ifeq ($(AWS_ACCESS_KEY_ID),)
$(error "You must set the AWS_ACCESS_KEY_ID variable")
endif
ifeq ($(AWS_SECRET_ACCESS_KEY),)
$(error "You must set the AWS_SECRET_ACCESS_KEY variable")
endif
ifeq ($(AWS_ACCOUNT_NUMBER),)
$(error "You must set the AWS_ACCOUNT_NUMBER variable")
endif
ifeq ($(PAYROLL_APP_VERSION),)
$(error "You must set the PAYROLL_APP_VERSION variable")
endif



# Syntax highlighting. MacOS ships with an old version of Bash that doesn't
# support the \e escape so we need to use this other escape sequence.
ifeq ("$(strip $(shell uname))","Darwin")
ESC=\x1B
else
ESC=\e
endif

# These are mainly just used to create a headline for each target so it's a
# little easier to visually sort through the output.
BOLD=$(ESC)[1m
CYAN=$(ESC)[36m
NORMAL=$(ESC)[0m


# Change this to your AWS account number.
AWS_ACCOUNT=$(AWS_ACCOUNT_NUMBER)

# You will need to create a repo in ECR called payroll-application.
AWS_ECR_REPONAME=payroll-application


all: build repo docker 

build:  ## Build the JAR
	@echo "\n~~~ $(BOLD)$(CYAN)Building the JAR$(NORMAL) ~~~"
	./mvnw package -DPAYROLL_APP_VERSION=$(PAYROLL_APP_VERSION)-SNAPSHOT
	mkdir -p target/dependency
	cd target/dependency && jar -xf ../payroll-$(PAYROLL_APP_VERSION)-SNAPSHOT.jar

repo:  ## Create the ECR repo
	@echo "\n~~~ $(BOLD)$(CYAN)Creating the ECR repo$(NORMAL) ~~~"
	aws ecr create-repository \
		--repository-name ${AWS_ECR_REPONAME} \
		--image-scanning-configuration scanOnPush=true \
		2>&1 |grep -v RepositoryAlreadyExistsException

docker:  ## Create the Docker image
	@echo "\n~~~ $(BOLD)$(CYAN)Creating the Docker image$(NORMAL) ~~~"
	docker build -t $(AWS_ECR_REPONAME) .
	docker tag $(AWS_ECR_REPONAME):latest $(AWS_ACCOUNT).dkr.ecr.$(AWS_DEFAULT_REGION).amazonaws.com/$(AWS_ECR_REPONAME):latest
	docker push $(AWS_ACCOUNT).dkr.ecr.$(AWS_DEFAULT_REGION).amazonaws.com/$(AWS_ECR_REPONAME):latest

clean:  ## Clean up repository
	@echo "\n~~~ $(BOLD)$(CYAN)Cleaning up$(NORMAL) ~~~"
	rm -rf target/
	@echo "\n~~~ $(BOLD)$(CYAN)Success!$(NORMAL) ~~~\n"

mrproper: clean  ## Clean up files and Docker images
	docker rmi $(AWS_ECR_REPONAME):latest
	docker rmi $(AWS_ACCOUNT).dkr.ecr.$(AWS_DEFAULT_REGION).amazonaws.com/$(AWS_ECR_REPONAME):latest

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help


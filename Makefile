ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent
.DEFAULT_GOAL := help
PROJECTNAME = crypto currency app


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

run: runserver ## Alias for runserver
runserver: ## Start the default django server
	python manage.py runserver

migrate: ## Apply migrations and makemigrations
	python manage.py migrate

makemi:
	python manage.py makemigrations

user:
	python manage.py createsuperuser

manage:
	python manage.py $(ARGS)

clean:
	find . -name "*.pyc" -exec rm -f {} \;
	find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
	find . -path "*/migrations/*.pyc"  -delete

clean-db:
	find . -path "*.db" -delete

clean-all: clean clean-db migrate makemi

%:
	@:

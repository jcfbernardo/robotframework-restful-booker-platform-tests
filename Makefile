RESULTS_DIR := results

.PHONY: setup init test test-api test-ui smoke regression negative e2e clean

setup:
	python -m venv .venv
	.venv/bin/pip install -r requirements.txt

init:
	.venv/bin/rfbrowser init

test:
	.venv/bin/robot -d $(RESULTS_DIR) tests/

test-api:
	.venv/bin/robot -d $(RESULTS_DIR)/api tests/api

test-ui:
	.venv/bin/robot -d $(RESULTS_DIR)/ui tests/ui

smoke:
	.venv/bin/robot --include smoke -d $(RESULTS_DIR) tests/

regression:
	.venv/bin/robot --include regression -d $(RESULTS_DIR) tests/

negative:
	.venv/bin/robot --include negative -d $(RESULTS_DIR) tests/

e2e:
	.venv/bin/robot --include e2e -d $(RESULTS_DIR) tests/

clean:
	rm -rf $(RESULTS_DIR)

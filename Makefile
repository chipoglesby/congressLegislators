WRANGLE_DIR=./wrangle
SCRIPTS_DIR=$(WRANGLE_DIR)/scripts
FETCHED_DIR=$(WRANGLE_DIR)/corral/fetched
COLLATED_DIR=$(WRANGLE_DIR)/corral/collated


all: fetch collate

fetch: fetch_legislators fetch_sessions

fetch_sessions: $(FETCHED_DIR)/sessions.csv
	python $(SCRIPTS_DIR)/fetch_sessions.py

fetch_legislators: fetch_current_legislators fetch_historical_legislators

fetch_current_legislators: $(FETCHED_DIR)/legislators-current.json
	python $(SCRIPTS_DIR)/fetch_unitedstates_legislators.py legislators-current

fetch_historical_legislators: $(FETCHED_DIR)/legislators-historical.json
	python $(SCRIPTS_DIR)/fetch_unitedstates_legislators.py legislators-historical


collate: $(COLLATED_DIR)/legislators.csv\
		 $(COLLATED_DIR)/terms.csv\
		 $(COLLATED_DIR)/congresses.csv

$(COLLATED_DIR)/legislators.csv:
	python $(SCRIPTS_DIR)/collate_legislators.py

$(COLLATED_DIR)/terms.csv:
	python $(SCRIPTS_DIR)/collate_terms.py

$(COLLATED_DIR)/congresses.csv:
	python $(SCRIPTS_DIR)/collate_congresses.py

clean_collate:
	rm -rf $(COLLATED_DIR)
	mkdir -p $(COLLATED_DIR)
	@$(MAKE) $(THIS_FILE) collate




clean:
	rm -r wrangle/corral
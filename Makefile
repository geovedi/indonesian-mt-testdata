
all:
	@./scripts/tokenizer.py < ./data/test.raw.en > ./data/test.tok.en
	@./scripts/tokenizer.py < ./data/test.raw.id > ./data/test.tok.id
	@./scripts/tokenizer.py < ./outputs/gnmt/test.raw.en > ./outputs/gnmt/test.tok.en
	@./scripts/tokenizer.py < ./outputs/gnmt/test.raw.id > ./outputs/gnmt/test.tok.id
	@./scripts/tokenizer.py < ./outputs/gareng/test.raw.en > ./outputs/gareng/test.tok.en
	@./scripts/tokenizer.py < ./outputs/gareng/test.raw.id > ./outputs/gareng/test.tok.id

	# GNMT: EN->ID (case)
	@./scripts/multi-bleu.pl ./data/test.tok.id < outputs/gnmt/test.tok.id
	# GNMT: ID->EN (case)
	@./scripts/multi-bleu.pl ./data/test.tok.en < outputs/gnmt/test.tok.en

	# GNMT: EN->ID (lowercase)
	@./scripts/multi-bleu.pl -lc ./data/test.tok.id < outputs/gnmt/test.tok.id
	# GNMT: ID->EN (lowercase)
	@./scripts/multi-bleu.pl -lc ./data/test.tok.en < outputs/gnmt/test.tok.en


	# GARENG: EN->ID (case)
	@./scripts/multi-bleu.pl ./data/test.tok.id < outputs/gareng/test.tok.id
	# GARENT: ID->EN (case)
	@./scripts/multi-bleu.pl ./data/test.tok.en < outputs/gareng/test.tok.en

	# GARENG: EN->ID (lowercase)
	@./scripts/multi-bleu.pl -lc ./data/test.tok.id < outputs/gareng/test.tok.id
	# GARENT: ID->EN (lowercase)
	@./scripts/multi-bleu.pl -lc ./data/test.tok.en < outputs/gareng/test.tok.en


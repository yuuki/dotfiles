.PHONY: install
install: apply

.PHONY: apply
apply:
	chezmoi -S $(CURDIR) apply --mode symlink --no-tty

.PHONY: apply-force
apply-force:
	chezmoi -S $(CURDIR) apply --mode symlink --force --no-tty

.PHONY: diff
diff:
	chezmoi -S $(CURDIR) diff --mode symlink

.PHONY: verify
verify:
	chezmoi -S $(CURDIR) verify --mode symlink --force --no-tty

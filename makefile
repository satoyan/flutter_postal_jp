.PHONY: generate
generate:
	dart run build_runner build --delete-conflicting-outputs
	# dart format .


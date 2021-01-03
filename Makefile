.PHONY: install
install:
	flutter pub get

.PHONY: dev-debug
dev-debug:
	flutter run --dart-define=DEFINE_ENV=dev --dart-define=DEFINE_APP_SUFFIX=.development --dart-define=DEFINE_APP_NAME=MathFast-D --debug

.PHONY: dev-release
dev-release:
	flutter run --dart-define=DEFINE_ENV=dev --dart-define=DEFINE_APP_SUFFIX=.development --dart-define=DEFINE_APP_NAME=MathFast-R --release

.PHONY: prod-debug
prod-debug:
	flutter run --dart-define=DEFINE_ENV=prod --dart-define=DEFINE_APP_SUFFIX=.production --dart-define=DEFINE_APP_NAME=MathFast --debug

.PHONY: prod-release
prod-release:
	flutter run --dart-define=DEFINE_ENV=prod --dart-define=DEFINE_APP_SUFFIX=.production --dart-define=DEFINE_APP_NAME=MathFast --release

.PHONY: build-ios
build-ios:
	flutter build ios --dart-define=DEFINE_ENV=prod --dart-define=DEFINE_APP_SUFFIX=.production --dart-define=DEFINE_APP_NAME=MathFast --release

.PHONY: build-appbundle
build-appbundle:
	flutter build appbundle --dart-define=DEFINE_ENV=prod --dart-define=DEFINE_APP_SUFFIX=.production --dart-define=DEFINE_APP_NAME=MathFast --release

.PHONY: test
test:
	flutter test --coverage

.PHONY: htmlcoverage
htmlcoverage:
	genhtml coverage/lcov.info -o coverage/html

.PHONY: icon-gen
icon-gen:
	flutter pub run flutter_launcher_icons:main -f launcher_icon.yaml;

.PHONY: clean
clean:
	flutter clean

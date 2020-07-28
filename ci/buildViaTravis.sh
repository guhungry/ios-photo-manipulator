#!/bin/bash
# This script will build the project.

function build() {
  set -o pipefail
  mkdir DerivedData

 build-wrapper-macosx-x86 --out-dir DerivedData/compilation-database \
  xcodebuild clean build test -project WCPhotoManipulator.xcodeproj -scheme WCPhotoManipulator -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone SE (2nd generation),OS=13.6' -enableCodeCoverage YES -configuration Debug GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty -c
}

if [ "$TRAVIS_TAG" == "" ]; then
  echo -e 'Build Branch with Snapshot => Branch ['$TRAVIS_BRANCH']'

  eval build
elif [ "$TRAVIS_TAG" != "" ]; then
  echo -e 'Build Tag for Release =>   Tag ['$TRAVIS_TAG']'

  eval build

  pod spec lint
  pod trunk push
else
  echo -e 'WARN: Should not be here => Branch ['$TRAVIS_BRANCH']  Tag ['$TRAVIS_TAG']  Pull Request ['$TRAVIS_PULL_REQUEST']'

  eval build
fi

./xccov-to-sonarqube-generic.sh ~/Library/Developer/Xcode/DerivedData/*/Logs/Test/*.xcresult/ > sonarqube-generic-coverage.xml

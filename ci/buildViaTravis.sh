#!/bin/bash
# This script will build the project.

if [ "$TRAVIS_TAG" == "" ]; then
  echo -e 'Build Branch with Snapshot => Branch ['$TRAVIS_BRANCH']'
  set -o pipefail
  xcodebuild clean build test -project WCPhotoManipulator.xcodeproj -scheme WCPhotoManipulator -sdk iphonesimulator -configuration Debug GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty -c
elif [ "$TRAVIS_TAG" != "" ]; then
  echo -e 'Build Tag for Release =>   Tag ['$TRAVIS_TAG']'
  set -o pipefail
  xcodebuild clean build test -project WCPhotoManipulator.xcodeproj -scheme WCPhotoManipulator -sdk iphonesimulator -configuration Debug GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty -c

  pod spec lint
  pod trunk push
else
  echo -e 'WARN: Should not be here => Branch ['$TRAVIS_BRANCH']  Tag ['$TRAVIS_TAG']  Pull Request ['$TRAVIS_PULL_REQUEST']'
  set -o pipefail
  xcodebuild clean build test -project WCPhotoManipulator.xcodeproj -scheme WCPhotoManipulator -sdk iphonesimulator -configuration Debug GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES | xcpretty -c
fi

#./xccov-to-sonarqube-generic.sh ~/Library/Developer/Xcode/DerivedData/*/Logs/Test/*/*/*.xccovarchive/ > sonarqube-generic-coverage.xml

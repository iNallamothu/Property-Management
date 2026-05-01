#!/usr/bin/env bash
# Workaround when `flutter run -d ios` fails with:
#   "resource fork, Finder information, or similar detritus not allowed"
# Projects on Desktop/Documents synced by iCloud often trigger this during codesign.
# This copies the app to /tmp (no iCloud xattrs), builds/runs there. Edit Dart files
# in the repo normally; after edits run this script again (copy picks them up).

set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DST="$(mktemp -d /tmp/propflow_ios_run.XXXXXX)"
cleanup() { rm -rf "$DST"; }
trap cleanup EXIT

rsync -a "$SRC/" "$DST/proj/" \
  --exclude build \
  --exclude .dart_tool \
  --exclude ios/Pods \
  --exclude .idea

xattr -cr "$DST/proj"

export PATH="/opt/homebrew/bin:$PATH"
cd "$DST/proj"
flutter pub get
flutter run -d ios "$@"

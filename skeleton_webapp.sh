#!/bin/sh
#
# Skeleton Webapp
#
# Creates a basic web project folder structure with common directories and files:
# - css/, js/, img/, assets/, pages/ folders with .gitkeep files
# - index.html and about.html in the root
# - css/style.css and js/main.js
# - .gitignore that ignores the internal .setup_done flag file
#
# Usage:
# ./skeleton_webapp.sh [target_directory]
#
# If no target_directory is provided, the current directory (.) is used.

# How it works:

# - Checks if a ".setup_done" flag file exists in the target directory.
# If yes, it assumes setup is already done and exits.
# - Creates folders and adds .gitkeep files inside them.
# - Creates essential files.
# - Adds ".setup_done" file to mark completion.
# - Ensures ".setup_done" is ignored by Git.
#
#  Example:
#  ./skeleton_webapp.sh my_new_project
#  -> sets up the structure inside ./my_new_project
#

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  sed -n '2,28p' "$0" # prints lines 2 to 22 from the script itself (the comment block)
  exit 0
fi

TARGET_DIR="${1:-.}"
FLAGFILE="$TARGET_DIR/.setup_done"

if [ -f "$FLAGFILE" ]; then
  echo "Setup already done in $TARGET_DIR, exiting."
  exit 0
fi

# List of directories to create
DIRS="css js img assets pages"

for dir in $DIRS; do
  mkdir -p "$TARGET_DIR/$dir"
  # Add .gitkeep to ensure Git tracks the directory
  touch "$TARGET_DIR/$dir/.gitkeep"
done

touch "$TARGET_DIR/index.html" "$TARGET_DIR/about.html"
touch "$TARGET_DIR/css/style.css"
touch "$TARGET_DIR/js/main.js"
touch "$TARGET_DIR/.gitignore"

touch "$FLAGFILE"

# Add .setup_done to .gitignore if not present
GITIGNORE="$TARGET_DIR/.gitignore"
FLAG_FILENAME=".setup_done"
if ! grep -qxF "$FLAG_FILENAME" "$GITIGNORE" 2>/dev/null; then
  echo "$FLAG_FILENAME" >>"$GITIGNORE"
  echo "Added $FLAG_FILENAME to $GITIGNORE"
fi

echo "Project skeleton created successfully in $TARGET_DIR."

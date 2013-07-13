#!/bin/bash

to_haml() {
  for file in $(find src/ -name '*.haml' | sed s/.haml$// | sed s/src\//)
  do
    echo $file
    haml --double-quote-attributes ./src/$file.haml ./$file &
  done
}

to_html() {
  for file in $(find . -name '*.html')
  do
    mkdir -p src/$(dirname $file)
    html2haml --xhtml --html-attributes --unix-newlines $file src/$file.haml &
  done
}

strip_ws() {
  sed -i "" -e 's/\s*$//' $(find . -name '*.html')
}

case $1 in
  html)
    to_html
    ;;
  haml)
    to_haml
    ;;
  ws)
    strip_ws
    ;;
  *)
    echo "Usage: ./convert.sh {html|haml|ws}"
    exit 1
    ;;
esac


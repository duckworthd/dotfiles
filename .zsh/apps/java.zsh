# Suppress java cli processes from Dock (as of 1.6.0_51)
# http://prod.lists.apple.com/archives/java-dev/2013/Jun/msg00080.html
# http://stackoverflow.com/a/13849939/397334
export _JAVA_OPTIONS="-Djava.awt.headless=true -Xmx2g ${_JAVA_OPTIONS:-}"

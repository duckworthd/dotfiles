PREFIX=$(brew --prefix)
export PATH="$PREFIX/bin:$PATH"
export PATH="$PREFIX/sbin:$PATH"
export CFLAGS="$CFLAGS -I$PREFIX/include"
export CPPFLAGS="$CPPFLAGS -I$PREFIX/include"
export LDFLAGS="$LDFLAGS -L$PREFIX/lib"

# scala
export SCALA_HOME="$PREFIX/Cellar/scala29/2.9.3"

export PATH="/opt/local/bin:$PATH"
export PATH="/opt/local/sbin:$PATH"
export CFLAGS="$CFLAGS -I/opt/local/include"
export CPPFLAGS="$CPPFLAGS -I/opt/local/include"
export LDFLAGS="$LDFLAGS -L/opt/local/lib"

# Python paths
export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin"
export PYTHONPATH="$PYTHONPATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/"

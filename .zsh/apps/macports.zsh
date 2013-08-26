PATH="/opt/local/bin:$PATH"
PATH="/opt/local/sbin:$PATH"
CFLAGS+=" -I/opt/local/include"
CPPFLAGS+=" -I/opt/local/include"
LDFLAGS+=" -L/opt/local/lib"

# Python paths
PATH+="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin"
PYTHONPATH+="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/"

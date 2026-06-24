# CouchJS standalone utility

CouchJS executable that could be built without Erlang.

Only required dependencies is C++ compiler, CMake, make and compatible version of MozJS library
(SpiderMonkey JavaScript engine).

CouchJS original source code has been copied from https://github.com/apache/couchdb/tree/main/src/couch/priv/couch_js, branch `main`, commit 65cd52c96bdf6f35a4a2925ff0ebbc29b6583d93.

## Building from source code

1. `git clone git@github.com:ZaWertun/couchjs-standalone.git`

2. `cd couchjs-standalone`

3. `mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..`

4. `make`

5. `make install` (optional)

## Acknowledgements

This project incorporates code from Apache CouchDB (https://github.com/apache/couchdb).

Original authors of the couchjs utility:

- Iblis Lin <iblis@hs.ntnu.edu.tw>
- Jan Lehnardt <jan@apache.org>
- Joan Touzet <joant@atypical.net>, <wohali@users.noreply.github.com>, <wohali@apache.org>
- Paul J. Davis <paul.joseph.davis@gmail.com>
- Robert Newson <rnewson@apache.org>
- Ronny Berndt <ronny@apache.org>
- Will <w.young@schaetz-cro.ch>
- Will Young <lost.networking@gmail.com>
- jiangph <jiangph@cn.ibm.com>

See the full contributor list:
https://github.com/apache/couchdb/graphs/contributors

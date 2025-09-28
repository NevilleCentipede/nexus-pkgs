Nexus package manager! I am developing it. Wait until it's done. It will be a cross platform package manager. The packages would be cross platform too.
Supported : freebsd, linux, windows. MACOS will be done later.

building,
1. install "musl-libc" for statically linking. Use glibc if you want too.
2. gcc -o nexus main.c for glibc, musl-gcc for musllibc.
3. place busybox binary (windows, linux, feebsd) where the nexuspkgs is.

NOTE : I will use V for this now. As C is too unsafe.

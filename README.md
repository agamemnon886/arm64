1) Install gcc for arm64:

$ sudo apt-get install gcc-aarch64-linux-gnu

2) Install qemu to run arm64 user programs:

$ git clone git://git.qemu.org/qemu.git
$ cd qemu
$ mkdir build
$ ../configure --target-list=aarch64-linux-user
$ make
$ sudo make install

3) Build program:

$ aarch64-linux-gnu-gcc -o bubble_sort_arm64 bubble_sort_arm64.S

3) Run program:

$ qemu-aarch64 -L /usr/aarch64-linux-gnu/ ./bubble_sort_arm64
Before sort:
v[0] = 103
v[1] = 198
v[2] = 105
v[3] = 115
v[4] = 81
v[5] = 255
v[6] = 74
v[7] = 236
v[8] = 41
v[9] = 205
After sort:
v[0] = 41
v[1] = 74
v[2] = 81
v[3] = 103
v[4] = 105
v[5] = 115
v[6] = 198
v[7] = 205
v[8] = 236
v[9] = 255


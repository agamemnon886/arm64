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


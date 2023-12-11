from pwn import *
from ctypes import CDLL
# context.arch = 'amd64'
e = ELF('./pse')
# shell = e.symbols['easy']
libc = CDLL("libc.so.6")
# p = process(e.file.name)
p = remote('92.246.89.201', 10001)
libc.srand(libc.time(0))

for i in range(10):
    n = libc.rand() % 3
    if n == 0:
        # p.sendline("Pizza")
        p.sendline("Espresso")
    elif n == 1:
        # p.sendline("Espresso")
        p.sendline("Spaghetti")
    else:
        # p.sendline("Spaghetti")
        p.sendline("Pizza")
# print(p.recvline_contains('Choice not recognized'))
# for i in range(10):
#     print(p.recvline_contains('WIN RATE'))
p.interactive()

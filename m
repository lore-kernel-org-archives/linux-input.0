From: Kyungtae Kim <kt0755@gmail.com>
Subject: UBSAN: Undefined behaviour in drivers/input/misc/uinput.c
Date: Mon, 14 Jan 2019 16:19:44 -0500
Message-ID: <CAEAjamv5mBAoZAcEc962v6VMCw27h6yBCt1OxCgzyZRgozfCjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rydberg@bitmath.org
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong <threeearcat@gmail.com>, syzkaller@googlegroups.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We report a bug in linux-4.19.13: "UBSAN: Undefined behaviour in
drivers/input/misc/uinput.c"

kernel config: https://kt0755.github.io/etc/config_4.19.13
repro: https://kt0755.github.io/etc/repro.c4925.c

An integer overflow arose  in uinput_validate_absinfo
(drivers/input/misc/uinput.c:420).
To be specific, "if (abs->flat > max - min)" cannot be represented in
type 'int'.
Thing is, in this case, abs->flat, max and min come from user supplied input.
To fix, an appropriate sanity check of that calculation should be
placed right before the usage.

=========================================
UBSAN: Undefined behaviour in drivers/input/misc/uinput.c:420:22
signed integer overflow:
841280591 - -1832774988 cannot be represented in type 'int'
CPU: 0 PID: 7372 Comm: syz-executor3 Not tainted 4.19.13 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x1cf/0x21a lib/ubsan.c:190
 __ubsan_handle_sub_overflow+0x2a/0x31 lib/ubsan.c:206
 uinput_validate_absinfo.isra.2+0x194/0x1a0 drivers/input/misc/uinput.c:420
 uinput_abs_setup drivers/input/misc/uinput.c:503 [inline]
 uinput_ioctl_handler+0xa57/0x1bf0 drivers/input/misc/uinput.c:1036
 uinput_ioctl+0x2d/0x40 drivers/input/misc/uinput.c:1048
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1aa/0x1160 fs/ioctl.c:690
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:705
 __do_sys_ioctl fs/ioctl.c:712 [inline]
 __se_sys_ioctl fs/ioctl.c:710 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:710
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7b273c3c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7b273c46cc RCX: 00000000004497b9
RDX: 0000000020000000 RSI: 0000004040105504 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000005ca0 R14: 00000000006eed40 R15: 00007f7b273c4700
=========================================

Thanks,
Kyungtae Kim

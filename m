From: Kyungtae Kim <kt0755@gmail.com>
Subject: Fwd: UBSAN: Undefined behaviour in drivers/input/mousedev.c
Date: Mon, 26 Nov 2018 00:29:49 -0500
Message-ID: <CAEAjamtBeQEmzHQqLPW452e0b=T-_697zmZ+x_Buh9U8VjTE4w@mail.gmail.com>
References: <CAEAjamvKOzcQ4cQuUpDXAKQsq0Rq1+75DhHAp2fYjAk2NnLUOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEAjamvKOzcQ4cQuUpDXAKQsq0Rq1+75DhHAp2fYjAk2NnLUOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

---------- Forwarded message ---------
From: Kyungtae Kim <kt0755@gmail.com>
Date: Mon, Nov 26, 2018 at 12:26 AM
Subject: UBSAN: Undefined behaviour in drivers/input/mousedev.c
To: <dmitry.torokhov@gmail.com>
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong
<threeearcat@gmail.com>, <linux-input@vger.kernel.org>,
<linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>


We report a crash found in v4.20-rc2:

kernel config: https://kt0755.github.io/etc/config_v4.20
repro: https://kt0755.github.io/etc/repro.5266f.c

In mousedev_rel_event(), "mousedev->packet.dx += value"
(driver/input/mousedev.c:212) causes integer overflow
when the result of calculation is larger than the size of dx.
This can arise because "value" originates from user input
(via evdev_write), and there is no sanity check along the path.

It's not for sure this crash would be tolerable despite its occurrence.
But one way to stop it is to use the bounds check before using it.


Crash log:
=======================================
UBSAN: Undefined behaviour in drivers/input/mousedev.c:212:23
signed integer overflow:
1240408832 + 1240408832 cannot be represented in type 'int'
CPU: 0 PID: 10708 Comm: syz-executor3 Not tainted 4.20.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xb1/0x118 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x2dc/0x327 lib/ubsan.c:190
 __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
 mousedev_rel_event drivers/input/mousedev.c:212 [inline]
 mousedev_event+0x14ad/0x1830 drivers/input/mousedev.c:370
 input_to_handler+0x414/0x510 drivers/input/input.c:121
 input_pass_values.part.10+0x4ed/0x6c0 drivers/input/input.c:148
 input_pass_values drivers/input/input.c:401 [inline]
 input_handle_event+0x3f0/0x1200 drivers/input/input.c:401
 input_inject_event+0x22f/0x31e drivers/input/input.c:466
 evdev_write+0x483/0x7a0 drivers/input/evdev.c:565
 __vfs_write+0x109/0x6e0 fs/read_write.c:485
 vfs_write+0x1b3/0x520 fs/read_write.c:549
 ksys_write+0xde/0x1c0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
 do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4148cd3c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4148cd46cc RCX: 00000000004497b9
RDX: 00000000000002a6 RSI: 0000000020000080 RDI: 0000000000000014
RBP: 000000000071c010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000b820 R14: 00000000006f48c0 R15: 00007f4148cd4700
======================================

Thanks,
Kyungtae Kim

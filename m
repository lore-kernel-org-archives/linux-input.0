From: syzbot <syzbot+b1f387654f49043c302b@syzkaller.appspotmail.com>
Subject: KASAN: use-after-free Read in str_to_user
Date: Tue, 03 Sep 2019 05:08:13 -0700
Message-ID: <00000000000056ee310591a4f18a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andreyknvl@google.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=112b0312600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=b1f387654f49043c302b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b1f387654f49043c302b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in strlen+0x79/0x90 lib/string.c:525
Read of size 1 at addr ffff8881d642fc88 by task syz-executor.2/10208

CPU: 1 PID: 10208 Comm: syz-executor.2 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  strlen+0x79/0x90 lib/string.c:525
  strlen include/linux/string.h:281 [inline]
  str_to_user+0x27/0x90 drivers/input/evdev.c:802
  evdev_do_ioctl drivers/input/evdev.c:1205 [inline]
  evdev_ioctl_handler+0x1388/0x19e0 drivers/input/evdev.c:1303
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
  ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459879
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4510becc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459879
RDX: 00000000200000c0 RSI: 0000000080404507 RDI: 0000000000000009
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4510bed6d4
R13: 00000000004c1aaf R14: 00000000004d4de0 R15: 00000000ffffffff

Allocated by task 1601:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:552 [inline]
  syslog_print kernel/printk/printk.c:1346 [inline]
  do_syslog kernel/printk/printk.c:1519 [inline]
  do_syslog+0x540/0x1380 kernel/printk/printk.c:1493
  kmsg_read+0x8a/0xb0 fs/proc/kmsg.c:40
  proc_reg_read+0x1c1/0x280 fs/proc/inode.c:223
  __vfs_read+0x76/0x100 fs/read_write.c:425
  vfs_read+0x1ea/0x430 fs/read_write.c:461
  ksys_read+0x127/0x250 fs/read_write.c:587
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 1601:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  syslog_print kernel/printk/printk.c:1405 [inline]
  do_syslog kernel/printk/printk.c:1519 [inline]
  do_syslog+0x1098/0x1380 kernel/printk/printk.c:1493
  kmsg_read+0x8a/0xb0 fs/proc/kmsg.c:40
  proc_reg_read+0x1c1/0x280 fs/proc/inode.c:223
  __vfs_read+0x76/0x100 fs/read_write.c:425
  vfs_read+0x1ea/0x430 fs/read_write.c:461
  ksys_read+0x127/0x250 fs/read_write.c:587
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d642fa80
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 520 bytes inside of
  1024-byte region [ffff8881d642fa80, ffff8881d642fe80)
The buggy address belongs to the page:
page:ffffea0007590b00 refcount:1 mapcount:0 mapping:ffff8881da002280  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000200000001 ffff8881da002280
raw: 0000000000000000 00000000000e000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d642fb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d642fc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d642fc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8881d642fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d642fd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

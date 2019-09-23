From: syzbot <syzbot+bea56e0be9fb9106bcf3@syzkaller.appspotmail.com>
Subject: KASAN: use-after-free Read in xpad_play_effect
Date: Mon, 23 Sep 2019 07:31:09 -0700
Message-ID: <0000000000005365ff0593394532@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: aicommander@gmail.com, andreyknvl@google.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, ramzeto@gmail.com, rfontana@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tom@steelseries.com
List-Id: linux-input@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=14aeeab1600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=bea56e0be9fb9106bcf3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bea56e0be9fb9106bcf3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3377/0x3eb0  
kernel/locking/lockdep.c:3828
Read of size 8 at addr ffff8881ceebdc10 by task syz-executor.4/7298

CPU: 0 PID: 7298 Comm: syz-executor.4 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:618
  __lock_acquire+0x3377/0x3eb0 kernel/locking/lockdep.c:3828
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4487
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
  xpad_play_effect+0xfe/0xc50 drivers/input/joystick/xpad.c:1225
  ml_play_effects+0x817/0x1270 drivers/input/ff-memless.c:398
  ml_ff_playback+0x285/0x3d0 drivers/input/ff-memless.c:460
  input_ff_event+0x13a/0x2e0 drivers/input/ff-core.c:286
  input_handle_event+0x64e/0x1330 drivers/input/input.c:374
  input_inject_event+0x30a/0x323 drivers/input/input.c:462
  evdev_write+0x2c9/0x410 drivers/input/evdev.c:561
  __vfs_write+0x76/0x100 fs/read_write.c:494
  vfs_write+0x262/0x5c0 fs/read_write.c:558
  ksys_write+0x1e8/0x250 fs/read_write.c:611
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a09
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f53d068cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a09
RDX: 0000000000000364 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f53d068d6d4
R13: 00000000004c9bfc R14: 00000000004e1480 R15: 00000000ffffffff

Allocated by task 6364:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:493 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:466
  slab_post_alloc_hook mm/slab.h:520 [inline]
  slab_alloc_node mm/slub.c:2770 [inline]
  __kmalloc_node_track_caller+0xfc/0x3d0 mm/slub.c:4365
  __kmalloc_reserve.isra.0+0x39/0xe0 net/core/skbuff.c:141
  __alloc_skb+0xef/0x5a0 net/core/skbuff.c:209
  alloc_skb include/linux/skbuff.h:1049 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1174 [inline]
  netlink_sendmsg+0x8cd/0xcc0 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg+0xcf/0x120 net/socket.c:657
  ___sys_sendmsg+0x803/0x920 net/socket.c:2311
  __sys_sendmsg+0xec/0x1b0 net/socket.c:2356
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6364:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:455
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  skb_free_head+0x8b/0xa0 net/core/skbuff.c:591
  skb_release_data+0x41f/0x7c0 net/core/skbuff.c:611
  skb_release_all+0x46/0x60 net/core/skbuff.c:665
  __kfree_skb net/core/skbuff.c:679 [inline]
  consume_skb net/core/skbuff.c:838 [inline]
  consume_skb+0xd9/0x320 net/core/skbuff.c:832
  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
  netlink_unicast+0x4d7/0x690 net/netlink/af_netlink.c:1328
  netlink_sendmsg+0x802/0xcc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg+0xcf/0x120 net/socket.c:657
  ___sys_sendmsg+0x803/0x920 net/socket.c:2311
  __sys_sendmsg+0xec/0x1b0 net/socket.c:2356
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881ceebdb00
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 272 bytes inside of
  1024-byte region [ffff8881ceebdb00, ffff8881ceebdf00)
The buggy address belongs to the page:
page:ffffea00073baf00 refcount:1 mapcount:0 mapping:ffff8881da002280  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000100000001 ffff8881da002280
raw: 0000000000000000 00000000000e000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881ceebdb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881ceebdb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881ceebdc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8881ceebdc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881ceebdd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

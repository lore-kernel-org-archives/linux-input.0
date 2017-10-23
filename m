From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/input/gtco: slab-out-of-bounds in parse_hid_report_descriptor
Date: Mon, 23 Oct 2017 13:24:23 +0200
Message-ID: <CAAeHK+zkQKsWwPd0CSLdwudL2tR_Z=iXniNdu_L+YtkyUcGceg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit 3e0cc09a3a2c40ec1ffb6b4e12da86e98feccb11 (4.14-rc5+).

parse_hid_report_descriptor() has a while (i < length) loop, which
only guarantees that there's at least 1 byte in the buffer, but the
loop body can read multiple bytes which causes out-of-bounds access.

==================================================================
BUG: KASAN: slab-out-of-bounds in parse_hid_report_descriptor+0x1229/0x12a0
Read of size 1 at addr ffff8800674bb2d9 by task kworker/1:2/1038

CPU: 1 PID: 1038 Comm: kworker/1:2 Not tainted 4.14.0-rc5+ #537
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:16
 dump_stack+0x192/0x22c lib/dump_stack.c:52
 print_address_description+0x73/0x280 mm/kasan/report.c:252
 kasan_report_error mm/kasan/report.c:351
 kasan_report+0x238/0x350 mm/kasan/report.c:409
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:427
 parse_hid_report_descriptor+0x1229/0x12a0 drivers/input/tablet/gtco.c:242
 gtco_probe+0x12b7/0x18d0 drivers/input/tablet/gtco.c:921
 usb_probe_interface+0x34c/0x8c0 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x60b/0xa00 drivers/base/dd.c:557
 __device_attach_driver+0x22b/0x290 drivers/base/dd.c:653
 bus_for_each_drv+0x159/0x200 drivers/base/bus.c:463
 __device_attach+0x264/0x3c0 drivers/base/dd.c:710
 device_initial_probe+0x1a/0x20 drivers/base/dd.c:757
 bus_probe_device+0x1d5/0x280 drivers/base/bus.c:523
 device_add+0xcf4/0x1630 drivers/base/core.c:1835
 usb_set_configuration+0x105f/0x1880 drivers/usb/core/message.c:1932
 generic_probe+0x6e/0xe0 drivers/usb/core/generic.c:174
 usb_probe_device+0xaa/0xe0 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x60b/0xa00 drivers/base/dd.c:557
 __device_attach_driver+0x22b/0x290 drivers/base/dd.c:653
 bus_for_each_drv+0x159/0x200 drivers/base/bus.c:463
 __device_attach+0x264/0x3c0 drivers/base/dd.c:710
 device_initial_probe+0x1a/0x20 drivers/base/dd.c:757
 bus_probe_device+0x1d5/0x280 drivers/base/bus.c:523
 device_add+0xcf4/0x1630 drivers/base/core.c:1835
 usb_new_device+0x7b3/0x1010 drivers/usb/core/hub.c:2457
 hub_port_connect drivers/usb/core/hub.c:4903
 hub_port_connect_change drivers/usb/core/hub.c:5009
 port_event drivers/usb/core/hub.c:5115
 hub_event+0x23c3/0x37c0 drivers/usb/core/hub.c:5195
 process_one_work+0x9f6/0x1560 kernel/workqueue.c:2119
 worker_thread+0x1df/0x1350 kernel/workqueue.c:2253
 kthread+0x31f/0x3f0 kernel/kthread.c:231
 ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:431

Allocated by task 1038:
 save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
 __kmalloc+0x7c/0x1d0 mm/slub.c:3782
 kmalloc ./include/linux/slab.h:498
 kzalloc ./include/linux/slab.h:666
 gtco_probe+0x54e/0x18d0 drivers/input/tablet/gtco.c:900
 usb_probe_interface+0x34c/0x8c0 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x60b/0xa00 drivers/base/dd.c:557
 __device_attach_driver+0x22b/0x290 drivers/base/dd.c:653
 bus_for_each_drv+0x159/0x200 drivers/base/bus.c:463
 __device_attach+0x264/0x3c0 drivers/base/dd.c:710
 device_initial_probe+0x1a/0x20 drivers/base/dd.c:757
 bus_probe_device+0x1d5/0x280 drivers/base/bus.c:523
 device_add+0xcf4/0x1630 drivers/base/core.c:1835
 usb_set_configuration+0x105f/0x1880 drivers/usb/core/message.c:1932
 generic_probe+0x6e/0xe0 drivers/usb/core/generic.c:174
 usb_probe_device+0xaa/0xe0 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x60b/0xa00 drivers/base/dd.c:557
 __device_attach_driver+0x22b/0x290 drivers/base/dd.c:653
 bus_for_each_drv+0x159/0x200 drivers/base/bus.c:463
 __device_attach+0x264/0x3c0 drivers/base/dd.c:710
 device_initial_probe+0x1a/0x20 drivers/base/dd.c:757
 bus_probe_device+0x1d5/0x280 drivers/base/bus.c:523
 device_add+0xcf4/0x1630 drivers/base/core.c:1835
 usb_new_device+0x7b3/0x1010 drivers/usb/core/hub.c:2457
 hub_port_connect drivers/usb/core/hub.c:4903
 hub_port_connect_change drivers/usb/core/hub.c:5009
 port_event drivers/usb/core/hub.c:5115
 hub_event+0x23c3/0x37c0 drivers/usb/core/hub.c:5195
 process_one_work+0x9f6/0x1560 kernel/workqueue.c:2119
 worker_thread+0x1df/0x1350 kernel/workqueue.c:2253
 kthread+0x31f/0x3f0 kernel/kthread.c:231
 ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:431

Freed by task 2771:
 save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_slab_free+0x72/0xc0 mm/kasan/kasan.c:524
 slab_free_hook mm/slub.c:1390
 slab_free_freelist_hook mm/slub.c:1412
 slab_free mm/slub.c:2988
 kfree+0x91/0x190 mm/slub.c:3919
 __vunmap+0x1e6/0x270 mm/vmalloc.c:1545
 vfree+0x50/0xe0 mm/vmalloc.c:1606
 n_tty_close+0xb2/0x120 drivers/tty/n_tty.c:1864
 tty_ldisc_close.isra.0+0x99/0xd0 drivers/tty/tty_ldisc.c:490
 tty_ldisc_kill+0x45/0xb0 drivers/tty/tty_ldisc.c:639
 tty_ldisc_hangup+0x29b/0x5e0 drivers/tty/tty_ldisc.c:757
 __tty_hangup.part.24+0x433/0x860 drivers/tty/tty_io.c:612
 __tty_hangup drivers/tty/tty_io.c:570
 tty_vhangup+0x21/0x30 drivers/tty/tty_io.c:684
 pty_close+0x437/0x590 drivers/tty/pty.c:77
 tty_release+0x464/0x15f0 drivers/tty/tty_io.c:1638
 __fput+0x31f/0x7e0 fs/file_table.c:210
 ____fput+0x15/0x20 fs/file_table.c:244
 task_work_run+0x229/0x2e0 kernel/task_work.c:112
 tracehook_notify_resume ./include/linux/tracehook.h:191
 exit_to_usermode_loop+0x1c5/0x200 arch/x86/entry/common.c:162
 prepare_exit_to_usermode arch/x86/entry/common.c:197
 syscall_return_slowpath+0x2b6/0x330 arch/x86/entry/common.c:266
 entry_SYSCALL_64_fastpath+0xa3/0xa5 arch/x86/entry/entry_64.S:238

The buggy address belongs to the object at ffff8800674bb2a0
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 57 bytes inside of
 64-byte region [ffff8800674bb2a0, ffff8800674bb2e0)
The buggy address belongs to the page:
page:ffffea00019d2ec0 count:1 mapcount:0 mapping:          (null)
index:0xffff8800674bb8a0
flags: 0x100000000000100(slab)
raw: 0100000000000100 0000000000000000 ffff8800674bb8a0 00000001802a001c
raw: ffffea0001a67a00 0000000600000005 ffff88006c8018c0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8800674bb180: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
 ffff8800674bb200: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
>ffff8800674bb280: fc fc fc fc 00 00 00 00 00 00 00 01 fc fc fc fc
                                                    ^
 ffff8800674bb300: 00 00 00 00 00 00 00 00 fc fc fc fc fb fb fb fb
 ffff8800674bb380: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
==================================================================

From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/misc/ims-pcu: slab-out-of-bounds in ims_pcu_parse_cdc_data
Date: Thu, 28 Sep 2017 13:35:51 +0200
Message-ID: <CAAeHK+w_9oFs4=2PLY++EKgVme7KJ07F8AkOgwePdX+p2tK1qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Johan Hovold <johan@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit dc972a67cc54585bd83ad811c4e9b6ab3dcd427e (4.14-rc2+).

There's no check that the length of intf->altsetting->extra is big
enough to hold usb_cdc_union_desc struct.

==================================================================
BUG: KASAN: slab-out-of-bounds in ims_pcu_probe+0x39c4/0x3cd0
Read of size 1 at addr ffff88006a697704 by task kworker/0:1/24

CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 4.14.0-rc2-42664-gaf7d1481b3cb #297
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:16
 dump_stack+0x292/0x395 lib/dump_stack.c:52
 print_address_description+0x78/0x280 mm/kasan/report.c:252
 kasan_report_error mm/kasan/report.c:351
 kasan_report+0x23d/0x350 mm/kasan/report.c:409
 __asan_report_load1_noabort+0x19/0x20 mm/kasan/report.c:427
 ims_pcu_parse_cdc_data drivers/input/misc/ims-pcu.c:1642
 ims_pcu_probe+0x39c4/0x3cd0 drivers/input/misc/ims-pcu.c:2009
 usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
 bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
 __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
 bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
 device_add+0xd0b/0x1660 drivers/base/core.c:1835
 usb_set_configuration+0x104e/0x1870 drivers/usb/core/message.c:1932
 generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
 usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:413
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:557
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:653
 bus_for_each_drv+0x161/0x210 drivers/base/bus.c:463
 __device_attach+0x26e/0x3d0 drivers/base/dd.c:710
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:757
 bus_probe_device+0x1eb/0x290 drivers/base/bus.c:523
 device_add+0xd0b/0x1660 drivers/base/core.c:1835
 usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
 hub_port_connect drivers/usb/core/hub.c:4903
 hub_port_connect_change drivers/usb/core/hub.c:5009
 port_event drivers/usb/core/hub.c:5115
 hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
 process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
 worker_thread+0x221/0x1850 kernel/workqueue.c:2253
 kthread+0x3a1/0x470 kernel/kthread.c:231
 ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431

Allocated by task 24:
 save_stack_trace+0x1b/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
 __kmalloc+0x14e/0x310 mm/slub.c:3782
 kmalloc ./include/linux/slab.h:498
 usb_get_configuration+0x372/0x2af0 drivers/usb/core/config.c:856
 usb_enumerate_device drivers/usb/core/hub.c:2290
 usb_new_device+0xaae/0x1020 drivers/usb/core/hub.c:2426
 hub_port_connect drivers/usb/core/hub.c:4903
 hub_port_connect_change drivers/usb/core/hub.c:5009
 port_event drivers/usb/core/hub.c:5115
 hub_event+0x194d/0x3740 drivers/usb/core/hub.c:5195
 process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
 worker_thread+0x221/0x1850 kernel/workqueue.c:2253
 kthread+0x3a1/0x470 kernel/kthread.c:231
 ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431

Freed by task 3948:
 save_stack_trace+0x1b/0x20 arch/x86/kernel/stacktrace.c:59
 save_stack+0x43/0xd0 mm/kasan/kasan.c:447
 set_track mm/kasan/kasan.c:459
 kasan_slab_free+0x72/0xc0 mm/kasan/kasan.c:524
 slab_free_hook mm/slub.c:1390
 slab_free_freelist_hook mm/slub.c:1412
 slab_free mm/slub.c:2988
 kfree+0xf6/0x2f0 mm/slub.c:3919
 kzfree+0x2d/0x40 mm/slab_common.c:1440
 aa_free_task_context+0xd0/0x130 security/apparmor/context.c:54
 apparmor_cred_free+0x38/0x70 security/apparmor/lsm.c:59
 security_cred_free+0x4d/0x90 security/security.c:994
 put_cred_rcu+0x11b/0x420 kernel/cred.c:117
 __rcu_reclaim kernel/rcu/rcu.h:195
 rcu_do_batch.isra.54+0x4e0/0x990 kernel/rcu/tree.c:2691
 invoke_rcu_callbacks kernel/rcu/tree.c:2945
 __rcu_process_callbacks kernel/rcu/tree.c:2912
 rcu_process_callbacks+0x47d/0xc10 kernel/rcu/tree.c:2929
 __do_softirq+0x2ee/0xc0f kernel/softirq.c:284

The buggy address belongs to the object at ffff88006a6976f0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 20 bytes inside of
 32-byte region [ffff88006a6976f0, ffff88006a697710)
The buggy address belongs to the page:
page:ffffea0001a9a5c0 count:1 mapcount:0 mapping:          (null) index:0x0
flags: 0x100000000000100(slab)
raw: 0100000000000100 0000000000000000 0000000000000000 0000000180550055
raw: ffffea0001aa83c0 0000000400000004 ffff88006c403980 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88006a697600: fb fb fb fb fc fc fb fb fb fb fc fc fb fb fb fb
 ffff88006a697680: fc fc fb fb fb fb fc fc 00 00 00 00 fc fc 00 00
>ffff88006a697700: 04 fc fc fc fb fb fb fb fc fc fb fb fb fb fc fc
                   ^
 ffff88006a697780: fb fb fb fb fc fc fb fb fb fb fc fc fb fb fb fb
 ffff88006a697800: fc fc fb fb fb fb fc fc fb fb fb fb fc fc fb fb
==================================================================

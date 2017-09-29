From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/input/iforce: URB submitted while active in iforce_get_id_packet
Date: Fri, 29 Sep 2017 15:40:41 +0200
Message-ID: <CAAeHK+yo=KR5pcvCGXmrZdheHzh2ZZ+BJ64p81B7LrwPwkOaGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

Hi!

I've been getting reports like the one below while fuzzing the kernel
with syzkaller. I can't reproduce the issue without the local changes
I have to USB core, but this is only place where I get a report like
this, and I'm trying to understand whether it is legit.

iforce_init_device() calls iforce_get_id_packet() in a loop.
iforce_get_id_packet() submits urb by calling usb_submit_urb() and
then waits until the urb is processed by calling
wait_event_interruptible_timeout(urb->status != -EINPROGRESS). If urb
is not processed for some reason (urb->status != 0) it calls
usb_unlink_urb().

Normally wait_event_interruptible_timeout() returns some positive
value (I saw 98, 1 and 12) and hub->status ends up either 0 or -75. In
the latter case usb_unlink_urb() returns -43 and sets
usb->usb_unlink_urb to NULL.

The issue happens after a few iterations.

At some point wait_event_interruptible_timeout() returns -ERESTARTSYS.
The reason for that is that I handle hub events synchronously from
userspace and the process gets killed while doing that. I'm not sure
whether a hub_event() thread can be interrupted just like that under
normal circumstances.

In this case hub->status ends up being -115 (-EINPROGRESS) and
usb_unlink_urb() returns -115 and for some reason doesn't set
urb->hcpriv to NULL. As a result we get the warning on the next
iteration.

I don't see an issue with the code, but I might be missing something.
I'm also not sure whether the described sequence of events might
happen under normal circumstances.

On commit 770b782f555d663d133fcd4dc1632023f79357b9 (4.14-rc2+).

Thanks!

URB ffff88006bf0ae00 submitted while active
------------[ cut here ]------------
WARNING: CPU: 0 PID: 4311 at drivers/usb/core/urb.c:341
usb_submit_urb+0xc71/0x11d0
Modules linked in:
CPU: 1 PID: 4311 Comm: syz-executor Not tainted
4.14.0-rc2-42789-g5040ea074b17 #341
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff8800675898c0 task.stack: ffff88005c240000
RIP: 0010:usb_submit_urb+0xc71/0x11d0 drivers/usb/core/urb.c:341
RSP: 0018:ffff88005c245b38 EFLAGS: 00010282
RAX: 000000000000002b RBX: ffff88006bf0ae00 RCX: 0000000000000000
RDX: 000000000000002b RSI: ffffffff81327359 RDI: ffffed000b848b59
RBP: ffff88005c245c38 R08: ffff88005c244f68 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1000b848b6e
R13: 00000000fffffff0 R14: ffff88006701c278 R15: ffff88005c245d58
FS:  0000000001644940(0000) GS:ffff88006c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ef54ce000 CR3: 000000006a416000 CR4: 00000000000006e0
Call Trace:
 iforce_get_id_packet+0x299/0x970
drivers/input/joystick/iforce/iforce-packets.c:258
 iforce_init_device+0x3bb/0x15b0 drivers/input/joystick/iforce/iforce-main.c:316
 iforce_usb_probe+0xafb/0x1520 drivers/input/joystick/iforce/iforce-usb.c:179
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
 usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2538
 hub_port_connect drivers/usb/core/hub.c:4984
 hub_port_connect_change drivers/usb/core/hub.c:5090
 port_event drivers/usb/core/hub.c:5196
 hub_event_impl+0x1971/0x3760 drivers/usb/core/hub.c:5310
 gfs_hub_events_handle+0x881/0xae0 drivers/usb/core/hub.c:1853
 hub_ioctl+0x53d/0x680 drivers/usb/core/hub.c:1903
 proc_ioctl+0x435/0x680 drivers/usb/core/devio.c:2166
 proc_ioctl_default drivers/usb/core/devio.c:2189
 usbdev_do_ioctl+0xee9/0x3790 drivers/usb/core/devio.c:2503
 usbdev_ioctl+0x2a/0x40 drivers/usb/core/devio.c:2547
 vfs_ioctl fs/ioctl.c:45
 do_vfs_ioctl+0x1c4/0x15c0 fs/ioctl.c:685
 SYSC_ioctl fs/ioctl.c:700
 SyS_ioctl+0x94/0xc0 fs/ioctl.c:691
 entry_SYSCALL_64_fastpath+0x23/0xc2 arch/x86/entry/entry_64.S:202
RIP: 0033:0x447707
RSP: 002b:00007ffee67510b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 0000000000447707
RDX: 00007ffee67510d0 RSI: 00000000c0105512 RDI: 0000000000000015
RBP: 0000000000000005 R08: 0000000001644940 R09: 0000000001644940
R10: 00000000004a8e59 R11: 0000000000000206 R12: 0000000000000015
R13: 0000000000000000 R14: 00007ffee6750f88 R15: 00007ffee6750ff8
Code: ff 06 0f 87 0f fc ff ff 42 ff 24 fd 80 5f c8 85 e8 45 92 f4 fd
48 89 de 48 c7 c7 40 5e c8 85 c6 05 8d 0a a7 03 01 e8 99 3b dd fd <0f>
ff e9 83 f4 ff ff e8 23 92 f4 fd 49 8d 7f 06 48 ba 00 00 00
---[ end trace f72bae199ed86131 ]---

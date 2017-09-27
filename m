From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/input/aiptek: warning in aiptek_open/usb_submit_urb
Date: Wed, 27 Sep 2017 16:35:53 +0200
Message-ID: <CAAeHK+wnQ57+yQQ3rw-BKcO0PWDtR32Aw6b_nt51fP08neY48Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:46088 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbdI0Ofy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 27 Sep 2017 10:35:54 -0400
Received: by mail-oi0-f46.google.com with SMTP id a74so16946502oib.3
        for <linux-input@vger.kernel.org>; Wed, 27 Sep 2017 07:35:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>

Hi!

I've got the following report while fuzzing the kernel with syzkaller.

On commit e19b205be43d11bff638cad4487008c48d21c103 (4.14-rc2).

It seems that there's no check on the actual type of the endpoint.

usb 1-1: BOGUS urb xfer, pipe 1 != type 3
------------[ cut here ]------------
WARNING: CPU: 0 PID: 24 at drivers/usb/core/urb.c:449
usb_submit_urb+0xf8a/0x11d0
Modules linked in:
CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 4.14.0-rc2-42660-g24b7bd59eec0 #277
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
task: ffff88006befe300 task.stack: ffff88006bf78000
RIP: 0010:usb_submit_urb+0xf8a/0x11d0 drivers/usb/core/urb.c:448
RSP: 0018:ffff88006bf7e040 EFLAGS: 00010286
RAX: 0000000000000029 RBX: ffff880069c00f00 RCX: 0000000000000000
RDX: 0000000000000029 RSI: ffffffff85a58840 RDI: ffffed000d7efbfa
RBP: ffff88006bf7e140 R08: 1ffff1000d7efaa0 R09: 0000000000000000
R10: ffff88006bf7e168 R11: 0000000000000000 R12: 1ffff1000d7efc0f
R13: 0000000000000003 R14: 0000000000000001 R15: ffff88006978ade0
FS:  0000000000000000(0000) GS:ffff88006c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ad8cf0000 CR3: 000000006aa19000 CR4: 00000000000006f0
Call Trace:
 aiptek_open+0xda/0x120 drivers/input/tablet/aiptek.c:850
 input_open_device+0x17c/0x250 drivers/input/input.c:603
 kbd_connect+0x103/0x150 drivers/tty/vt/keyboard.c:1515
 input_attach_handler+0x59a/0x740 drivers/input/input.c:1002
 input_register_device+0xce0/0xf90 drivers/input/input.c:2159
 aiptek_probe+0x16fd/0x1b90 drivers/input/tablet/aiptek.c:1893
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
Code: 48 8b 85 30 ff ff ff 48 8d b8 98 00 00 00 e8 4e 92 8b ff 45 89
e8 44 89 f1 4c 89 fa 48 89 c6 48 c7 c7 c0 5a c8 85 e8 f0 4a dd fd <0f>
ff e9 9b f7 ff ff e8 da cb 26 fe e9 80 f7 ff ff e8 70 a1 f4
---[ end trace e8e0a0fb4ff1e35d ]---

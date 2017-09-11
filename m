From: Andrey Konovalov <andreyknvl@google.com>
Subject: usb/joystick: warnings in xpad_start_input and xpad_try_sending_next_out_packet
Date: Mon, 11 Sep 2017 14:26:10 +0200
Message-ID: <CAAeHK+wp5Q15BZ7M26SUGMYW7jCcNo+ckNfOHV+VEHgUUJnN+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33311 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdIKM0M (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Sep 2017 08:26:12 -0400
Received: by mail-io0-f181.google.com with SMTP id y123so24877446iod.0
        for <linux-input@vger.kernel.org>; Mon, 11 Sep 2017 05:26:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Cameron Gutman <aicommander@gmail.com>, Benjamin Valentin <benpicco@googlemail.com>, Pavel Rojtberg <rojtberg@gmail.com>, Daniel Tobias <dan.g.tob@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>

Hi!

I've got the following crashes while fuzzing the kernel with syzkaller.

On commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432 (Sep 3).

usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 2574 at drivers/usb/core/urb.c:449
usb_submit_urb+0xf8a/0x11d0
Modules linked in:
CPU: 1 PID: 2574 Comm: kworker/1:2 Not tainted 4.13.0+ #88
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
task: ffff880067ec9a00 task.stack: ffff880067988000
RIP: 0010:usb_submit_urb+0xf8a/0x11d0 drivers/usb/core/urb.c:448
RSP: 0018:ffff88006798e0b0 EFLAGS: 00010082
RAX: 0000000000000029 RBX: ffff88006b9ca200 RCX: 0000000000000000
RDX: 0000000000000029 RSI: ffff88006c915c78 RDI: ffffed000cf31c08
RBP: ffff88006798e1b0 R08: fffffbfff0fe00ff R09: fffffbfff0fe00ff
R10: 0000000000000001 R11: fffffbfff0fe00fe R12: 1ffff1000cf31c1d
R13: 0000000000000003 R14: 0000000000000001 R15: ffff88006b164798
FS:  0000000000000000(0000) GS:ffff88006c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fde04686518 CR3: 000000006a539000 CR4: 00000000000006e0
Call Trace:
 xpad_try_sending_next_out_packet+0xe1/0x1d0 drivers/input/joystick/xpad.c:1000
 xpad_send_led_command drivers/input/joystick/xpad.c:1372
 xpad_led_set+0x465/0x6e0 drivers/input/joystick/xpad.c:1392
 __led_set_brightness drivers/leds/led-core.c:34
 led_set_brightness_nopm+0x53/0x100 drivers/leds/led-core.c:261
 led_set_brightness_nosleep+0x17f/0x220 drivers/leds/led-core.c:278
 led_set_brightness+0xfe/0x130 drivers/leds/led-core.c:253
 xpad_identify_controller drivers/input/joystick/xpad.c:1383
 xpad_led_probe drivers/input/joystick/xpad.c:1426
 xpad_init_input+0xd40/0xfe0 drivers/input/joystick/xpad.c:1667
 xpad_probe+0x13d4/0x1e00 drivers/input/joystick/xpad.c:1811
 usb_probe_interface+0x351/0x8d0 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:385
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
 bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
 __device_attach+0x269/0x3c0 drivers/base/dd.c:682
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
 bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
 device_add+0xcf9/0x1640 drivers/base/core.c:1703
 usb_set_configuration+0x1064/0x1890 drivers/usb/core/message.c:1932
 generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
 usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:385
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
 bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
 __device_attach+0x269/0x3c0 drivers/base/dd.c:682
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
 bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
 device_add+0xcf9/0x1640 drivers/base/core.c:1703
 usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
 hub_port_connect drivers/usb/core/hub.c:4890
 hub_port_connect_change drivers/usb/core/hub.c:4996
 port_event drivers/usb/core/hub.c:5102
 hub_event+0x23c8/0x37c0 drivers/usb/core/hub.c:5182
 process_one_work+0x9fb/0x1570 kernel/workqueue.c:2097
 worker_thread+0x1e4/0x1350 kernel/workqueue.c:2231
 kthread+0x324/0x3f0 kernel/kthread.c:231
 ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:425
Code: 48 8b 85 30 ff ff ff 48 8d b8 98 00 00 00 e8 8e 93 07 ff 45 89
e8 44 89 f1 4c 89 fa 48 89 c6 48 c7 c7 a0 e5 55 86 e8 20 08 8f fd <0f>
ff e9 9b f7 ff ff e8 4a 04 d6 fd e9 80 f7 ff ff e8 60 11 a6
---[ end trace 5b20fc700a17a457 ]---
usb 1-1: BOGUS urb xfer, pipe 1 != type 3



usb 2-1: BOGUS urb xfer, pipe 1 != type 3
------------[ cut here ]------------
WARNING: CPU: 3 PID: 7797 at drivers/usb/core/urb.c:449
usb_submit_urb+0xf8a/0x11d0 drivers/usb/core/urb.c:448
Kernel panic - not syncing: panic_on_warn set ...

CPU: 3 PID: 7797 Comm: syz-executor0 Not tainted 4.13.0+ #86
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x192/0x22c lib/dump_stack.c:52
 panic+0x1cb/0x3b2 kernel/panic.c:180
 __warn+0x1c9/0x1de kernel/panic.c:541
 report_bug+0x211/0x2d0 lib/bug.c:183
 fixup_bug+0x45/0x90 arch/x86/kernel/traps.c:190
 do_trap_no_signal arch/x86/kernel/traps.c:224 [inline]
 do_trap+0x265/0x390 arch/x86/kernel/traps.c:273
 do_error_trap+0x149/0x3e0 arch/x86/kernel/traps.c:310
 do_invalid_op+0x20/0x30 arch/x86/kernel/traps.c:323
 invalid_op+0x1e/0x30 arch/x86/entry/entry_64.S:846
RIP: 0010:usb_submit_urb+0xf8a/0x11d0 drivers/usb/core/urb.c:448
RSP: 0018:ffff88006ab26150 EFLAGS: 00010282
RAX: 0000000000000029 RBX: ffff88003c586400 RCX: 0000000000000000
RDX: 0000000000000029 RSI: ffffffff812b6153 RDI: ffffed000d564c1c
RBP: ffff88006ab26250 R08: fffffbfff0fe00ff R09: fffffbfff0fe00ff
R10: ffff88006a311e80 R11: fffffbfff0fe00fe R12: 1ffff1000d564c31
R13: 0000000000000003 R14: 0000000000000001 R15: ffff88006c9bfa38
 xpad_start_input+0x43/0x100 drivers/input/joystick/xpad.c:1457
 xpad_open+0x3c/0x50 drivers/input/joystick/xpad.c:1542
 input_open_device+0x17a/0x250 drivers/input/input.c:603
 evbug_connect+0x10f/0x260 drivers/input/evbug.c:65
 input_attach_handler+0x59a/0x740 drivers/input/input.c:1002
 input_register_device+0xcb8/0xf90 drivers/input/input.c:2159
 xpad_init_input+0xaad/0xfe0 drivers/input/joystick/xpad.c:1671
 xpad_probe+0x13d4/0x1e00 drivers/input/joystick/xpad.c:1811
 usb_probe_interface+0x351/0x8d0 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:385 [inline]
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
 bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
 __device_attach+0x269/0x3c0 drivers/base/dd.c:682
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
 bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
 device_add+0xcf9/0x1640 drivers/base/core.c:1703
 usb_set_configuration+0x1064/0x1890 drivers/usb/core/message.c:1932
 generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
 usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:385 [inline]
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
 bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
 __device_attach+0x269/0x3c0 drivers/base/dd.c:682
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
 bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
 device_add+0xcf9/0x1640 drivers/base/core.c:1703
 usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
 hub_port_connect drivers/usb/core/hub.c:4890 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:4996 [inline]
 port_event drivers/usb/core/hub.c:5102 [inline]

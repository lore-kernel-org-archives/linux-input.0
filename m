From: Hans de Goede <hdegoede@redhat.com>
Subject: [BUG] hid NULL ptr deref on usb reset with hid disabled quirk
Date: Wed, 07 Apr 2010 11:07:29 +0200
Message-ID: <4BBC4B51.8060005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489Ab0DGJGB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Apr 2010 05:06:01 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o37960j8016542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-input@vger.kernel.org>; Wed, 7 Apr 2010 05:06:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb <linux-input@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>

Hi,

I've this buggy device which reports a HID interface, which should not
be touched or the device crashes, it tries to hide this interface by lying
about the number of interfaces descriptors it has, which works for windows
but not for Linux, see:
http://marc.info/?l=linux-usb&m=126985692106903

This same device also has a usb mass storage interface, which is the bit
one actually wants to talk to. I tried to get this device to work
without my patch from above, by adding:
usbhid.quirks=0x1908:0x1315:0x4

To the kernel cmdline. But this results in triggering a bug in the hid
driver. When a device has the ignore quirk (which the above command sets)
and a usb device reset gets done (which gets done by some error handling
code in the usb storage driver), this results in a NULL ptr deref:

usb 2-3: reset full speed USB device using ohci_hcd and address 3
BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
IP: [<ffffffff812ed4b6>] dev_get_drvdata+0xe/0x24
PGD 1184cb067 PUD 1147de067 PMD 0
Oops: 0000 [#1] SMP
last sysfs file: /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
CPU 1
Pid: 2117, comm: usb-storage Not tainted 2.6.33.1-26.fc13.x86_64 #1 M2N-SLI DELUXE/System Product Name
RIP: 0010:[<ffffffff812ed4b6>]  [<ffffffff812ed4b6>] dev_get_drvdata+0xe/0x24
RSP: 0018:ffff8801021a3c20  EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801002c8000 RCX: ffff880100000000
RDX: ffff8801021a3c20 RSI: ffff8801002ca8a8 RDI: 0000000000000030
RBP: ffff8801021a3c20 R08: 0000000000000282 R09: 0000000000000046
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88010a994090
R13: ffff8800287ad168 R14: ffff88011900d5a0 R15: ffff8800287ad1f8
FS:  00007fea02b0b700(0000) GS:ffff880006800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000038 CR3: 00000001132ef000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process usb-storage (pid: 2117, threadinfo ffff8801021a2000, task ffff8800291dc920)
Stack:
  ffff8801021a3c40 ffffffff813b64fe ffff8800287ad168 ffff8801002c8000
<0> ffff8801021a3cb0 ffffffff813b6614 0000000000000000 0000000300000000
<0> 0800000000001388 0201000013151908 ffff8801021a0100 ffff8801002ca890
Call Trace:
  [<ffffffff813b64fe>] usbhid_restart_queues+0x74/0xca
  [<ffffffff813b6614>] hid_post_reset+0xc0/0xd1
  [<ffffffff8134472f>] usb_reset_device+0x103/0x17b
  [<ffffffffa03e1bda>] usb_stor_port_reset+0x42/0x62 [usb_storage]
  [<ffffffffa03e22f0>] usb_stor_invoke_transport+0x305/0x379 [usb_storage]
  [<ffffffff81071226>] ? sched_clock_cpu+0xc3/0xce
  [<ffffffff8107cd0a>] ? mark_lock+0x2d/0x235
  [<ffffffff8107cf64>] ? mark_held_locks+0x52/0x70
  [<ffffffff814793ce>] ? _raw_spin_unlock_irq+0x30/0x3c
  [<ffffffffa03e1b08>] usb_stor_transparent_scsi_command+0xe/0x10 [usb_storage]
  [<ffffffffa03e3d1b>] usb_stor_control_thread+0x163/0x228 [usb_storage]
  [<ffffffffa03e3bb8>] ? usb_stor_control_thread+0x0/0x228 [usb_storage]
  [<ffffffff8106b5c4>] kthread+0x9a/0xa2
  [<ffffffff8107d1e4>] ? trace_hardirqs_on_caller+0x111/0x135
  [<ffffffff8100aae4>] kernel_thread_helper+0x4/0x10
  [<ffffffff81479710>] ? restore_args+0x0/0x30
  [<ffffffff8106b52a>] ? kthread+0x0/0xa2
  [<ffffffff8100aae0>] ? kernel_thread_helper+0x0/0x10
Code: ff ff e9 70 ff ff ff 48 8b 33 48 c7 c7 34 7b 7c 81 31 c0 e8 e9 8c 18 00 eb ce 90 90 90 55 48 89 e5 0f 1f 44 00 00 48 85 ff 74 12 <48> 8b 47 08 48 85 c0 74 09 48 8b 80 c0 00 00 00 eb 02 31 c0 c9
RIP  [<ffffffff812ed4b6>] dev_get_drvdata+0xe/0x24
  RSP <ffff8801021a3c20>
CR2: 0000000000000038
---[ end trace ec0e9d7f1dee82ed ]---

I would be happy to test any patches fixing this.

Regards,

Hans

p.s.

Please keep me in the CC, I'm not subscribed to the list.

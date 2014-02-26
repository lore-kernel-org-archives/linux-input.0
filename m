From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao
	<fernando_b1@lab.ntt.co.jp>
Subject: [PATCH] hid: fix bug destroying hidraw device files after parent
Date: Wed, 26 Feb 2014 16:51:24 +0900
Message-ID: <1393401084.4876.2.camel@nexus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:55890 "EHLO
	tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaBZH5v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Feb 2014 02:57:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>

I noticed that after hot unplugging a Logitech unifying receiver
(drivers/hid/hid-logitech-dj.c) the kernel would occasionally spew a
stack trace similar to this:

usb 1-1.1.2: USB disconnect, device number 7
WARNING: CPU: 0 PID: 2865 at fs/sysfs/group.c:216 device_del+0x40/0x1b0()
sysfs group ffffffff8187fa20 not found for kobject 'hidraw0'
[...]
CPU: 0 PID: 2865 Comm: upowerd Tainted: G        W 3.14.0-rc4 #7
Hardware name: LENOVO 7783PN4/        , BIOS 9HKT43AUS 07/11/2011
 0000000000000009 ffffffff814cd684 ffff880427ccfdf8 ffffffff810616e7
 ffff88041ec61800 ffff880427ccfe48 ffff88041e444d80 ffff880426fab8e8
 ffff880429359960 ffffffff8106174c ffffffff81714b98 0000000000000028
Call Trace:
 [<ffffffff814cd684>] ? dump_stack+0x41/0x51
 [<ffffffff810616e7>] ? warn_slowpath_common+0x77/0x90
 [<ffffffff8106174c>] ? warn_slowpath_fmt+0x4c/0x50
 [<ffffffff81374fd0>] ? device_del+0x40/0x1b0
 [<ffffffff8137516f>] ? device_unregister+0x2f/0x50
 [<ffffffff813751fa>] ? device_destroy+0x3a/0x40
 [<ffffffffa03ca245>] ? drop_ref+0x55/0x120 [hid]
 [<ffffffffa03ca3e6>] ? hidraw_release+0x96/0xb0 [hid]
 [<ffffffff811929da>] ? __fput+0xca/0x210
 [<ffffffff8107fe17>] ? task_work_run+0x97/0xd0
 [<ffffffff810139a9>] ? do_notify_resume+0x69/0xa0
 [<ffffffff814dbd22>] ? int_signal+0x12/0x17
---[ end trace 63f4a46f6566d737 ]---

During device removal hid_disconnect() is called via hid_hw_stop() to
stop the device and free all its resources, including the sysfs
files. The problem is that if a user space process, such as upowerd,
holds a reference to a hidraw file the corresponding sysfs files will
be kept around (drop_ref() does not call device_destroy() if the open
counter is not 0) and it will be usb_disconnect() who, by calling
device_del() for the USB device, will indirectly remove the sysfs
files of the hidraw device (sysfs_remove_dir() is recursive these
days). Because of this, by the time user space releases the last
reference to the hidraw file and drop_ref() tries to destroy the
device the sysfs files are already gone and the kernel will print
the warning above.

Fix this by calling device_destroy() at USB disconnect time.

Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>
Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-3.14-rc4-orig/drivers/hid/hidraw.c linux-3.14-rc4/drivers/hid/hidraw.c
--- linux-3.14-rc4-orig/drivers/hid/hidraw.c	2014-02-26 14:21:48.622980475 +0900
+++ linux-3.14-rc4/drivers/hid/hidraw.c	2014-02-26 14:22:17.990979556 +0900
@@ -320,13 +320,13 @@ static void drop_ref(struct hidraw *hidr
 			hid_hw_close(hidraw->hid);
 			wake_up_interruptible(&hidraw->wait);
 		}
+		device_destroy(hidraw_class,
+			       MKDEV(hidraw_major, hidraw->minor));
 	} else {
 		--hidraw->open;
 	}
 	if (!hidraw->open) {
 		if (!hidraw->exist) {
-			device_destroy(hidraw_class,
-					MKDEV(hidraw_major, hidraw->minor));
 			hidraw_table[hidraw->minor] = NULL;
 			kfree(hidraw);
 		} else {



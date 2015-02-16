From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 1/5] HID: sony: Fix a WARNING shown when rmmod-ing the driver
Date: Mon, 16 Feb 2015 22:58:24 +0100
Message-ID: <1424123904-5498-1-git-send-email-ao2@ao2.it>
References: <1424106744-12872-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:55404 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbbBPV6m (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 16:58:42 -0500
In-Reply-To: <1424106744-12872-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

ida_destroy() must be called _after_ all the devices have been
unregistered; otherwise, when calling "rmmod hid_sony" with devices
still plugged in, the following warning would show up because of calls
to ida_simple_remove() on a destroyed ID allocator:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5509 at lib/idr.c:1052 ida_simple_remove+0x26/0x50()
ida_remove called for id=0 which is not allocated.
Modules linked in: ...
CPU: 0 PID: 5509 Comm: rmmod Not tainted 3.19.0-rc6-ao2 #35
Hardware name: System manufacturer System Product Name/M2N-MX SE, BIOS 0501    03/20/2008
 0000000000000000 ffffffff8176320d ffffffff815b3a88 ffff880036f7fdd8
 ffffffff8106ce01 0000000000000000 ffffffffa07658e0 0000000000000246
 ffff88005077d8b8 ffff88005077d8d0 ffffffff8106ce7a ffffffff81763260
Call Trace:
 [<ffffffff815b3a88>] ? dump_stack+0x40/0x50
 [<ffffffff8106ce01>] ? warn_slowpath_common+0x81/0xb0
 [<ffffffff8106ce7a>] ? warn_slowpath_fmt+0x4a/0x50
 [<ffffffff812ccb86>] ? ida_simple_remove+0x26/0x50
 [<ffffffffa0762dc8>] ? sony_remove+0x58/0xe0 [hid_sony]
 [<ffffffffa00fff15>] ? hid_device_remove+0x65/0xd0 [hid]
 [<ffffffff8140425e>] ? __device_release_driver+0x7e/0x100
 [<ffffffff81404c70>] ? driver_detach+0xa0/0xb0
 [<ffffffff81403ee5>] ? bus_remove_driver+0x55/0xe0
 [<ffffffffa01000ff>] ? hid_unregister_driver+0x2f/0xa0 [hid]
 [<ffffffff810e45bf>] ? SyS_delete_module+0x1bf/0x270
 [<ffffffff81014089>] ? do_notify_resume+0x69/0xa0
 [<ffffffff815b952d>] ? system_call_fastpath+0x16/0x1b
---[ end trace bc794b3d22c30ede ]---

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f3d44e5..137d1ee 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2167,8 +2167,8 @@ static void __exit sony_exit(void)
 {
 	dbg_hid("Sony:%s\n", __func__);
 
-	ida_destroy(&sony_device_id_allocator);
 	hid_unregister_driver(&sony_driver);
+	ida_destroy(&sony_device_id_allocator);
 }
 module_init(sony_init);
 module_exit(sony_exit);
-- 
2.1.4


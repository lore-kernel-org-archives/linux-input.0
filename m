From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1 v2] input: usbhid: fix improper return value
Date: Mon,  5 Dec 2016 19:37:24 +0800
Message-ID: <1480937844-21513-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: linux-input@vger.kernel.org

Function hid_post_reset() should return negative error codes on
failures. However, in its implementation, it incorrectly returns 1.
This patch fixes the bug, returning proper error codes on failures.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/hid/usbhid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ae83af6..333108e 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1459,7 +1459,7 @@ static int hid_post_reset(struct usb_interface *intf)
 	rdesc = kmalloc(hid->dev_rsize, GFP_KERNEL);
 	if (!rdesc) {
 		dbg_hid("couldn't allocate rdesc memory (post_reset)\n");
-		return 1;
+		return -ENOMEM;
 	}
 	status = hid_get_class_descriptor(dev,
 				interface->desc.bInterfaceNumber,
@@ -1467,13 +1467,13 @@ static int hid_post_reset(struct usb_interface *intf)
 	if (status < 0) {
 		dbg_hid("reading report descriptor failed (post_reset)\n");
 		kfree(rdesc);
-		return 1;
+		return status;
 	}
 	status = memcmp(rdesc, hid->dev_rdesc, hid->dev_rsize);
 	kfree(rdesc);
 	if (status != 0) {
 		dbg_hid("report descriptor changed\n");
-		return 1;
+		return -EPERM;
 	}
 
 	/* No need to do another reset or clear a halted endpoint */
-- 
1.9.1

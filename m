From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] HID: hiddev: fix returned errno code in hiddev_connect()
Date: Wed, 30 Sep 2015 10:52:29 +0100
Message-ID: <1443606749-6028-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jikos@kernel.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Luis de Bethencourt <luisbg@osg.samsung.com>
List-Id: linux-input@vger.kernel.org

The driver is using -1 instead of the -ENOMEM defined macro to specify
that a buffer allocation failed. Since the error number is propagated,
the caller will get a -EPERM which is the wrong error condition.

Also, the smatch tool complains with the following warning:
hiddev_connect() warn: returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/hid/usbhid/hiddev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 2f1ddca..c5290ff 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -894,7 +894,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 	}
 
 	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
-		return -1;
+		return -ENOMEM;
 
 	init_waitqueue_head(&hiddev->wait);
 	INIT_LIST_HEAD(&hiddev->list);
-- 
2.5.1

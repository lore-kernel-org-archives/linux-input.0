From: Vasiliy Kulikov <segoon@openwall.com>
Subject: [PATCH] hid: hid-roccat-koneplus: potential NULL dereference
Date: Mon, 17 Jan 2011 13:08:45 +0300
Message-ID: <1295258925-31288-1-git-send-email-segoon@openwall.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

kmalloc() may fail, if so return -ENOMEM.
Also koneplus_init_koneplus_device_struct() should check return code
of koneplus_get_startup_profile() and propagate its return code.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Compile tested only.

 drivers/hid/hid-roccat-koneplus.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 1608c8d..591a97c 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -220,6 +220,8 @@ static int koneplus_get_startup_profile(struct usb_device *usb_dev)
 	int retval;
 
 	buf = kmalloc(sizeof(struct koneplus_startup_profile), GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
 
 	retval = koneplus_receive(usb_dev, KONEPLUS_USB_COMMAND_STARTUP_PROFILE,
 			buf, sizeof(struct koneplus_startup_profile));
@@ -614,6 +616,8 @@ static int koneplus_init_koneplus_device_struct(struct usb_device *usb_dev,
 	mutex_init(&koneplus->koneplus_lock);
 
 	koneplus->startup_profile = koneplus_get_startup_profile(usb_dev);
+	if (koneplus->startup_profile < 0)
+		return koneplus->startup_profile;
 
 	msleep(wait);
 	retval = koneplus_get_info(usb_dev, &koneplus->info);
-- 
1.7.0.4

From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 1/4] HID: roccat: Added support for KoneXTD
Date: Sun, 04 Nov 2012 09:38:52 +0100
Message-ID: <1352018332.2673.131.camel@neuromancer.tessier-ashpool>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

KoneXTD is just a Kone[+] with updated sensor, so it's handled by
koneplus driver.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-ids.h             |    1 +
 drivers/hid/hid-roccat-koneplus.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index aea84f3..32c03d1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -677,6 +677,7 @@
 #define USB_DEVICE_ID_ROCCAT_ISKU	0x319c
 #define USB_DEVICE_ID_ROCCAT_KONE	0x2ced
 #define USB_DEVICE_ID_ROCCAT_KONEPLUS	0x2d51
+#define USB_DEVICE_ID_ROCCAT_KONEXTD	0x2e22
 #define USB_DEVICE_ID_ROCCAT_KOVAPLUS	0x2d50
 #define USB_DEVICE_ID_ROCCAT_LUA	0x2c2e
 #define USB_DEVICE_ID_ROCCAT_PYRA_WIRED	0x2c24
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index c47540a..0df4083 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -14,6 +14,7 @@
 /*
  * Roccat Kone[+] is an updated/improved version of the Kone with more memory
  * and functionality and without the non-standard behaviours the Kone had.
+ * KoneXTD has same capabilities but updated sensor.
  */
 
 #include <linux/device.h>
@@ -718,6 +719,7 @@ static int koneplus_raw_event(struct hid_device *hdev,
 
 static const struct hid_device_id koneplus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_KONEPLUS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_KONEXTD) },
 	{ }
 };
 
@@ -758,5 +760,5 @@ module_init(koneplus_init);
 module_exit(koneplus_exit);
 
 MODULE_AUTHOR("Stefan Achatz");
-MODULE_DESCRIPTION("USB Roccat Kone[+] driver");
+MODULE_DESCRIPTION("USB Roccat Kone[+]/XTD driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.3.4

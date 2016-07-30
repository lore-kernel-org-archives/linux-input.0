From: Mayeul Cantan <mayeul.cantan@gmail.com>
Subject: [PATCH] input/hid: Add a new Saitek mouse device ID (RAT 9)
Date: Sat, 30 Jul 2016 13:53:39 +0200
Message-ID: <20160730115339.16542-1-mayeul@localhost.localdomain>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mayeul Cantan <mayeul.cantan@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Mayeul Cantan <mayeul.cantan@gmail.com>

The new device has 06a3:0cfa as identifiers, and the same quirks as the
other RAT models. It needs this fix in order not to confuse the xorg server
with its tristate button, which is reported as three different buttons, one
of which is always on.
This commit also fixes a small trailing whitespace issue in hid/hid-core.c

Signed-off-by: Mayeul Cantan <mayeul.cantan@gmail.com>
---
This patch is quite trivial, I am using it as a mean to try the submission process.
As such, please don't hesitate to make any comment on both the form and substance.
Best regards,
MC 

 drivers/hid/hid-core.c   | 3 ++-
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-saitek.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ea3a26..f5b8fbf 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2030,6 +2030,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_OLD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT9) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9) },
@@ -2289,7 +2290,7 @@ __ATTRIBUTE_GROUPS(hid_dev);
 
 static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct hid_device *hdev = to_hid_device(dev);	
+	struct hid_device *hdev = to_hid_device(dev);
 
 	if (add_uevent_var(env, "HID_ID=%04X:%08X:%08X",
 			hdev->bus, hdev->vendor, hdev->product))
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3eec09a1..6db4079 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -849,6 +849,7 @@
 #define USB_DEVICE_ID_SAITEK_PS1000	0x0621
 #define USB_DEVICE_ID_SAITEK_RAT7_OLD	0x0ccb
 #define USB_DEVICE_ID_SAITEK_RAT7	0x0cd7
+#define USB_DEVICE_ID_SAITEK_RAT9	0x0cfa
 #define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0
 
 #define USB_VENDOR_ID_SAMSUNG		0x0419
diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index 2f84b26..39e6426 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -183,6 +183,8 @@ static const struct hid_device_id saitek_devices[] = {
 		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),
 		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT9),
+		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9),
 		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7),
-- 
2.9.0

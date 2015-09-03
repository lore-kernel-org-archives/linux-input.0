From: Harald Brinkmann <hbrinkmann@braincalibration.de>
Subject: [PATCH] HID: mode button quirk for Mad Catz R.A.T.5
Date: Thu, 3 Sep 2015 17:49:26 +0200
Message-ID: <55E86C06.4000203@braincalibration.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi all,

this patch applies to Linux 4.2.0.

It enables the Saitek HID quirk for the mode button
of the Mad Catz R.A.T.5 gaming mouse.

Signed-off-by: Harald Brinkmann <hbrinkmann@braincalibration.de>
---
 drivers/hid/Kconfig      |    5 ++---
 drivers/hid/hid-core.c   |    1 +
 drivers/hid/hid-ids.h    |    1 +
 drivers/hid/hid-saitek.c |    2 ++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6ab51ae..434ffa5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -672,9 +672,8 @@ config HID_SAITEK
 
 	Supported devices:
 	- PS1000 Dual Analog Pad
-	- R.A.T.9 Gaming Mouse
-	- R.A.T.7 Gaming Mouse
-	- M.M.O.7 Gaming Mouse
+	- Saitek R.A.T.7, R.A.T.9, M.M.O.7 Gaming Mice
+	- Mad Catz R.A.T.5, R.A.T.9 Gaming Mice
 
 config HID_SAMSUNG
 	tristate "Samsung InfraRed remote control or keyboards"
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bcd914a..31fc642 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1981,6 +1981,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_OLD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f769208..99c13cd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -646,6 +646,7 @@
 
 #define USB_VENDOR_ID_MADCATZ		0x0738
 #define USB_DEVICE_ID_MADCATZ_BEATPAD	0x4540
+#define USB_DEVICE_ID_MADCATZ_RAT5	0x1705
 #define USB_DEVICE_ID_MADCATZ_RAT9	0x1709
 
 #define USB_VENDOR_ID_MCC		0x09db
diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index a014f21..2f84b26 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -177,6 +177,8 @@ static int saitek_event(struct hid_device *hdev, struct hid_field *field,
 static const struct hid_device_id saitek_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000),
 		.driver_data = SAITEK_FIX_PS1000 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5),
+		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_OLD),
 		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),

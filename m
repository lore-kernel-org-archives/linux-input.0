From: Alan Wu <alan.c.wu@gmail.com>
Subject: [PATCH 1/1] x86: Surface Pro 3 Type Cover 3
Date: Fri, 31 Oct 2014 08:48:40 -0700
Message-ID: <1414770520-4125-1-git-send-email-alan.c.wu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, alanwu <alan.c.wu@gmail.com>
List-Id: linux-input@vger.kernel.org

From: alanwu <alan.c.wu@gmail.com>

Surface Pro 3 Type Cover that works with Ubuntu (and possibly Arch) from this thread. Both trackpad and keyboard work after compiling my own kernel.
http://ubuntuforums.org/showthread.php?t=2231207&page=2&s=44910e0c56047e4f93dfd9fea58121ef

Signed-off-by: alanwu <alan.c.wu@gmail.com>
---
 drivers/hid/hid-ids.h       | 1 +
 drivers/hid/hid-microsoft.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e23ab8b..15f32c2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -648,6 +648,7 @@
 #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
+#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc

 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 8ba17a9..cacda43 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -274,6 +274,8 @@ static const struct hid_device_id ms_devices[] = {
		.driver_data = MS_NOGET },
	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
		.driver_data = MS_DUPLICATE_USAGES },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
+		.driver_data = MS_HIDINPUT },

	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
		.driver_data = MS_PRESENTER },
--
2.1.0

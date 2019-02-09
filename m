From: leakim.wikstrom@gmail.com
Subject: [PATCH] HID: multitouch: Lenovo X1 Tablet Gen3 trackpoint and buttons
Date: Sat,  9 Feb 2019 19:05:26 +0100
Message-ID: <20190209180526.7564-1-leakim.wikstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Mikael=20Wikstr=C3=B6m?= <leakim.wikstrom@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Mikael Wikström <leakim.wikstrom@gmail.com>

Add support for the trackpoint and three mouse buttons on the type cover
of the Lenovo X1 Tablet Gen3.

This is the same as with the 2nd generation Lenovo X1 Tablet.

Signed-off-by: Mikael Wikström <leakim.wikstrom@gmail.com>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f63489c882bb..500c8f64f7ae 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -703,6 +703,7 @@
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
+#define USB_DEVICE_ID_LENOVO_X1_TAB3	0x60b5
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f7c6de2b6730..03a69049ca52 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1780,6 +1780,12 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X1_TAB) },
 
+	/* Lenovo X1 TAB Gen 3 */
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			   USB_VENDOR_ID_LENOVO,
+			   USB_DEVICE_ID_LENOVO_X1_TAB3) },
+
 	/* Anton devices */
 	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
 		MT_USB_DEVICE(USB_VENDOR_ID_ANTON,
-- 
2.20.1

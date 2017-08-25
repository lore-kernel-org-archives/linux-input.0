From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH] HID: multitouch: support buttons and trackpoint on Lenovo X1 Tab Gen2
Date: Fri, 25 Aug 2017 18:06:04 -0400
Message-ID: <1503698764-172030-1-git-send-email-pasha.tatashin@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: aduggan@synaptics.com, jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On the 2nd generation Lenovo Tablet only clickpad is working; the
trackpoint and three mouse buttons do not work.

hid_multitouch must export all inputs in order to get trackpoint and
buttons to function.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c9ba4c6db74c..a93c724da5bc 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -658,6 +658,7 @@
 #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
+#define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index aff20f4b6d97..28c1c7214934 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1379,6 +1379,12 @@ static const struct hid_device_id mt_devices[] = {
 			USB_VENDOR_ID_ALPS_JP,
 			HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP) },
 
+	/* Lenovo X1 TAB Gen 2 */
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			   USB_VENDOR_ID_LENOVO,
+			   USB_DEVICE_ID_LENOVO_X1_TAB) },
+
 	/* Anton devices */
 	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
 		MT_USB_DEVICE(USB_VENDOR_ID_ANTON,
-- 
2.14.1

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/7] HID: logitech-hidpp: support the G700 over wireless
Date: Fri,  7 Sep 2018 12:34:49 +0200
Message-ID: <20180907103450.13890-7-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Simon Wood <simon@mungewell.org>, Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

The G700 is using a non unifying receiver, so it's easy to add its support
in hid-logitech-hidpp now.

With this, the 2 input nodes attached to the mouse will be enumerated
as "Logitech G700" and the battery power_supply will be exported (HID++
1.0 battery type).

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 537223086d6b..b366976e928c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -742,6 +742,7 @@
 #define USB_DEVICE_ID_MX3000_RECEIVER	0xc513
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER	0xc52b
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER		0xc52f
+#define USB_DEVICE_ID_LOGITECH_G700_RECEIVER		0xc531
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2	0xc532
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2		0xc534
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index a09509fdb746..0ab7f8b66b83 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3671,6 +3671,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Solar Keyboard Logitech K750 */
 	  LDJ_DEVICE(0x4002),
 	  .driver_data = HIDPP_QUIRK_CLASS_K750 },
+	{ /* G700 over Wireless */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER),
+	  .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },
 
 	{ LDJ_DEVICE(HID_ANY_ID) },
 
-- 
2.14.3

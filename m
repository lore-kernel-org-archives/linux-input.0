From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 16/17] HID: logitech-hidpp: report battery for the G700 over wireless
Date: Tue, 17 Jan 2017 15:35:46 +0100
Message-ID: <20170117143547.30488-17-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The receiver of the G700 is similar to a Unifying one, but not entirely.
It doesn't come with the DJ collections and thus can't be handled by
hid-logitech-dj.

To enable connection notifications, we need to instruct the receiver (0xff)
that we can handle those. And the actual device will be connected through
device index 0x01.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c           |  1 +
 drivers/hid/hid-ids.h            |  1 +
 drivers/hid/hid-logitech-hidpp.c | 82 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9905455..55123ea 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1967,6 +1967,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2) },
 #endif
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACETRAVELLER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 58c365f..195ba8a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -670,6 +670,7 @@
 #define USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500	0xc512
 #define USB_DEVICE_ID_MX3000_RECEIVER	0xc513
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER	0xc52b
+#define USB_DEVICE_ID_LOGITECH_G700_RECEIVER		0xc531
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2	0xc532
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
 #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2293898..99caec4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -132,6 +132,7 @@ struct hidpp_device {
 	bool answer_available;
 	u8 protocol_major;
 	u8 protocol_minor;
+	u8 device_index;
 
 	void *private_data;
 
@@ -187,11 +188,7 @@ static int __hidpp_send_report(struct hid_device *hdev,
 		return -ENODEV;
 	}
 
-	/*
-	 * set the device_index as the receiver, it will be overwritten by
-	 * hid_hw_request if needed
-	 */
-	hidpp_report->device_index = 0xff;
+	hidpp_report->device_index = hidpp->device_index;
 
 	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
 		ret = hid_hw_output_report(hdev, (u8 *)hidpp_report, fields_count);
@@ -422,6 +419,36 @@ static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
 					params, 3, &response);
 }
 
+/* Must be called with 0xff as device index */
+static int hidpp_unifying_enable_notifications(struct hidpp_device *hidpp_dev)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 params[3] = { 0 };
+
+	ret = hidpp_send_rap_command_sync(hidpp_dev,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_REGISTER,
+					HIDPP_REG_GENERAL,
+					NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	memcpy(params, response.rap.params, 3);
+
+	/* Set the wireless notification bit */
+	params[1] |= BIT(0);
+	params[1] |= BIT(3);
+
+	ret = hidpp_send_rap_command_sync(hidpp_dev,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_SET_REGISTER,
+					HIDPP_REG_GENERAL,
+					params, 3, &response);
+
+	return ret;
+}
+
 #define HIDPP_REG_BATTERY_STATUS			0x07
 
 static int hidpp10_battery_status_map_level(u8 param)
@@ -587,9 +614,32 @@ static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
 }
 
 #define HIDPP_REG_PAIRING_INFORMATION			0xB5
+#define HIDPP_PAIRING_INFORMATION			0x20
 #define HIDPP_EXTENDED_PAIRING				0x30
 #define HIDPP_DEVICE_NAME				0x40
 
+static u16 hidpp_unifying_get_quadid(struct hidpp_device *hidpp_dev, int *index)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 params[1] = { HIDPP_PAIRING_INFORMATION };
+	__be16 *quadid;
+
+	ret = hidpp_send_rap_command_sync(hidpp_dev,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_LONG_REGISTER,
+					HIDPP_REG_PAIRING_INFORMATION,
+					params, 1, &response);
+	if (ret)
+		return 0;
+
+	quadid = (__be16 *)&response.rap.params[3];
+	/* the device index goes from 1 to 6 */
+	*index = (response.rap.params[0] & 0x0F) + 1;
+
+	return be16_to_cpup(quadid);
+}
+
 static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev)
 {
 	struct hidpp_report response;
@@ -649,6 +699,12 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	struct hid_device *hdev = hidpp->hid_dev;
 	const char *name;
 	u32 serial;
+	u16 quadid;
+	int device_index;
+
+	quadid = hidpp_unifying_get_quadid(hidpp, &device_index);
+	if (quadid == 0)
+		return -EIO;
 
 	serial = hidpp_unifying_get_serial(hidpp);
 	if (serial == 0)
@@ -661,10 +717,13 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
 	dbg_hid("HID++ Unifying: Got name: %s\n", name);
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD", quadid, &serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
+	if (quadid != hdev->product)
+		hidpp_unifying_enable_notifications(hidpp);
+	hidpp->device_index = device_index;
+
 	kfree(name);
 	return 0;
 }
@@ -2880,6 +2939,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
 		hidpp->quirks |= HIDPP_QUIRK_UNIFYING;
 
+	/*
+	 * set the device_index as the receiver, it will be overwritten by
+	 * hid_hw_request if needed
+	 */
+	hidpp->device_index = 0xFF;
+
 	if (disable_raw_mode) {
 		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
 		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
@@ -3034,6 +3099,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x4002),
 	  .driver_data = HIDPP_QUIRK_CLASS_K750 },
+	{ /* G700 over Wireless */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER),
+	  .driver_data = HIDPP_QUIRK_UNIFYING },
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
-- 
2.9.3

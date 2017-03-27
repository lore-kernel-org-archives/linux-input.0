From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 06/19] HID: logitech-hidpp: rework probe path for unifying devices
Date: Mon, 27 Mar 2017 16:59:26 +0200
Message-ID: <20170327145939.29824-7-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Unifying devices are different from others because they can probed
while not connected. So we need to talk to the receiver to get some
extra information like the device name and the serial.

Instead of having conditionals while attempting to read the device name
from HID++ 2.0, have a special init path for them.

Store the retrieved serial in hdev->uniq.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- moved up in the series

changes in v2:
* only overwrite the name when the input is delayed (was causing different
  name depending of the connect stat of the device while probing)
---
 drivers/hid/hid-logitech-hidpp.c | 86 +++++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4ee466c..db15cfc 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -62,6 +62,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
+#define HIDPP_QUIRK_UNIFYING			BIT(25)
 
 #define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
 
@@ -394,14 +395,14 @@ static void hidpp_prefix_name(char **name, int name_length)
 #define HIDPP_GET_LONG_REGISTER				0x83
 
 #define HIDPP_REG_PAIRING_INFORMATION			0xB5
-#define DEVICE_NAME					0x40
+#define HIDPP_EXTENDED_PAIRING				0x30
+#define HIDPP_DEVICE_NAME				0x40
 
-static char *hidpp_get_unifying_name(struct hidpp_device *hidpp_dev)
+static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev)
 {
 	struct hidpp_report response;
 	int ret;
-	/* hid-logitech-dj is in charge of setting the right device index */
-	u8 params[1] = { DEVICE_NAME };
+	u8 params[1] = { HIDPP_DEVICE_NAME };
 	char *name;
 	int len;
 
@@ -430,6 +431,54 @@ static char *hidpp_get_unifying_name(struct hidpp_device *hidpp_dev)
 	return name;
 }
 
+static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, u32 *serial)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 params[1] = { HIDPP_EXTENDED_PAIRING };
+
+	ret = hidpp_send_rap_command_sync(hidpp,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_LONG_REGISTER,
+					HIDPP_REG_PAIRING_INFORMATION,
+					params, 1, &response);
+	if (ret)
+		return ret;
+
+	/*
+	 * We don't care about LE or BE, we will output it as a string
+	 * with %4phD, so we need to keep the order.
+	 */
+	*serial = *((u32 *)&response.rap.params[1]);
+	return 0;
+}
+
+static int hidpp_unifying_init(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	const char *name;
+	u32 serial;
+	int ret;
+
+	ret = hidpp_unifying_get_serial(hidpp, &serial);
+	if (ret)
+		return ret;
+
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
+		 hdev->product, &serial);
+	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
+
+	name = hidpp_unifying_get_name(hidpp);
+	if (!name)
+		return -EIO;
+
+	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
+	dbg_hid("HID++ Unifying: Got name: %s\n", name);
+
+	kfree(name);
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x0000: Root                                                               */
 /* -------------------------------------------------------------------------- */
@@ -2299,22 +2348,15 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
-static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
+static void hidpp_overwrite_name(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	char *name;
 
-	if (use_unifying)
-		/*
-		 * the device is connected through an Unifying receiver, and
-		 * might not be already connected.
-		 * Ask the receiver for its name.
-		 */
-		name = hidpp_get_unifying_name(hidpp);
-	else if (hidpp->protocol_major < 2)
+	if (hidpp->protocol_major < 2)
 		return;
-	else
-		name = hidpp_get_device_name(hidpp);
+
+	name = hidpp_get_device_name(hidpp);
 
 	if (!name) {
 		hid_err(hdev, "unable to retrieve the name of the device");
@@ -2456,6 +2498,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hidpp->quirks = id->driver_data;
 
+	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
+		hidpp->quirks |= HIDPP_QUIRK_UNIFYING;
+
 	if (disable_raw_mode) {
 		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
 		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
@@ -2507,8 +2552,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	/* Allow incoming packets */
 	hid_device_io_start(hdev);
 
+	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
+		hidpp_unifying_init(hidpp);
+
 	connected = hidpp_is_connected(hidpp);
-	if (id->group != HID_GROUP_LOGITECH_DJ_DEVICE) {
+	atomic_set(&hidpp->connected, connected);
+	if (!(hidpp->quirks & HIDPP_QUIRK_UNIFYING)) {
 		if (!connected) {
 			ret = -ENODEV;
 			hid_err(hdev, "Device not connected");
@@ -2517,10 +2566,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		hid_info(hdev, "HID++ %u.%u device connected.\n",
 			 hidpp->protocol_major, hidpp->protocol_minor);
-	}
 
-	hidpp_overwrite_name(hdev, id->group == HID_GROUP_LOGITECH_DJ_DEVICE);
-	atomic_set(&hidpp->connected, connected);
+		hidpp_overwrite_name(hdev);
+	}
 
 	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
 		ret = wtp_get_config(hidpp);
-- 
2.9.3

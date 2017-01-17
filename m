From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 15/17] HID: logitech-hidpp: rework probe path for unifying devices
Date: Tue, 17 Jan 2017 15:35:45 +0100
Message-ID: <20170117143547.30488-16-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
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
 drivers/hid/hid-logitech-hidpp.c | 81 +++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 17dd569..2293898 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -65,6 +65,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_HIDPP20_BATTERY		BIT(25)
 #define HIDPP_QUIRK_HIDPP10_BATTERY		BIT(26)
+#define HIDPP_QUIRK_UNIFYING			BIT(27)
 
 #define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
 
@@ -586,14 +587,14 @@ static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
 }
 
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
 
@@ -622,6 +623,52 @@ static char *hidpp_get_unifying_name(struct hidpp_device *hidpp_dev)
 	return name;
 }
 
+static u32 hidpp_unifying_get_serial(struct hidpp_device *hidpp)
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
+		return 0;
+
+	/*
+	 * We don't care about LE or BE, we will output it as a string
+	 * with %4phD, so we need to keep the order.
+	 */
+	return *((u32 *)&response.rap.params[1]);
+}
+
+static int hidpp_unifying_init(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	const char *name;
+	u32 serial;
+
+	serial = hidpp_unifying_get_serial(hidpp);
+	if (serial == 0)
+		return -EIO;
+
+	name = hidpp_unifying_get_name(hidpp);
+	if (!name)
+		return -EIO;
+
+	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
+	dbg_hid("HID++ Unifying: Got name: %s\n", name);
+
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
+		 hdev->product, &serial);
+	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
+
+	kfree(name);
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x0000: Root                                                               */
 /* -------------------------------------------------------------------------- */
@@ -2600,22 +2647,15 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	return ret;
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
@@ -2837,6 +2877,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hidpp->quirks = id->driver_data;
 
+	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
+		hidpp->quirks |= HIDPP_QUIRK_UNIFYING;
+
 	if (disable_raw_mode) {
 		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
 		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
@@ -2887,8 +2930,11 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	/* Allow incoming packets */
 	hid_device_io_start(hdev);
 
+	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
+		hidpp_unifying_init(hidpp);
+
 	connected = hidpp_is_connected(hidpp);
-	if (id->group != HID_GROUP_LOGITECH_DJ_DEVICE) {
+	if (!(hidpp->quirks & HIDPP_QUIRK_UNIFYING)) {
 		if (!connected) {
 			ret = -ENODEV;
 			hid_err(hdev, "Device not connected");
@@ -2899,7 +2945,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			 hidpp->protocol_major, hidpp->protocol_minor);
 	}
 
-	hidpp_overwrite_name(hdev, id->group == HID_GROUP_LOGITECH_DJ_DEVICE);
+	if (connected)
+		hidpp_overwrite_name(hdev);
 	atomic_set(&hidpp->connected, connected);
 
 	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
-- 
2.9.3

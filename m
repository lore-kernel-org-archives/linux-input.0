From: Todd Kelner <tsopdump@gmail.com>
Subject: [PATCH] HID: sony: Add touchpad support for Sony's NSG-MR5U and
 NSG-MR7U remotes
Date: Fri, 27 Jan 2017 19:42:58 -0700
Message-ID: <20170128024255.GA11707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36500 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdA1CoC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 21:44:02 -0500
Received: by mail-it0-f66.google.com with SMTP id o138so10124817ito.3
        for <linux-input@vger.kernel.org>; Fri, 27 Jan 2017 18:43:02 -0800 (PST)
Received: from gmail.com (S0106a84e3f6ddbc3.ek.shawcable.net. [24.66.128.37])
        by smtp.gmail.com with ESMTPSA id g78sm4342626ioi.41.2017.01.27.18.43.00
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2017 18:43:01 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Sony's NSG-MR5U and NSG-MR7U remote controls have a full keyboard and a
touchpad.  The keyboard is already supported by the existing Linux kernel
and drivers but the touchpad is not recognized.  This patch adds the code
needed to bring full functionality to the touchpad.

Note that these remotes use the vendor code for SMK even though they are
Sony branded.

Signed-off-by: Todd Kelner <tsopdump@gmail.com>
---
 drivers/hid/hid-core.c |   2 +
 drivers/hid/hid-ids.h  |   2 +
 drivers/hid/hid-sony.c | 124 +++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cff060b..4dfef41 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2054,6 +2054,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 54bd22d..864ec34 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -904,6 +904,8 @@
 
 #define USB_VENDOR_ID_SMK		0x0609
 #define USB_DEVICE_ID_SMK_PS3_BDREMOTE	0x0306
+#define USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE	0x0368
+#define USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE	0x0369
 
 #define USB_VENDOR_ID_SONY			0x054c
 #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE	0x024b
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f405b07..e6a8ef2 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -54,6 +54,8 @@
 #define NAVIGATION_CONTROLLER_BT  BIT(10)
 #define SINO_LITE_CONTROLLER      BIT(11)
 #define FUTUREMAX_DANCE_MAT       BIT(12)
+#define NSG_MR5U_REMOTE_BT        BIT(13)
+#define NSG_MR7U_REMOTE_BT        BIT(14)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -70,8 +72,11 @@
 				MOTION_CONTROLLER)
 #define SONY_BT_DEVICE (SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_BT |\
 			MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER_BT)
+#define NSG_MRXU_REMOTE (NSG_MR5U_REMOTE_BT | NSG_MR7U_REMOTE_BT)
 
 #define MAX_LEDS 4
+#define NSG_MRXU_MAX_X 1667
+#define NSG_MRXU_MAX_Y 1868
 
 /*
  * The Sixaxis reports both digital and analog values for each button on the
@@ -1063,7 +1068,7 @@ struct motion_output_report_02 {
 #define DS4_INPUT_REPORT_BATTERY_OFFSET  30
 #define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33
 
-#define DS4_TOUCHPAD_SUFFIX " Touchpad"
+#define TOUCHPAD_SUFFIX " Touchpad"
 
 static DEFINE_SPINLOCK(sony_dev_list_lock);
 static LIST_HEAD(sony_device_list);
@@ -1240,6 +1245,10 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 		hid_info(hdev, "Using modified Dualshock 4 Bluetooth report descriptor\n");
 		rdesc = dualshock4_bt_rdesc;
 		*rsize = sizeof(dualshock4_bt_rdesc);
+	} else if (sc->quirks & NSG_MRXU_REMOTE && *rsize == 359 &&
+			rdesc[358] == 0x00) {
+		hid_info(hdev, "Removing trailing 0x00 from NSG_MRxU report descriptor\n");
+		(*rsize)--;
 	}
 
 	if (sc->quirks & SIXAXIS_CONTROLLER)
@@ -1383,6 +1392,70 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	}
 }
 
+static void nsg_mrxu_parse_report(struct sony_sc *sc, u8 *rd, int size)
+{
+	int n, offset;
+	u8 active;
+
+	/*
+	 * The NSG-MRxU multi-touch trackpad data starts at offset 1 and
+	 *   the touch-related data starts at offset 2.
+	 * Bit 0 is set when touchpad button is pressed.
+	 * Bit 3 is set when a touch is active and the drag (Fn) key is pressed.
+	 * This drag key is mapped to BTN_LEFT.
+	 * Bit 4 is set when only the first touch point is active.
+	 * Bit 6 is set when only the second touch point is active.
+	 * Bits 5 and 7 are set when both touch points are active.
+	 * The next 3 bytes are two 12 bit X/Y coordinates for the first touch.
+	 * The bytes at offset 7-9 are the second touch X/Y coordinates.
+	 */
+	offset = 1;
+
+	input_report_key(sc->touchpad, BTN_LEFT, rd[offset] & 0x0F);
+	active = (rd[offset] >> 4);
+
+	offset++;
+
+	for (n = 0; n < 2; n++) {
+		u16 x, y;
+		u8 contactx, contacty;
+		unsigned int rel_axis;
+
+		x = rd[offset] | ((rd[offset+1] & 0x0F) << 8);
+		y = ((rd[offset+1] & 0xF0) >> 4) | (rd[offset+2] << 4);
+
+		input_mt_slot(sc->touchpad, n);
+		input_mt_report_slot_state(sc->touchpad, MT_TOOL_FINGER, active & 0x03);
+
+		if (active & 0x03) {
+			contactx = rd[offset+3] & 0x0F;
+			contacty = rd[offset+3] >> 4;
+			input_report_abs(sc->touchpad, ABS_MT_TOUCH_MAJOR,
+				max(contactx, contacty));
+			input_report_abs(sc->touchpad, ABS_MT_TOUCH_MINOR,
+				max(contactx, contacty));
+			input_report_abs(sc->touchpad, ABS_MT_ORIENTATION,
+				(bool) (contactx > contacty));
+			input_report_abs(sc->touchpad, ABS_MT_POSITION_X, x);
+			input_report_abs(sc->touchpad, ABS_MT_POSITION_Y,
+				NSG_MRXU_MAX_Y - y);
+			if (n == 0)
+				rel_axis = REL_X;
+			else
+				rel_axis = REL_Y;
+
+			input_report_rel(sc->touchpad, rel_axis, rd[offset+4]);
+		}
+
+		offset += 5;
+                active >>= 2;
+	}
+
+	input_mt_sync_frame(sc->touchpad);
+
+	input_sync(sc->touchpad);
+}
+
 static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		u8 *rd, int size)
 {
@@ -1459,6 +1532,10 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		}
 
 		dualshock4_parse_report(sc, rd, size);
+
+	} else if (sc->quirks & NSG_MRXU_REMOTE && rd[0] == 0x02) {
+		nsg_mrxu_parse_report(sc, rd, size);
+		return 1;
 	}
 
 	if (sc->defer_initialization) {
@@ -1529,30 +1606,37 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 	sc->touchpad->id.product = sc->hdev->product;
 	sc->touchpad->id.version = sc->hdev->version;
 
-	/* Append a suffix to the controller name as there are various
-	 * DS4 compatible non-Sony devices with different names.
-	 */
-	name_sz = strlen(sc->hdev->name) + sizeof(DS4_TOUCHPAD_SUFFIX);
+	/* Append a suffix to the controller name to make it more unique */
+	name_sz = strlen(sc->hdev->name) + sizeof(TOUCHPAD_SUFFIX);
 	name = kzalloc(name_sz, GFP_KERNEL);
 	if (!name) {
 		ret = -ENOMEM;
 		goto err;
 	}
-	snprintf(name, name_sz, "%s" DS4_TOUCHPAD_SUFFIX, sc->hdev->name);
+	snprintf(name, name_sz, "%s" TOUCHPAD_SUFFIX, sc->hdev->name);
 	sc->touchpad->name = name;
 
-	ret = input_mt_init_slots(sc->touchpad, touch_count, 0);
-	if (ret < 0)
-		goto err;
-
 	/* We map the button underneath the touchpad to BTN_LEFT. */
 	__set_bit(EV_KEY, sc->touchpad->evbit);
 	__set_bit(BTN_LEFT, sc->touchpad->keybit);
+	__clear_bit(BTN_MIDDLE, sc->touchpad->keybit);
+	__clear_bit(BTN_RIGHT, sc->touchpad->keybit);
 	__set_bit(INPUT_PROP_BUTTONPAD, sc->touchpad->propbit);
 
+	if (sc->quirks & NSG_MRXU_REMOTE) {
+		__set_bit(EV_REL, sc->touchpad->evbit);
+		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR, 0, 15, 0, 0);
+		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR, 0, 15, 0, 0);
+		input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION, 0, 1, 0, 0);
+	}
+
 	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_X, 0, w, 0, 0);
 	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);
 
+	ret = input_mt_init_slots(sc->touchpad, touch_count, INPUT_MT_POINTER);
+	if (ret < 0)
+		goto err;
+
 	ret = input_register_device(sc->touchpad);
 	if (ret < 0)
 		goto err;
@@ -2586,6 +2670,20 @@ static int sony_input_configured(struct hid_device *hdev,
 		}
 
 		sony_init_output_report(sc, dualshock4_send_output_report);
+	} else if (sc->quirks & NSG_MRXU_REMOTE) {
+		/*
+ 		 * The NSG-MRxU touchpad supports 2 touches and has a
+ 		 * resolution of 1667x1868
+ 		 */
+		ret = sony_register_touchpad(sc, 2,
+			NSG_MRXU_MAX_X, NSG_MRXU_MAX_Y);
+		if (ret) {
+			hid_err(sc->hdev,
+			"Unable to initialize multi-touch slots: %d\n",
+			ret);
+			goto err_stop;
+		}
+
 	} else if (sc->quirks & MOTION_CONTROLLER) {
 		sony_init_output_report(sc, motion_send_output_report);
 	} else {
@@ -2830,6 +2928,12 @@ static const struct hid_device_id sony_devices[] = {
 	/* Nyko Core Controller for PS3 */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROLLER },
+	/* SMK-Link NSG-MR5U Remote Control */
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE),
+		.driver_data = NSG_MR5U_REMOTE_BT },
+	/* SMK-Link NSG-MR7U Remote Control */
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE),
+		.driver_data = NSG_MR7U_REMOTE_BT },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
-- 
2.7.4


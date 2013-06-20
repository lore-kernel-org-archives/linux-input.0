From: Jason Flatt <jflatt@cox.net>
Subject: [PATCH] Support for Sony NSG-MR5U
Date: Wed, 19 Jun 2013 23:43:38 -0700
Message-ID: <1497744.kpqTRKsYBt@desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2470611.mTFXmZN5oo"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eastrmfepi202.cox.net ([68.230.241.206]:45055 "EHLO
	eastrmfepi202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab3FTGyg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jun 2013 02:54:36 -0400
Received: from eastrmimpo305 ([68.230.241.237]) by eastrmfepo201.cox.net
          (InterMail vM.8.01.05.09 201-2260-151-124-20120717) with ESMTP
          id <20130620064342.MLSJ3846.eastrmfepo201.cox.net@eastrmimpo305>
          for <linux-input@vger.kernel.org>;
          Thu, 20 Jun 2013 02:43:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2470611.mTFXmZN5oo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,
This is a patch for Sony's GoogleTV multitouch bluetooth remotes, it adds into 
the shared hid-sony module, and is based on the methods used in the apple 
magicmouse module.  It builds against the 3.9.0 git tree at:
git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
Please let me know how it looks, this is my first patch.
Thank you

--nextPart2470611.mTFXmZN5oo
Content-Disposition: attachment; filename="nsgmr5u.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="nsgmr5u.patch"

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 512b01c..a61d9dc 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1701,6 +1701,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE, USB_DEVICE_ID_SONY_TOUCH_REMOTE_LYRA) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE, USB_DEVICE_ID_SONY_TOUCH_REMOTE_LEO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 92e47e5..fd85e26 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -723,6 +723,10 @@
 #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
 
+#define USB_VENDOR_ID_SONY_TOUCH_REMOTE		0x0609
+#define USB_DEVICE_ID_SONY_TOUCH_REMOTE_LYRA	0x0368
+#define USB_DEVICE_ID_SONY_TOUCH_REMOTE_LEO	0x0369
+
 #define USB_VENDOR_ID_SOUNDGRAPH	0x15c2
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST	0x0034
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST	0x0046
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 7a1ebb8..53b3eb9 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1180,6 +1180,14 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
 			USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008) },
 
+	/* Sony CE Remote */
+	{ .driver_data = MT_CLS_DEFAULT,
+		MT_BT_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE,
+			USB_DEVICE_ID_SONY_TOUCH_REMOTE_LYRA) },
+	{ .driver_data = MT_CLS_DEFAULT,
+		MT_BT_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE,
+			USB_DEVICE_ID_SONY_TOUCH_REMOTE_LEO) },
+
 	/* Stantum panels */
 	{ .driver_data = MT_CLS_CONFIDENCE,
 		MT_USB_DEVICE(USB_VENDOR_ID_STANTUM,
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 312098e..44e81f8 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -6,6 +6,7 @@
  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
  *  Copyright (c) 2008 Jiri Slaby
  *  Copyright (c) 2006-2008 Jiri Kosina
+ *  Copyright (c) 2013 Jason Flatt <jflatt@cox.net>
  */
 
 /*
@@ -17,6 +18,7 @@
 
 #include <linux/device.h>
 #include <linux/hid.h>
+#include <linux/input/mt.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -26,6 +28,17 @@
 #define VAIO_RDESC_CONSTANT     (1 << 0)
 #define SIXAXIS_CONTROLLER_USB  (1 << 1)
 #define SIXAXIS_CONTROLLER_BT   (1 << 2)
+#define CE_REMOTE_BT            (1 << 4)
+
+/* measured on real hardware */
+#define CE_REMOTE_MIN_X 0
+#define CE_REMOTE_MAX_X 1667
+#define CE_REMOTE_SIZE_X (float)48 /* size in mm */
+#define CE_REMOTE_MIN_Y 0
+#define CE_REMOTE_MAX_Y 1868
+#define CE_REMOTE_SIZE_Y (float)51
+#define CE_REMOTE_RES_X ((CE_REMOTE_MAX_X - CE_REMOTE_MIN_X) / CE_REMOTE_SIZE_X)
+#define CE_REMOTE_RES_Y ((CE_REMOTE_MAX_Y - CE_REMOTE_MIN_Y) / CE_REMOTE_SIZE_Y)
 
 static const u8 sixaxis_rdesc_fixup[] = {
 	0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,
@@ -57,6 +70,7 @@ static const u8 sixaxis_rdesc_fixup2[] = {
 
 struct sony_sc {
 	unsigned long quirks;
+	struct input_dev *input;
 };
 
 /* Sony Vaio VGX has wrongly mouse pointer declared as constant */
@@ -94,10 +108,27 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			 *rsize, (int)sizeof(sixaxis_rdesc_fixup2));
 		*rsize = sizeof(sixaxis_rdesc_fixup2);
 		memcpy(rdesc, &sixaxis_rdesc_fixup2, *rsize);
+	} else if ((sc->quirks & CE_REMOTE_BT) && *rsize == 359 &&
+			rdesc[358] == 0x0) {
+		hid_info(hdev, "Fixing up Sony CE Remote report descriptor\n");
+		*rsize = 358;
 	}
 	return rdesc;
 }
 
+static int sony_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+	struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+	if (sc->quirks & CE_REMOTE_BT) {
+		if (!sc->input)
+			sc->input = hi->input;
+	}
+
+	return 0;
+}
+
 static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		__u8 *rd, int size)
 {
@@ -112,8 +143,55 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		swap(rd[43], rd[44]);
 		swap(rd[45], rd[46]);
 		swap(rd[47], rd[48]);
+	} else if (sc->quirks & CE_REMOTE_BT) {
+		struct input_dev *input = sc->input;
+		if (!input) {
+			hid_err(hdev, "Sony CE Remote no input data structure");
+			return 0;
+		}
+		if (rd[0] == 0x2) { /* report id = trackpad */
+			__u8 button0 = rd[1] & 0x1;
+			__u8 button2 = (rd[1] & 0x4) >> 2;
+			__u8 contact0 = (rd[1] & 0x30) >> 4;
+			__u8 contact1 = (rd[1] & 0xc0) >> 6;
+			__u16 touch0x = rd[2] | (rd[3] & 0xf) << 8;
+			__u16 touch0y = (rd[3] & 0xf0) >> 4 | rd[4] << 4;
+			__u8 touch0w = rd[5] & 0xf;
+			__u8 touch0h = (rd[5] & 0xf0) >> 4;
+			int8_t xrel = rd[6];
+			__u16 touch1x = rd[7] | (rd[8] & 0xf) << 8;
+			__u16 touch1y = (rd[8] & 0xf0) >> 4 | rd[9] << 4;
+			__u8 touch1w = rd[10] & 0xf;
+			__u8 touch1h = (rd[10] & 0xf0) >> 4;
+			int8_t yrel = rd[11];
+
+			input_mt_slot(input, 0);
+			input_mt_report_slot_state(input, MT_TOOL_FINGER, contact0);
+			/* flip Y-axis */
+			if (contact0) {
+				input_report_abs(input, ABS_MT_TOUCH_MAJOR, max(touch0w, touch0h));
+				input_report_abs(input, ABS_MT_TOUCH_MINOR, min(touch0w, touch0h));
+				input_report_abs(input, ABS_MT_ORIENTATION, (bool)(touch0w > touch0h));
+				input_report_abs(input, ABS_MT_POSITION_X, touch0x);
+				input_report_abs(input, ABS_MT_POSITION_Y, CE_REMOTE_MAX_Y - touch0y);
+			}
+			input_mt_slot(input, 1);
+			input_mt_report_slot_state(input, MT_TOOL_FINGER, contact1);
+			if (contact1) {
+				input_report_abs(input, ABS_MT_TOUCH_MAJOR, max(touch1w, touch1h));
+				input_report_abs(input, ABS_MT_TOUCH_MINOR, min(touch1w, touch1h));
+				input_report_abs(input, ABS_MT_ORIENTATION, (bool)(touch1w > touch1h));
+				input_report_abs(input, ABS_MT_POSITION_X, touch1x);
+				input_report_abs(input, ABS_MT_POSITION_Y, CE_REMOTE_MAX_Y - touch1y);
+			}
+			input_report_rel(input, REL_X, xrel);
+			input_report_rel(input, REL_Y, yrel);
+
+			input_report_key(input, BTN_MOUSE, button0 | button2);
+			input_mt_report_pointer_emulation(input, true);
+		}
+		input_sync(input);
 	}
-
 	return 0;
 }
 
@@ -192,6 +270,43 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
 	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
 }
 
+static int ce_remote_setup_input(struct input_dev *input, struct hid_device *hdev)
+{
+	const int FUZZ = 4;
+	int error;
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_REL, input->evbit);
+	__set_bit(EV_ABS, input->evbit);
+	__clear_bit(BTN_RIGHT, input->keybit);
+	__clear_bit(BTN_MIDDLE, input->keybit);
+	__set_bit(BTN_MOUSE, input->keybit);
+	__set_bit(BTN_TOOL_FINGER, input->keybit);
+	__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
+	__set_bit(BTN_TOUCH, input->keybit);
+	__set_bit(INPUT_PROP_POINTER, input->propbit);
+	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+
+	error = input_mt_init_slots(input, 2, 0);
+	if (error)
+		return error;
+
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 15, FUZZ, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 15, FUZZ, 0);
+	input_set_abs_params(input, ABS_MT_ORIENTATION, 0, 1, 0, 0);
+
+	input_set_abs_params(input, ABS_X, CE_REMOTE_MIN_X, CE_REMOTE_MAX_X, FUZZ, 0);
+	input_set_abs_params(input, ABS_Y, CE_REMOTE_MIN_Y, CE_REMOTE_MAX_Y, FUZZ, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_X, CE_REMOTE_MIN_X, CE_REMOTE_MAX_X, FUZZ, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, CE_REMOTE_MIN_Y, CE_REMOTE_MAX_Y, FUZZ, 0);
+
+	input_abs_set_res(input, ABS_X, CE_REMOTE_RES_X);
+	input_abs_set_res(input, ABS_Y, CE_REMOTE_RES_Y);
+	input_abs_set_res(input, ABS_MT_POSITION_X, CE_REMOTE_RES_X);
+	input_abs_set_res(input, ABS_MT_POSITION_Y, CE_REMOTE_RES_Y);
+
+	return 0;
+}
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -226,6 +341,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
+	else if (sc->quirks & CE_REMOTE_BT) {
+		if (sc->input) {
+			ret = ce_remote_setup_input(sc->input, hdev);
+			if (ret) {
+				hid_err(hdev, "Sony Touch Remote setup input failed (%d)\n", ret);
+				goto err_stop;
+			}
+		}
+	}
 	else
 		ret = 0;
 
@@ -257,6 +381,10 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = VAIO_RDESC_CONSTANT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE),
 		.driver_data = VAIO_RDESC_CONSTANT },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE, USB_DEVICE_ID_SONY_TOUCH_REMOTE_LYRA),
+		.driver_data = CE_REMOTE_BT },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY_TOUCH_REMOTE, USB_DEVICE_ID_SONY_TOUCH_REMOTE_LEO),
+		.driver_data = CE_REMOTE_BT },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
@@ -266,6 +394,7 @@ static struct hid_driver sony_driver = {
 	.id_table = sony_devices,
 	.probe = sony_probe,
 	.remove = sony_remove,
+	.input_mapping = sony_input_mapping,
 	.report_fixup = sony_report_fixup,
 	.raw_event = sony_raw_event
 };

--nextPart2470611.mTFXmZN5oo--


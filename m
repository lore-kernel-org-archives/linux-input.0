From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Sun,  5 May 2013 23:13:08 +0200
Message-ID: <1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:41045 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3EEVOX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:14:23 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1318646bkc.16
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:14:22 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

The Wii U Pro Controller is a new Nintendo remote device that looks very
similar to the XBox controller. It has nearly the same features and uses
the same protocol as the Wii Remote.

We add a new wiimote extension device so the Pro Controller is properly
detected and supported.

The device reports MP support, which is odd and I couldn't get it working,
yet. Hence, we disable MP registers for now. Further investigation is
needed to see what extra capabilities are provided.

There are some other unknown bits in the extension reports that I couldn't
figure out what they do. You can use hidraw to access these if you're
interested.

We might want to hook up the "charging" and "USB" bits to the battery
device so user-space can query whether it is currently charged via USB.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    |  23 +++
 drivers/hid/hid-wiimote-modules.c | 295 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   2 +
 3 files changed, 320 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 3e69656..279a07d 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -452,6 +452,8 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
 		return WIIMOTE_EXT_CLASSIC_CONTROLLER;
 	if (rmem[4] == 0x04 && rmem[5] == 0x02)
 		return WIIMOTE_EXT_BALANCE_BOARD;
+	if (rmem[4] == 0x01 && rmem[5] == 0x20)
+		return WIIMOTE_EXT_PRO_CONTROLLER;
 
 	return WIIMOTE_EXT_UNKNOWN;
 }
@@ -601,6 +603,15 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_NO_MP,
 		WIIMOD_NULL,
 	},
+	[WIIMOTE_DEV_PRO_CONTROLLER] = (const __u8[]) {
+		WIIMOD_BATTERY,
+		WIIMOD_LED1,
+		WIIMOD_LED2,
+		WIIMOD_LED3,
+		WIIMOD_LED4,
+		WIIMOD_NO_MP,
+		WIIMOD_NULL,
+	},
 };
 
 static void wiimote_modules_load(struct wiimote_data *wdata,
@@ -785,6 +796,7 @@ static const char *wiimote_devtype_names[WIIMOTE_DEV_NUM] = {
 	[WIIMOTE_DEV_GEN10] = "Nintendo Wii Remote (Gen 1)",
 	[WIIMOTE_DEV_GEN20] = "Nintendo Wii Remote Plus (Gen 2)",
 	[WIIMOTE_DEV_BALANCE_BOARD] = "Nintendo Wii Balance Board",
+	[WIIMOTE_DEV_PRO_CONTROLLER] = "Nintendo Wii U Pro Controller",
 };
 
 /* Try to guess the device type based on all collected information. We
@@ -805,6 +817,9 @@ static void wiimote_init_set_type(struct wiimote_data *wdata,
 	if (exttype == WIIMOTE_EXT_BALANCE_BOARD) {
 		devtype = WIIMOTE_DEV_BALANCE_BOARD;
 		goto done;
+	} else if (exttype == WIIMOTE_EXT_PRO_CONTROLLER) {
+		devtype = WIIMOTE_DEV_PRO_CONTROLLER;
+		goto done;
 	}
 
 	if (!strcmp(name, "Nintendo RVL-CNT-01")) {
@@ -816,6 +831,9 @@ static void wiimote_init_set_type(struct wiimote_data *wdata,
 	} else if (!strcmp(name, "Nintendo RVL-WBC-01")) {
 		devtype = WIIMOTE_DEV_BALANCE_BOARD;
 		goto done;
+	} else if (!strcmp(name, "Nintendo RVL-CNT-01-UC")) {
+		devtype = WIIMOTE_DEV_PRO_CONTROLLER;
+		goto done;
 	}
 
 	if (vendor == USB_VENDOR_ID_NINTENDO) {
@@ -1058,6 +1076,7 @@ static const char *wiimote_exttype_names[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_NUNCHUK] = "Nintendo Wii Nunchuk",
 	[WIIMOTE_EXT_CLASSIC_CONTROLLER] = "Nintendo Wii Classic Controller",
 	[WIIMOTE_EXT_BALANCE_BOARD] = "Nintendo Wii Balance Board",
+	[WIIMOTE_EXT_PRO_CONTROLLER] = "Nintendo Wii U Pro Controller",
 };
 
 /*
@@ -1634,6 +1653,8 @@ static ssize_t wiimote_ext_show(struct device *dev,
 		return sprintf(buf, "classic\n");
 	case WIIMOTE_EXT_BALANCE_BOARD:
 		return sprintf(buf, "balanceboard\n");
+	case WIIMOTE_EXT_PRO_CONTROLLER:
+		return sprintf(buf, "procontroller\n");
 	case WIIMOTE_EXT_UNKNOWN:
 		/* fallthrough */
 	default:
@@ -1680,6 +1701,8 @@ static ssize_t wiimote_dev_show(struct device *dev,
 		return sprintf(buf, "gen20\n");
 	case WIIMOTE_DEV_BALANCE_BOARD:
 		return sprintf(buf, "balanceboard\n");
+	case WIIMOTE_DEV_PRO_CONTROLLER:
+		return sprintf(buf, "procontroller\n");
 	case WIIMOTE_DEV_PENDING:
 		return sprintf(buf, "pending\n");
 	case WIIMOTE_DEV_UNKNOWN:
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index e2afe06..ab25a64 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1540,6 +1540,300 @@ static const struct wiimod_ops wiimod_bboard = {
 };
 
 /*
+ * Pro Controller
+ * Released with the Wii U was the Nintendo Wii U Pro Controller. It does not
+ * work together with the classic Wii, but only with the new Wii U. However, it
+ * uses the same protocol and provides a builtin "classic controller pro"
+ * extension, few standard buttons, a rumble motor, 4 LEDs and a battery.
+ * We provide all these via a standard extension device as the device doesn't
+ * feature an extension port.
+ */
+
+enum wiimod_pro_keys {
+	WIIMOD_PRO_KEY_A,
+	WIIMOD_PRO_KEY_B,
+	WIIMOD_PRO_KEY_X,
+	WIIMOD_PRO_KEY_Y,
+	WIIMOD_PRO_KEY_PLUS,
+	WIIMOD_PRO_KEY_MINUS,
+	WIIMOD_PRO_KEY_HOME,
+	WIIMOD_PRO_KEY_LEFT,
+	WIIMOD_PRO_KEY_RIGHT,
+	WIIMOD_PRO_KEY_UP,
+	WIIMOD_PRO_KEY_DOWN,
+	WIIMOD_PRO_KEY_TL,
+	WIIMOD_PRO_KEY_TR,
+	WIIMOD_PRO_KEY_ZL,
+	WIIMOD_PRO_KEY_ZR,
+	WIIMOD_PRO_KEY_THUMBL,
+	WIIMOD_PRO_KEY_THUMBR,
+	WIIMOD_PRO_KEY_NUM,
+};
+
+static const __u16 wiimod_pro_map[] = {
+	BTN_A,		/* WIIMOD_PRO_KEY_A */
+	BTN_B,		/* WIIMOD_PRO_KEY_B */
+	BTN_X,		/* WIIMOD_PRO_KEY_X */
+	BTN_Y,		/* WIIMOD_PRO_KEY_Y */
+	BTN_START,	/* WIIMOD_PRO_KEY_PLUS */
+	BTN_SELECT,	/* WIIMOD_PRO_KEY_MINUS */
+	BTN_MODE,	/* WIIMOD_PRO_KEY_HOME */
+	KEY_LEFT,	/* WIIMOD_PRO_KEY_LEFT */
+	KEY_RIGHT,	/* WIIMOD_PRO_KEY_RIGHT */
+	KEY_UP,		/* WIIMOD_PRO_KEY_UP */
+	KEY_DOWN,	/* WIIMOD_PRO_KEY_DOWN */
+	BTN_TL,		/* WIIMOD_PRO_KEY_TL */
+	BTN_TR,		/* WIIMOD_PRO_KEY_TR */
+	BTN_TL2,	/* WIIMOD_PRO_KEY_ZL */
+	BTN_TR2,	/* WIIMOD_PRO_KEY_ZR */
+	BTN_THUMBL,	/* WIIMOD_PRO_KEY_THUMBL */
+	BTN_THUMBR,	/* WIIMOD_PRO_KEY_THUMBR */
+};
+
+static void wiimod_pro_in_ext(struct wiimote_data *wdata, const __u8 *ext)
+{
+	__s16 rx, ry, lx, ly;
+
+	/*   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    1   |                   LX <7:0>                    |
+	 *   -----+-----------------------+-----------------------+
+	 *    2   |  0     0     0     0  |       LX <11:8>       |
+	 *   -----+-----------------------+-----------------------+
+	 *    3   |                   RX <7:0>                    |
+	 *   -----+-----------------------+-----------------------+
+	 *    4   |  0     0     0     0  |       RX <11:8>       |
+	 *   -----+-----------------------+-----------------------+
+	 *    5   |                   LY <7:0>                    |
+	 *   -----+-----------------------+-----------------------+
+	 *    6   |  0     0     0     0  |       LY <11:8>       |
+	 *   -----+-----------------------+-----------------------+
+	 *    7   |                   RY <7:0>                    |
+	 *   -----+-----------------------+-----------------------+
+	 *    8   |  0     0     0     0  |       RY <11:8>       |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    9   | BDR | BDD | BLT | B-  | BH  | B+  | BRT |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *   10   | BZL | BB  | BY  | BA  | BX  | BZR | BDL | BDU |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *   11   |  1  |     BATTERY     | USB |CHARG|LTHUM|RTHUM|
+	 *   -----+-----+-----------------+-----------+-----+-----+
+	 * All buttons are low-active (0 if pressed)
+	 * RX and RY are right analog stick
+	 * LX and LY are left analog stick
+	 * BLT is left trigger, BRT is right trigger.
+	 * BDR, BDD, BDL, BDU form the D-Pad with right, down, left, up buttons
+	 * BZL is left Z button and BZR is right Z button
+	 * B-, BH, B+ are +, HOME and - buttons
+	 * BB, BY, BA, BX are A, B, X, Y buttons
+	 *
+	 * Bits marked as 0/1 are unknown and never changed during tests.
+	 *
+	 * Not entirely verified:
+	 *   CHARG: 1 if uncharging, 0 if charging
+	 *   USB: 1 if not connected, 0 if connected via USB
+	 *   BATTERY: battery capacity from 000 (empty) to 100 (full)
+	 */
+
+	lx = (ext[0] & 0xff) | ((ext[1] & 0x0f) << 8);
+	rx = (ext[2] & 0xff) | ((ext[3] & 0x0f) << 8);
+	ly = (ext[4] & 0xff) | ((ext[5] & 0x0f) << 8);
+	ry = (ext[6] & 0xff) | ((ext[7] & 0x0f) << 8);
+
+	input_report_abs(wdata->extension.input, ABS_HAT0X, lx - 0x800);
+	input_report_abs(wdata->extension.input, ABS_HAT0Y, ly - 0x800);
+	input_report_abs(wdata->extension.input, ABS_HAT1X, rx - 0x800);
+	input_report_abs(wdata->extension.input, ABS_HAT1Y, ry - 0x800);
+
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_RIGHT],
+			 !(ext[8] & 0x80));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_DOWN],
+			 !(ext[8] & 0x40));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_TL],
+			 !(ext[8] & 0x20));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_MINUS],
+			 !(ext[8] & 0x10));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_HOME],
+			 !(ext[8] & 0x08));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_PLUS],
+			 !(ext[8] & 0x04));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_TR],
+			 !(ext[8] & 0x02));
+
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_ZL],
+			 !(ext[9] & 0x80));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_B],
+			 !(ext[9] & 0x40));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_Y],
+			 !(ext[9] & 0x20));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_A],
+			 !(ext[9] & 0x10));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_X],
+			 !(ext[9] & 0x08));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_ZR],
+			 !(ext[9] & 0x04));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_LEFT],
+			 !(ext[9] & 0x02));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_UP],
+			 !(ext[9] & 0x01));
+
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_THUMBL],
+			 !(ext[10] & 0x02));
+	input_report_key(wdata->extension.input,
+			 wiimod_pro_map[WIIMOD_PRO_KEY_THUMBR],
+			 !(ext[10] & 0x01));
+
+	input_sync(wdata->extension.input);
+}
+
+static int wiimod_pro_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_EXT_USED;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimod_pro_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags &= ~WIIPROTO_FLAG_EXT_USED;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static int wiimod_pro_play(struct input_dev *dev, void *data,
+			   struct ff_effect *eff)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	__u8 value;
+	unsigned long flags;
+
+	/*
+	 * The wiimote supports only a single rumble motor so if any magnitude
+	 * is set to non-zero then we start the rumble motor. If both are set to
+	 * zero, we stop the rumble motor.
+	 */
+
+	if (eff->u.rumble.strong_magnitude || eff->u.rumble.weak_magnitude)
+		value = 1;
+	else
+		value = 0;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_rumble(wdata, value);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static int wiimod_pro_probe(const struct wiimod_ops *ops,
+			    struct wiimote_data *wdata)
+{
+	int ret, i;
+
+	wdata->extension.input = input_allocate_device();
+	if (!wdata->extension.input)
+		return -ENOMEM;
+
+	set_bit(FF_RUMBLE, wdata->extension.input->ffbit);
+	input_set_drvdata(wdata->extension.input, wdata);
+
+	if (input_ff_create_memless(wdata->extension.input, NULL,
+				    wiimod_pro_play)) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	wdata->extension.input->open = wiimod_pro_open;
+	wdata->extension.input->close = wiimod_pro_close;
+	wdata->extension.input->dev.parent = &wdata->hdev->dev;
+	wdata->extension.input->id.bustype = wdata->hdev->bus;
+	wdata->extension.input->id.vendor = wdata->hdev->vendor;
+	wdata->extension.input->id.product = wdata->hdev->product;
+	wdata->extension.input->id.version = wdata->hdev->version;
+	wdata->extension.input->name = WIIMOTE_NAME " Pro Controller";
+
+	set_bit(EV_KEY, wdata->extension.input->evbit);
+	for (i = 0; i < WIIMOD_PRO_KEY_NUM; ++i)
+		set_bit(wiimod_pro_map[i],
+			wdata->extension.input->keybit);
+
+	set_bit(EV_ABS, wdata->extension.input->evbit);
+	set_bit(ABS_HAT0X, wdata->extension.input->absbit);
+	set_bit(ABS_HAT0Y, wdata->extension.input->absbit);
+	set_bit(ABS_HAT1X, wdata->extension.input->absbit);
+	set_bit(ABS_HAT1Y, wdata->extension.input->absbit);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT0X, -0x800, 0x800, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT0Y, -0x800, 0x800, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT1X, -0x800, 0x800, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT1Y, -0x800, 0x800, 2, 4);
+
+	ret = input_register_device(wdata->extension.input);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	input_free_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+	return ret;
+}
+
+static void wiimod_pro_remove(const struct wiimod_ops *ops,
+			      struct wiimote_data *wdata)
+{
+	unsigned long flags;
+
+	if (!wdata->extension.input)
+		return;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_rumble(wdata, 0);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	input_unregister_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+}
+
+static const struct wiimod_ops wiimod_pro = {
+	.flags = WIIMOD_FLAG_EXT16,
+	.arg = 0,
+	.probe = wiimod_pro_probe,
+	.remove = wiimod_pro_remove,
+	.in_ext = wiimod_pro_in_ext,
+};
+
+/*
  * Builtin Motion Plus
  * This module simply sets the WIIPROTO_FLAG_BUILTIN_MP protocol flag which
  * disables polling for Motion-Plus. This should be set only for devices which
@@ -1788,4 +2082,5 @@ const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_NUNCHUK] = &wiimod_nunchuk,
 	[WIIMOTE_EXT_CLASSIC_CONTROLLER] = &wiimod_classic,
 	[WIIMOTE_EXT_BALANCE_BOARD] = &wiimod_bboard,
+	[WIIMOTE_EXT_PRO_CONTROLLER] = &wiimod_pro,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 5cf8bcb..f1474f3 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -77,6 +77,7 @@ enum wiimote_devtype {
 	WIIMOTE_DEV_GEN10,
 	WIIMOTE_DEV_GEN20,
 	WIIMOTE_DEV_BALANCE_BOARD,
+	WIIMOTE_DEV_PRO_CONTROLLER,
 	WIIMOTE_DEV_NUM,
 };
 
@@ -86,6 +87,7 @@ enum wiimote_exttype {
 	WIIMOTE_EXT_NUNCHUK,
 	WIIMOTE_EXT_CLASSIC_CONTROLLER,
 	WIIMOTE_EXT_BALANCE_BOARD,
+	WIIMOTE_EXT_PRO_CONTROLLER,
 	WIIMOTE_EXT_NUM,
 };
 
-- 
1.8.2.2


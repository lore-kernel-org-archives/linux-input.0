From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 12/13] HID: wiimote: add support for Guitar-Hero drums
Date: Fri,  1 Nov 2013 21:16:23 +0100
Message-ID: <1383336984-26601-13-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:64666 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab3KAURE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:17:04 -0400
Received: by mail-ee0-f47.google.com with SMTP id c13so5099eek.6
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:17:03 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Guitar-Hero comes with a drums extension. Use the newly introduced input
drums-bits to report this back to user-space. This is a usual extension
like any other device. Nothing special to take care of.

We report this to user-space as "Nintendo Wii Remote Drums". There are
other drums (like "RockBand" drums) which we currently do not support and
maybe will at some point. However, it is quite likely that we can report
these via the same interface. This allows user-space to work with them
without knowing the exact branding.
I couldn't find anyone who owns a "RockBand" device, though.

Initial-work-by: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    |   7 ++
 drivers/hid/hid-wiimote-modules.c | 218 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   2 +
 3 files changed, 227 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 89ca031..6212678 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -458,6 +458,9 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
 		return WIIMOTE_EXT_BALANCE_BOARD;
 	if (rmem[4] == 0x01 && rmem[5] == 0x20)
 		return WIIMOTE_EXT_PRO_CONTROLLER;
+	if (rmem[0] == 0x01 && rmem[1] == 0x00 &&
+	    rmem[4] == 0x01 && rmem[5] == 0x03)
+		return WIIMOTE_EXT_GUITAR_HERO_DRUMS;
 
 	return WIIMOTE_EXT_UNKNOWN;
 }
@@ -491,6 +494,7 @@ static bool wiimote_cmd_map_mp(struct wiimote_data *wdata, __u8 exttype)
 	/* map MP with correct pass-through mode */
 	switch (exttype) {
 	case WIIMOTE_EXT_CLASSIC_CONTROLLER:
+	case WIIMOTE_EXT_GUITAR_HERO_DRUMS:
 		wmem = 0x07;
 		break;
 	case WIIMOTE_EXT_NUNCHUK:
@@ -1079,6 +1083,7 @@ static const char *wiimote_exttype_names[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_CLASSIC_CONTROLLER] = "Nintendo Wii Classic Controller",
 	[WIIMOTE_EXT_BALANCE_BOARD] = "Nintendo Wii Balance Board",
 	[WIIMOTE_EXT_PRO_CONTROLLER] = "Nintendo Wii U Pro Controller",
+	[WIIMOTE_EXT_GUITAR_HERO_DRUMS] = "Nintendo Wii Guitar Hero Drums",
 };
 
 /*
@@ -1664,6 +1669,8 @@ static ssize_t wiimote_ext_show(struct device *dev,
 		return sprintf(buf, "balanceboard\n");
 	case WIIMOTE_EXT_PRO_CONTROLLER:
 		return sprintf(buf, "procontroller\n");
+	case WIIMOTE_EXT_GUITAR_HERO_DRUMS:
+		return sprintf(buf, "drums\n");
 	case WIIMOTE_EXT_UNKNOWN:
 		/* fallthrough */
 	default:
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index e51e82b..5f6d66b 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -2090,6 +2090,223 @@ static const struct wiimod_ops wiimod_pro = {
 };
 
 /*
+ * Drums
+ * Guitar-Hero, Rock-Band and other games came bundled with drums which can
+ * be plugged as extension to a Wiimote. Drum-reports are still not entirely
+ * figured out, but the most important information is known.
+ * We create a separate device for drums and report all information via this
+ * input device.
+ */
+
+static inline void wiimod_drums_report_pressure(struct wiimote_data *wdata,
+						__u8 none, __u8 which,
+						__u8 pressure, __u8 onoff,
+						__u8 *store, __u16 code,
+						__u8 which_code)
+{
+	static const __u8 default_pressure = 3;
+
+	if (!none && which == which_code) {
+		*store = pressure;
+		input_report_abs(wdata->extension.input, code, *store);
+	} else if (onoff != !!*store) {
+		*store = onoff ? default_pressure : 0;
+		input_report_abs(wdata->extension.input, code, *store);
+	}
+}
+
+static void wiimod_drums_in_ext(struct wiimote_data *wdata, const __u8 *ext)
+{
+	__u8 pressure, which, none, hhp, sx, sy;
+	__u8 o, r, y, g, b, bass, bm, bp;
+
+	/*   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    1   |  0  |  0  |              SX <5:0>             |
+	 *    2   |  0  |  0  |              SY <5:0>             |
+	 *   -----+-----+-----+-----------------------------+-----+
+	 *    3   | HPP | NON |         WHICH <5:1>         |  ?  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    4   |   SOFT <7:5>    |  0  |  1  |  1  |  0  |  ?  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    5   |  ?  |  1  |  1  | B-  |  1  | B+  |  1  |  ?  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    6   |  O  |  R  |  Y  |  G  |  B  | BSS |  1  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 * All buttons are 0 if pressed
+	 *
+	 * With Motion+ enabled, the following bits will get invalid:
+	 *   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    1   |  0  |  0  |              SX <5:1>       |XXXXX|
+	 *    2   |  0  |  0  |              SY <5:1>       |XXXXX|
+	 *   -----+-----+-----+-----------------------------+-----+
+	 *    3   | HPP | NON |         WHICH <5:1>         |  ?  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    4   |   SOFT <7:5>    |  0  |  1  |  1  |  0  |  ?  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    5   |  ?  |  1  |  1  | B-  |  1  | B+  |  1  |XXXXX|
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    6   |  O  |  R  |  Y  |  G  |  B  | BSS |XXXXX|XXXXX|
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 */
+
+	pressure = 7 - (ext[3] >> 5);
+	which = (ext[2] >> 1) & 0x1f;
+	none = !!(ext[2] & 0x40);
+	hhp = !(ext[2] & 0x80);
+	sx = ext[0] & 0x3f;
+	sy = ext[1] & 0x3f;
+	o = !(ext[5] & 0x80);
+	r = !(ext[5] & 0x40);
+	y = !(ext[5] & 0x20);
+	g = !(ext[5] & 0x10);
+	b = !(ext[5] & 0x08);
+	bass = !(ext[5] & 0x04);
+	bm = !(ext[4] & 0x10);
+	bp = !(ext[4] & 0x04);
+
+	wiimod_drums_report_pressure(wdata, none, which, pressure,
+				     o, &wdata->state.pressure_drums[0],
+				     ABS_CYMBAL_RIGHT, 0x0e);
+	wiimod_drums_report_pressure(wdata, none, which, pressure,
+				     r, &wdata->state.pressure_drums[1],
+				     ABS_TOM_LEFT, 0x19);
+	wiimod_drums_report_pressure(wdata, none, which, pressure,
+				     y, &wdata->state.pressure_drums[2],
+				     ABS_CYMBAL_LEFT, 0x11);
+	wiimod_drums_report_pressure(wdata, none, which, pressure,
+				     g, &wdata->state.pressure_drums[3],
+				     ABS_TOM_FAR_RIGHT, 0x12);
+	wiimod_drums_report_pressure(wdata, none, which, pressure,
+				     b, &wdata->state.pressure_drums[4],
+				     ABS_TOM_RIGHT, 0x0f);
+
+	/* Bass shares pressure with hi-hat (set via hhp) */
+	wiimod_drums_report_pressure(wdata, none, hhp ? 0xff : which, pressure,
+				     bass, &wdata->state.pressure_drums[5],
+				     ABS_BASS, 0x1b);
+	/* Hi-hat has no on/off values, just pressure. Force to off/0. */
+	wiimod_drums_report_pressure(wdata, none, hhp ? which : 0xff, pressure,
+				     0, &wdata->state.pressure_drums[6],
+				     ABS_HI_HAT, 0x0e);
+
+	input_report_abs(wdata->extension.input, ABS_X, sx - 0x20);
+	input_report_abs(wdata->extension.input, ABS_Y, sy - 0x20);
+
+	input_report_key(wdata->extension.input, BTN_START, bp);
+	input_report_key(wdata->extension.input, BTN_SELECT, bm);
+
+	input_sync(wdata->extension.input);
+}
+
+static int wiimod_drums_open(struct input_dev *dev)
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
+static void wiimod_drums_close(struct input_dev *dev)
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
+static int wiimod_drums_probe(const struct wiimod_ops *ops,
+			      struct wiimote_data *wdata)
+{
+	int ret;
+
+	wdata->extension.input = input_allocate_device();
+	if (!wdata->extension.input)
+		return -ENOMEM;
+
+	input_set_drvdata(wdata->extension.input, wdata);
+	wdata->extension.input->open = wiimod_drums_open;
+	wdata->extension.input->close = wiimod_drums_close;
+	wdata->extension.input->dev.parent = &wdata->hdev->dev;
+	wdata->extension.input->id.bustype = wdata->hdev->bus;
+	wdata->extension.input->id.vendor = wdata->hdev->vendor;
+	wdata->extension.input->id.product = wdata->hdev->product;
+	wdata->extension.input->id.version = wdata->hdev->version;
+	wdata->extension.input->name = WIIMOTE_NAME " Drums";
+
+	set_bit(EV_KEY, wdata->extension.input->evbit);
+	set_bit(BTN_START, wdata->extension.input->keybit);
+	set_bit(BTN_SELECT, wdata->extension.input->keybit);
+
+	set_bit(EV_ABS, wdata->extension.input->evbit);
+	set_bit(ABS_X, wdata->extension.input->absbit);
+	set_bit(ABS_Y, wdata->extension.input->absbit);
+	set_bit(ABS_TOM_LEFT, wdata->extension.input->absbit);
+	set_bit(ABS_TOM_RIGHT, wdata->extension.input->absbit);
+	set_bit(ABS_TOM_FAR_RIGHT, wdata->extension.input->absbit);
+	set_bit(ABS_CYMBAL_LEFT, wdata->extension.input->absbit);
+	set_bit(ABS_CYMBAL_RIGHT, wdata->extension.input->absbit);
+	set_bit(ABS_BASS, wdata->extension.input->absbit);
+	set_bit(ABS_HI_HAT, wdata->extension.input->absbit);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_X, -32, 31, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_Y, -32, 31, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_TOM_LEFT, 0, 7, 0, 0);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_TOM_RIGHT, 0, 7, 0, 0);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_TOM_FAR_RIGHT, 0, 7, 0, 0);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_CYMBAL_LEFT, 0, 7, 0, 0);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_CYMBAL_RIGHT, 0, 7, 0, 0);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_BASS, 0, 7, 0, 0);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HI_HAT, 0, 7, 0, 0);
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
+static void wiimod_drums_remove(const struct wiimod_ops *ops,
+				struct wiimote_data *wdata)
+{
+	if (!wdata->extension.input)
+		return;
+
+	input_unregister_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+}
+
+static const struct wiimod_ops wiimod_drums = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_drums_probe,
+	.remove = wiimod_drums_remove,
+	.in_ext = wiimod_drums_in_ext,
+};
+
+/*
  * Builtin Motion Plus
  * This module simply sets the WIIPROTO_FLAG_BUILTIN_MP protocol flag which
  * disables polling for Motion-Plus. This should be set only for devices which
@@ -2359,4 +2576,5 @@ const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_CLASSIC_CONTROLLER] = &wiimod_classic,
 	[WIIMOTE_EXT_BALANCE_BOARD] = &wiimod_bboard,
 	[WIIMOTE_EXT_PRO_CONTROLLER] = &wiimod_pro,
+	[WIIMOTE_EXT_GUITAR_HERO_DRUMS] = &wiimod_drums,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 6f70823..c8a7fc3 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -90,6 +90,7 @@ enum wiimote_exttype {
 	WIIMOTE_EXT_CLASSIC_CONTROLLER,
 	WIIMOTE_EXT_BALANCE_BOARD,
 	WIIMOTE_EXT_PRO_CONTROLLER,
+	WIIMOTE_EXT_GUITAR_HERO_DRUMS,
 	WIIMOTE_EXT_NUM,
 };
 
@@ -139,6 +140,7 @@ struct wiimote_state {
 	__u16 calib_bboard[4][3];
 	__s16 calib_pro_sticks[4];
 	__u8 cache_rumble;
+	__u8 pressure_drums[7];
 };
 
 struct wiimote_data {
-- 
1.8.4.1


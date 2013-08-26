From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 3/3] HID: wiimote: add support for Guitar-Hero guitars
Date: Mon, 26 Aug 2013 19:14:48 +0200
Message-ID: <1377537288-19289-4-git-send-email-dh.herrmann@gmail.com>
References: <1377537288-19289-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:52818 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3HZRPS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 13:15:18 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so1772158eek.12
        for <linux-input@vger.kernel.org>; Mon, 26 Aug 2013 10:15:16 -0700 (PDT)
In-Reply-To: <1377537288-19289-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

From: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>

Apart from drums, Guitar-Hero also ships with guitars. Use the recently
introduced input ABS/BTN-bits to report this to user-space.

Devices are reported as "Nintendo Wii Remote Guitar". If I ever get my
hands on "RockBand" guitars, I will try to report them via the same
interface so user-space does not have to bother which device it deals
with.

Signed-off-by: Nicolas.Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
(add commit-msg and adjust to new BTN_* IDs)
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    |   7 ++
 drivers/hid/hid-wiimote-modules.c | 174 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   1 +
 3 files changed, 182 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 946cdef..d3055d1 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -459,6 +459,9 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
 	if (rmem[0] == 0x01 && rmem[1] == 0x00 &&
 	    rmem[4] == 0x01 && rmem[5] == 0x03)
 		return WIIMOTE_EXT_GUITAR_HERO_DRUMS;
+	if (rmem[0] == 0x00 && rmem[1] == 0x00 &&
+	    rmem[4] == 0x01 && rmem[5] == 0x03)
+		return WIIMOTE_EXT_GUITAR_HERO_GUITAR;
 
 	return WIIMOTE_EXT_UNKNOWN;
 }
@@ -493,6 +496,7 @@ static bool wiimote_cmd_map_mp(struct wiimote_data *wdata, __u8 exttype)
 	switch (exttype) {
 	case WIIMOTE_EXT_CLASSIC_CONTROLLER:
 	case WIIMOTE_EXT_GUITAR_HERO_DRUMS:
+	case WIIMOTE_EXT_GUITAR_HERO_GUITAR:
 		wmem = 0x07;
 		break;
 	case WIIMOTE_EXT_NUNCHUK:
@@ -1084,6 +1088,7 @@ static const char *wiimote_exttype_names[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_BALANCE_BOARD] = "Nintendo Wii Balance Board",
 	[WIIMOTE_EXT_PRO_CONTROLLER] = "Nintendo Wii U Pro Controller",
 	[WIIMOTE_EXT_GUITAR_HERO_DRUMS] = "Nintendo Wii Guitar Hero Drums",
+	[WIIMOTE_EXT_GUITAR_HERO_GUITAR] = "Nintendo Wii Guitar Hero Guitar",
 };
 
 /*
@@ -1672,6 +1677,8 @@ static ssize_t wiimote_ext_show(struct device *dev,
 		return sprintf(buf, "procontroller\n");
 	case WIIMOTE_EXT_GUITAR_HERO_DRUMS:
 		return sprintf(buf, "drums\n");
+	case WIIMOTE_EXT_GUITAR_HERO_GUITAR:
+		return sprintf(buf, "guitar\n");
 	case WIIMOTE_EXT_UNKNOWN:
 		/* fallthrough */
 	default:
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 08a44a7..7e124c3 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -2051,6 +2051,179 @@ static const struct wiimod_ops wiimod_drums = {
 };
 
 /*
+ * Guitar
+ * Guitar-Hero, Rock-Band and other games came bundled with guitars which can
+ * be plugged as extension to a Wiimote.
+ * We create a separate device for guitars and report all information via this
+ * input device.
+ */
+
+static void wiimod_guitar_in_ext(struct wiimote_data *wdata, const __u8 *ext)
+{
+	__u8 sx, sy, tb, wb, bd, bm, bp, bo, br, bb, bg, by, bu;
+
+	/*   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    1   |  0  |  0  |              SX <5:0>             |
+	 *    2   |  0  |  0  |              SY <5:0>             |
+	 *   -----+-----+-----+-----+-----------------------------+
+	 *    3   |  0  |  0  |  0  |      TB <4:0>               |
+	 *   -----+-----+-----+-----+-----------------------------+
+	 *    4   |  0  |  0  |  0  |      WB <4:0>               |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    5   |  1  | BD  |  1  | B-  |  1  | B+  |  1  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    6   | BO  | BR  | BB  | BG  | BY  |  1  |  1  | BU  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 * All buttons are 0 if pressed
+	 *
+	 * With Motion+ enabled, the following bits will get invalid:
+	 *   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    1   |  0  |  0  |              SX <5:1>       |XXXXX|
+	 *    2   |  0  |  0  |              SY <5:1>       |XXXXX|
+	 *   -----+-----+-----+-----+-----------------------+-----+
+	 *    3   |  0  |  0  |  0  |      TB <4:0>               |
+	 *   -----+-----+-----+-----+-----------------------------+
+	 *    4   |  0  |  0  |  0  |      WB <4:0>               |
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    5   |  1  | BD  |  1  | B-  |  1  | B+  |  1  |XXXXX|
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 *    6   | BO  | BR  | BB  | BG  | BY  |  1  |XXXXX|XXXXX|
+	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
+	 */
+
+	sx = ext[0] & 0x3f;
+	sy = ext[1] & 0x3f;
+	tb = ext[2] & 0x1f;
+	wb = ext[3] & 0x1f;
+	bd = !(ext[4] & 0x40);
+	bm = !(ext[4] & 0x10);
+	bp = !(ext[4] & 0x04);
+	bo = !(ext[5] & 0x80);
+	br = !(ext[5] & 0x40);
+	bb = !(ext[5] & 0x20);
+	bg = !(ext[5] & 0x10);
+	by = !(ext[5] & 0x08);
+	bu = !(ext[5] & 0x01);
+
+	input_report_abs(wdata->extension.input, ABS_X, sx - 0x20);
+	input_report_abs(wdata->extension.input, ABS_Y, sy - 0x20);
+	input_report_abs(wdata->extension.input, ABS_FRET_BOARD, tb);
+	input_report_abs(wdata->extension.input, ABS_WHAMMY_BAR, wb - 0x10);
+
+	input_report_key(wdata->extension.input, BTN_MODE, bm);
+	input_report_key(wdata->extension.input, BTN_START, bp);
+	input_report_key(wdata->extension.input, BTN_STRUM_BAR_UP, bu);
+	input_report_key(wdata->extension.input, BTN_STRUM_BAR_DOWN, bd);
+	input_report_key(wdata->extension.input, BTN_FRET_FAR_UP, bg);
+	input_report_key(wdata->extension.input, BTN_FRET_UP, br);
+	input_report_key(wdata->extension.input, BTN_FRET_MID, by);
+	input_report_key(wdata->extension.input, BTN_FRET_LOW, bb);
+	input_report_key(wdata->extension.input, BTN_FRET_FAR_LOW, bo);
+
+	input_sync(wdata->extension.input);
+}
+
+static int wiimod_guitar_open(struct input_dev *dev)
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
+static void wiimod_guitar_close(struct input_dev *dev)
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
+static int wiimod_guitar_probe(const struct wiimod_ops *ops,
+			       struct wiimote_data *wdata)
+{
+	int ret;
+
+	wdata->extension.input = input_allocate_device();
+	if (!wdata->extension.input)
+		return -ENOMEM;
+
+	input_set_drvdata(wdata->extension.input, wdata);
+	wdata->extension.input->open = wiimod_guitar_open;
+	wdata->extension.input->close = wiimod_guitar_close;
+	wdata->extension.input->dev.parent = &wdata->hdev->dev;
+	wdata->extension.input->id.bustype = wdata->hdev->bus;
+	wdata->extension.input->id.vendor = wdata->hdev->vendor;
+	wdata->extension.input->id.product = wdata->hdev->product;
+	wdata->extension.input->id.version = wdata->hdev->version;
+	wdata->extension.input->name = WIIMOTE_NAME " Guitar";
+
+	set_bit(EV_KEY, wdata->extension.input->evbit);
+	set_bit(BTN_MODE, wdata->extension.input->keybit);
+	set_bit(BTN_START, wdata->extension.input->keybit);
+	set_bit(BTN_FRET_FAR_UP, wdata->extension.input->keybit);
+	set_bit(BTN_FRET_UP, wdata->extension.input->keybit);
+	set_bit(BTN_FRET_MID, wdata->extension.input->keybit);
+	set_bit(BTN_FRET_LOW, wdata->extension.input->keybit);
+	set_bit(BTN_FRET_FAR_LOW, wdata->extension.input->keybit);
+	set_bit(BTN_STRUM_BAR_UP, wdata->extension.input->keybit);
+	set_bit(BTN_STRUM_BAR_DOWN, wdata->extension.input->keybit);
+
+	set_bit(EV_ABS, wdata->extension.input->evbit);
+	set_bit(ABS_X, wdata->extension.input->absbit);
+	set_bit(ABS_Y, wdata->extension.input->absbit);
+	set_bit(ABS_FRET_BOARD, wdata->extension.input->absbit);
+	set_bit(ABS_WHAMMY_BAR, wdata->extension.input->absbit);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_X, -32, 31, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_Y, -32, 31, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_FRET_BOARD, 0, 0x1f, 1, 1);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_WHAMMY_BAR, 0, 0x0f, 1, 1);
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
+static void wiimod_guitar_remove(const struct wiimod_ops *ops,
+				 struct wiimote_data *wdata)
+{
+	if (!wdata->extension.input)
+		return;
+
+	input_unregister_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+}
+
+static const struct wiimod_ops wiimod_guitar = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_guitar_probe,
+	.remove = wiimod_guitar_remove,
+	.in_ext = wiimod_guitar_in_ext,
+};
+
+/*
  * Builtin Motion Plus
  * This module simply sets the WIIPROTO_FLAG_BUILTIN_MP protocol flag which
  * disables polling for Motion-Plus. This should be set only for devices which
@@ -2301,4 +2474,5 @@ const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_BALANCE_BOARD] = &wiimod_bboard,
 	[WIIMOTE_EXT_PRO_CONTROLLER] = &wiimod_pro,
 	[WIIMOTE_EXT_GUITAR_HERO_DRUMS] = &wiimod_drums,
+	[WIIMOTE_EXT_GUITAR_HERO_GUITAR] = &wiimod_guitar,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 6e18b55..379cdfb 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -89,6 +89,7 @@ enum wiimote_exttype {
 	WIIMOTE_EXT_BALANCE_BOARD,
 	WIIMOTE_EXT_PRO_CONTROLLER,
 	WIIMOTE_EXT_GUITAR_HERO_DRUMS,
+	WIIMOTE_EXT_GUITAR_HERO_GUITAR,
 	WIIMOTE_EXT_NUM,
 };
 
-- 
1.8.4


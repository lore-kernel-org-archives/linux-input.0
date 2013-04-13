From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 15/21] HID: wiimote: add Nunchuk support
Date: Sat, 13 Apr 2013 12:47:56 +0200
Message-ID: <1365850082-3585-16-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:38324 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3DMKsy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:54 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so1632762eek.32
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:52 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

This moves the nunchuk parser over to an extension module. This allows to
make use of hotplugged Nunchuks instead of the old static parser.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    |   6 ++
 drivers/hid/hid-wiimote-modules.c | 198 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   1 +
 3 files changed, 205 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 573f439..39a65e0 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -433,6 +433,8 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
 	    rmem[3] == 0xff && rmem[4] == 0xff && rmem[5] == 0xff)
 		return WIIMOTE_EXT_NONE;
 
+	if (rmem[4] == 0x00 && rmem[5] == 0x00)
+		return WIIMOTE_EXT_NUNCHUK;
 	if (rmem[4] == 0x04 && rmem[5] == 0x02)
 		return WIIMOTE_EXT_BALANCE_BOARD;
 
@@ -467,6 +469,9 @@ static bool wiimote_cmd_map_mp(struct wiimote_data *wdata, __u8 exttype)
 
 	/* map MP with correct pass-through mode */
 	switch (exttype) {
+	case WIIMOTE_EXT_NUNCHUK:
+		wmem = 0x05;
+		break;
 	default:
 		wmem = 0x04;
 		break;
@@ -1006,6 +1011,7 @@ out_release:
 static const char *wiimote_exttype_names[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_NONE] = "None",
 	[WIIMOTE_EXT_UNKNOWN] = "Unknown",
+	[WIIMOTE_EXT_NUNCHUK] = "Nintendo Wii Nunchuk",
 	[WIIMOTE_EXT_BALANCE_BOARD] = "Nintendo Wii Balance Board",
 };
 
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 6239cd8..e4bcc09 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -789,6 +789,203 @@ static const struct wiimod_ops wiimod_ir = {
 };
 
 /*
+ * Nunchuk Extension
+ * The Nintendo Wii Nunchuk was the first official extension published by
+ * Nintendo. It provides two additional keys and a separate accelerometer. It
+ * can be hotplugged to standard Wii Remotes.
+ */
+
+enum wiimod_nunchuk_keys {
+	WIIMOD_NUNCHUK_KEY_C,
+	WIIMOD_NUNCHUK_KEY_Z,
+	WIIMOD_NUNCHUK_KEY_NUM,
+};
+
+static const __u16 wiimod_nunchuk_map[] = {
+	BTN_C,		/* WIIMOD_NUNCHUK_KEY_C */
+	BTN_Z,		/* WIIMOD_NUNCHUK_KEY_Z */
+};
+
+static void wiimod_nunchuk_in_ext(struct wiimote_data *wdata, const __u8 *ext)
+{
+	__s16 x, y, z, bx, by;
+
+	/*   Byte |   8    7 |  6    5 |  4    3 |  2 |  1  |
+	 *   -----+----------+---------+---------+----+-----+
+	 *    1   |              Button X <7:0>             |
+	 *    2   |              Button Y <7:0>             |
+	 *   -----+----------+---------+---------+----+-----+
+	 *    3   |               Speed X <9:2>             |
+	 *    4   |               Speed Y <9:2>             |
+	 *    5   |               Speed Z <9:2>             |
+	 *   -----+----------+---------+---------+----+-----+
+	 *    6   | Z <1:0>  | Y <1:0> | X <1:0> | BC | BZ  |
+	 *   -----+----------+---------+---------+----+-----+
+	 * Button X/Y is the analog stick. Speed X, Y and Z are the
+	 * accelerometer data in the same format as the wiimote's accelerometer.
+	 * The 6th byte contains the LSBs of the accelerometer data.
+	 * BC and BZ are the C and Z buttons: 0 means pressed
+	 *
+	 * If reported interleaved with motionp, then the layout changes. The
+	 * 5th and 6th byte changes to:
+	 *   -----+-----------------------------------+-----+
+	 *    5   |            Speed Z <9:3>          | EXT |
+	 *   -----+--------+-----+-----+----+----+----+-----+
+	 *    6   |Z <2:1> |Y <1>|X <1>| BC | BZ | 0  |  0  |
+	 *   -----+--------+-----+-----+----+----+----+-----+
+	 * All three accelerometer values lose their LSB. The other data is
+	 * still available but slightly moved.
+	 *
+	 * Center data for button values is 128. Center value for accelerometer
+	 * values it 512 / 0x200
+	 */
+
+	bx = ext[0];
+	by = ext[1];
+	bx -= 128;
+	by -= 128;
+
+	x = ext[2] << 2;
+	y = ext[3] << 2;
+	z = ext[4] << 2;
+
+	if (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE) {
+		x |= (ext[5] >> 3) & 0x02;
+		y |= (ext[5] >> 4) & 0x02;
+		z &= ~0x4;
+		z |= (ext[5] >> 5) & 0x06;
+	} else {
+		x |= (ext[5] >> 2) & 0x03;
+		y |= (ext[5] >> 4) & 0x03;
+		z |= (ext[5] >> 6) & 0x03;
+	}
+
+	x -= 0x200;
+	y -= 0x200;
+	z -= 0x200;
+
+	input_report_abs(wdata->extension.input, ABS_HAT0X, bx);
+	input_report_abs(wdata->extension.input, ABS_HAT0Y, by);
+
+	input_report_abs(wdata->extension.input, ABS_RX, x);
+	input_report_abs(wdata->extension.input, ABS_RY, y);
+	input_report_abs(wdata->extension.input, ABS_RZ, z);
+
+	if (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE) {
+		input_report_key(wdata->extension.input,
+			wiimod_nunchuk_map[WIIMOD_NUNCHUK_KEY_Z],
+			!(ext[5] & 0x04));
+		input_report_key(wdata->extension.input,
+			wiimod_nunchuk_map[WIIMOD_NUNCHUK_KEY_C],
+			!(ext[5] & 0x08));
+	} else {
+		input_report_key(wdata->extension.input,
+			wiimod_nunchuk_map[WIIMOD_NUNCHUK_KEY_Z],
+			!(ext[5] & 0x01));
+		input_report_key(wdata->extension.input,
+			wiimod_nunchuk_map[WIIMOD_NUNCHUK_KEY_C],
+			!(ext[5] & 0x02));
+	}
+
+	input_sync(wdata->extension.input);
+}
+
+static int wiimod_nunchuk_open(struct input_dev *dev)
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
+static void wiimod_nunchuk_close(struct input_dev *dev)
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
+static int wiimod_nunchuk_probe(const struct wiimod_ops *ops,
+				struct wiimote_data *wdata)
+{
+	int ret, i;
+
+	wdata->extension.input = input_allocate_device();
+	if (!wdata->extension.input)
+		return -ENOMEM;
+
+	input_set_drvdata(wdata->extension.input, wdata);
+	wdata->extension.input->open = wiimod_nunchuk_open;
+	wdata->extension.input->close = wiimod_nunchuk_close;
+	wdata->extension.input->dev.parent = &wdata->hdev->dev;
+	wdata->extension.input->id.bustype = wdata->hdev->bus;
+	wdata->extension.input->id.vendor = wdata->hdev->vendor;
+	wdata->extension.input->id.product = wdata->hdev->product;
+	wdata->extension.input->id.version = wdata->hdev->version;
+	wdata->extension.input->name = WIIMOTE_NAME " Nunchuk";
+
+	set_bit(EV_KEY, wdata->extension.input->evbit);
+	for (i = 0; i < WIIMOD_NUNCHUK_KEY_NUM; ++i)
+		set_bit(wiimod_nunchuk_map[i],
+			wdata->extension.input->keybit);
+
+	set_bit(EV_ABS, wdata->extension.input->evbit);
+	set_bit(ABS_HAT0X, wdata->extension.input->absbit);
+	set_bit(ABS_HAT0Y, wdata->extension.input->absbit);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT0X, -120, 120, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_HAT0Y, -120, 120, 2, 4);
+	set_bit(ABS_RX, wdata->extension.input->absbit);
+	set_bit(ABS_RY, wdata->extension.input->absbit);
+	set_bit(ABS_RZ, wdata->extension.input->absbit);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_RX, -500, 500, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_RY, -500, 500, 2, 4);
+	input_set_abs_params(wdata->extension.input,
+			     ABS_RZ, -500, 500, 2, 4);
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
+static void wiimod_nunchuk_remove(const struct wiimod_ops *ops,
+				  struct wiimote_data *wdata)
+{
+	if (!wdata->extension.input)
+		return;
+
+	input_unregister_device(wdata->extension.input);
+	wdata->extension.input = NULL;
+}
+
+static const struct wiimod_ops wiimod_nunchuk = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_nunchuk_probe,
+	.remove = wiimod_nunchuk_remove,
+	.in_ext = wiimod_nunchuk_in_ext,
+};
+
+/*
  * Balance Board Extension
  * The Nintendo Wii Balance Board provides four hardware weight sensor plus a
  * single push button. No other peripherals are available. However, the
@@ -1026,5 +1223,6 @@ const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
 	[WIIMOTE_EXT_NONE] = &wiimod_dummy,
 	[WIIMOTE_EXT_UNKNOWN] = &wiimod_dummy,
+	[WIIMOTE_EXT_NUNCHUK] = &wiimod_nunchuk,
 	[WIIMOTE_EXT_BALANCE_BOARD] = &wiimod_bboard,
 };
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 79dbeac..6b6e821 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -80,6 +80,7 @@ enum wiimote_devtype {
 enum wiimote_exttype {
 	WIIMOTE_EXT_NONE,
 	WIIMOTE_EXT_UNKNOWN,
+	WIIMOTE_EXT_NUNCHUK,
 	WIIMOTE_EXT_BALANCE_BOARD,
 	WIIMOTE_EXT_NUM,
 };
-- 
1.8.2.1


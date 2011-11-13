From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 11/16] HID: wiimote: Parse nunchuck data
Date: Sun, 13 Nov 2011 14:27:14 +0100
Message-ID: <1321190839-3517-12-git-send-email-dh.herrmann@googlemail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43554 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab1KMN2L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:28:11 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so4910956bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:28:10 -0800 (PST)
In-Reply-To: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

The Nintendo Nunchuck extension reports accelerometer values, one analog stick
and two buttons. See inline comments for data layout.
We report all data to userspace through extension input device.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-ext.c |  105 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 104 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 5953862..bac2e45 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -36,6 +36,17 @@ enum wiiext_type {
 	WIIEXT_NUNCHUCK,	/* Nintendo nunchuck controller */
 };
 
+enum wiiext_keys {
+	WIIEXT_KEY_C,
+	WIIEXT_KEY_Z,
+	WIIEXT_KEY_COUNT
+};
+
+static __u16 wiiext_keymap[] = {
+	BTN_C,		/* WIIEXT_KEY_C */
+	BTN_Z,		/* WIIEXT_KEY_Z */
+};
+
 /* diable all extensions */
 static void ext_disable(struct wiimote_ext *ext)
 {
@@ -272,6 +283,82 @@ static void handler_motionp(struct wiimote_ext *ext, const __u8 *payload)
 
 static void handler_nunchuck(struct wiimote_ext *ext, const __u8 *payload)
 {
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
+	bx = payload[0];
+	by = payload[1];
+	bx -= 128;
+	by -= 128;
+
+	x = payload[2] << 2;
+	y = payload[3] << 2;
+	z = payload[4] << 2;
+
+	if (ext->motionp) {
+		x |= (payload[5] >> 3) & 0x02;
+		y |= (payload[5] >> 4) & 0x02;
+		z &= ~0x4;
+		z |= (payload[5] >> 5) & 0x06;
+	} else {
+		x |= (payload[5] >> 2) & 0x03;
+		y |= (payload[5] >> 4) & 0x03;
+		z |= (payload[5] >> 6) & 0x03;
+	}
+
+	x -= 0x200;
+	y -= 0x200;
+	z -= 0x200;
+
+	input_report_abs(ext->input, ABS_HAT0X, bx);
+	input_report_abs(ext->input, ABS_HAT0Y, by);
+
+	input_report_abs(ext->input, ABS_RX, x);
+	input_report_abs(ext->input, ABS_RY, y);
+	input_report_abs(ext->input, ABS_RZ, z);
+
+	if (ext->motionp) {
+		input_report_key(ext->input,
+			wiiext_keymap[WIIEXT_KEY_Z], !!(payload[5] & 0x04));
+		input_report_key(ext->input,
+			wiiext_keymap[WIIEXT_KEY_C], !!(payload[5] & 0x08));
+	} else {
+		input_report_key(ext->input,
+			wiiext_keymap[WIIEXT_KEY_Z], !!(payload[5] & 0x01));
+		input_report_key(ext->input,
+			wiiext_keymap[WIIEXT_KEY_C], !!(payload[5] & 0x02));
+	}
+
+	input_sync(ext->input);
 }
 
 static void handler_classic(struct wiimote_ext *ext, const __u8 *payload)
@@ -383,7 +470,7 @@ int wiiext_init(struct wiimote_data *wdata)
 {
 	struct wiimote_ext *ext;
 	unsigned long flags;
-	int ret;
+	int ret, i;
 
 	ext = kzalloc(sizeof(*ext), GFP_KERNEL);
 	if (!ext)
@@ -408,6 +495,22 @@ int wiiext_init(struct wiimote_data *wdata)
 	ext->input->id.version = wdata->hdev->version;
 	ext->input->name = WIIMOTE_NAME " Extension";
 
+	set_bit(EV_KEY, ext->input->evbit);
+	for (i = 0; i < WIIEXT_KEY_COUNT; ++i)
+		set_bit(wiiext_keymap[i], ext->input->keybit);
+
+	set_bit(EV_ABS, ext->input->evbit);
+	set_bit(ABS_HAT0X, ext->input->absbit);
+	set_bit(ABS_HAT0Y, ext->input->absbit);
+	input_set_abs_params(ext->input, ABS_HAT0X, -120, 120, 2, 4);
+	input_set_abs_params(ext->input, ABS_HAT0Y, -120, 120, 2, 4);
+	set_bit(ABS_RX, ext->input->absbit);
+	set_bit(ABS_RY, ext->input->absbit);
+	set_bit(ABS_RZ, ext->input->absbit);
+	input_set_abs_params(ext->input, ABS_RX, -500, 500, 2, 4);
+	input_set_abs_params(ext->input, ABS_RY, -500, 500, 2, 4);
+	input_set_abs_params(ext->input, ABS_RZ, -500, 500, 2, 4);
+
 	ret = input_register_device(ext->input);
 	if (ret) {
 		input_free_device(ext->input);
-- 
1.7.7.3


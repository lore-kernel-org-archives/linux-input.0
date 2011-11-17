From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 10/17] HID: wiimote: Parse motion+ data
Date: Thu, 17 Nov 2011 14:12:07 +0100
Message-ID: <1321535534-7950-11-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40756 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757509Ab1KQNNE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:13:04 -0500
Received: by eye27 with SMTP id 27so1873584eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:13:02 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

Motion+ reports rotation gyro data which we report to userspace as ABS_RX/Y/Z
values. The device reports them either in fast or slow mode. We adjust the
values to get a linear scale so userspace does not need to know about slow and
fast mode.

The motion+ also reports whether an extension is connected to it. We keep track
of this value and reinitialize the extensions if an extension is plugged or
unplugged.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-ext.c |   70 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index ecc7b7b..ceec0ce 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -25,6 +25,7 @@ struct wiimote_ext {
 	atomic_t opened;
 	atomic_t mp_opened;
 	bool plugged;
+	bool mp_plugged;
 	bool motionp;
 	__u8 ext_type;
 };
@@ -182,6 +183,10 @@ void wiiext_event(struct wiimote_data *wdata, bool plugged)
 		return;
 
 	wdata->ext->plugged = plugged;
+
+	if (!plugged)
+		wdata->ext->mp_plugged = false;
+
 	/*
 	 * We need to call wiiext_schedule(wdata->ext) here, however, the
 	 * extension initialization logic is not fully understood and so
@@ -206,6 +211,63 @@ bool wiiext_active(struct wiimote_data *wdata)
 
 static void handler_motionp(struct wiimote_ext *ext, const __u8 *payload)
 {
+	__s32 x, y, z;
+	bool plugged;
+
+	/*        |   8    7    6    5    4    3 |  2  |  1  |
+	 *   -----+------------------------------+-----+-----+
+	 *    1   |               Yaw Speed <7:0>            |
+	 *    2   |              Roll Speed <7:0>            |
+	 *    3   |             Pitch Speed <7:0>            |
+	 *   -----+------------------------------+-----+-----+
+	 *    4   |       Yaw Speed <13:8>       | Yaw |Pitch|
+	 *   -----+------------------------------+-----+-----+
+	 *    5   |      Roll Speed <13:8>       |Roll | Ext |
+	 *   -----+------------------------------+-----+-----+
+	 *    6   |     Pitch Speed <13:8>       |  1  |  0  |
+	 *   -----+------------------------------+-----+-----+
+	 * The single bits Yaw, Roll, Pitch in the lower right corner specify
+	 * whether the wiimote is rotating fast (0) or slow (1). Speed for slow
+	 * roation is 440 deg/s and for fast rotation 2000 deg/s. To get a
+	 * linear scale we multiply by 2000/440 = ~4.5454 which is 18 for fast
+	 * and 9 for slow.
+	 * If the wiimote is not rotating the sensor reports 2^13 = 8192.
+	 * Ext specifies whether an extension is connected to the motionp.
+	 */
+
+	x = payload[0];
+	y = payload[1];
+	z = payload[2];
+
+	x |= (((__u16)payload[3]) << 6) & 0xff00;
+	y |= (((__u16)payload[4]) << 6) & 0xff00;
+	z |= (((__u16)payload[5]) << 6) & 0xff00;
+
+	x -= 8192;
+	y -= 8192;
+	z -= 8192;
+
+	if (!(payload[3] & 0x02))
+		x *= 18;
+	else
+		x *= 9;
+	if (!(payload[4] & 0x02))
+		y *= 18;
+	else
+		y *= 9;
+	if (!(payload[3] & 0x01))
+		z *= 18;
+	else
+		z *= 9;
+
+	input_report_abs(ext->mp_input, ABS_RX, x);
+	input_report_abs(ext->mp_input, ABS_RY, y);
+	input_report_abs(ext->mp_input, ABS_RZ, z);
+	input_sync(ext->mp_input);
+
+	plugged = payload[5] & 0x01;
+	if (plugged != ext->mp_plugged)
+		ext->mp_plugged = plugged;
 }
 
 static void handler_nunchuck(struct wiimote_ext *ext, const __u8 *payload)
@@ -368,6 +430,14 @@ int wiiext_init(struct wiimote_data *wdata)
 	ext->mp_input->id.version = wdata->hdev->version;
 	ext->mp_input->name = WIIMOTE_NAME " Motion+";
 
+	set_bit(EV_ABS, ext->mp_input->evbit);
+	set_bit(ABS_RX, ext->mp_input->absbit);
+	set_bit(ABS_RY, ext->mp_input->absbit);
+	set_bit(ABS_RZ, ext->mp_input->absbit);
+	input_set_abs_params(ext->mp_input, ABS_RX, -160000, 160000, 4, 8);
+	input_set_abs_params(ext->mp_input, ABS_RY, -160000, 160000, 4, 8);
+	input_set_abs_params(ext->mp_input, ABS_RZ, -160000, 160000, 4, 8);
+
 	ret = input_register_device(ext->mp_input);
 	if (ret) {
 		input_free_device(ext->mp_input);
-- 
1.7.7.3


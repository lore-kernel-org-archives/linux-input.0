From: Rafael Brune <mail@rbrune.de>
Subject: [PATCH 1/1] HID: wiimote: invert Y-Axis and add automatic calibration for Wii U Pro Controller
Date: Sun,  6 Oct 2013 20:44:56 +0200
Message-ID: <1381085096-4511-1-git-send-email-mail@rbrune.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tyrell.rbrune.de ([83.169.16.173]:36178 "EHLO tyrell.rbrune.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104Ab3JFSxD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 6 Oct 2013 14:53:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Rafael Brune <mail@rbrune.de>

With these changes the Wii U Pro Controller fully complies
to the gamepad-API and with the calibration is fully usable
out-of-the-box without any user-space tools. This potentially
breaks compatibility with software that relies on the two
inverted Y-Axis but since current bluez 4.x and 5.x versions
don't even support pairing with the controller yet the amount
of people affected should be rather small.

Signed-off-by: Rafael Brune <mail@rbrune.de>
---
 drivers/hid/hid-wiimote-modules.c | 45 +++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 2e7d644..1422b0b 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1640,10 +1640,41 @@ static void wiimod_pro_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 	ly = (ext[4] & 0xff) | ((ext[5] & 0x0f) << 8);
 	ry = (ext[6] & 0xff) | ((ext[7] & 0x0f) << 8);
 
-	input_report_abs(wdata->extension.input, ABS_X, lx - 0x800);
-	input_report_abs(wdata->extension.input, ABS_Y, ly - 0x800);
-	input_report_abs(wdata->extension.input, ABS_RX, rx - 0x800);
-	input_report_abs(wdata->extension.input, ABS_RY, ry - 0x800);
+	/* Calibrating the sticks by saving the global min/max per axis */
+	if (lx < wdata->state.calib_bboard[0][0])
+		wdata->state.calib_bboard[0][0] = lx;
+	if (lx > wdata->state.calib_bboard[0][1])
+		wdata->state.calib_bboard[0][1] = lx;
+
+	if (ly < wdata->state.calib_bboard[1][0])
+		wdata->state.calib_bboard[1][0] = ly;
+	if (ly > wdata->state.calib_bboard[1][1])
+		wdata->state.calib_bboard[1][1] = ly;
+
+	if (rx < wdata->state.calib_bboard[2][0])
+		wdata->state.calib_bboard[2][0] = rx;
+	if (rx > wdata->state.calib_bboard[2][1])
+		wdata->state.calib_bboard[2][1] = rx;
+
+	if (ry < wdata->state.calib_bboard[3][0])
+		wdata->state.calib_bboard[3][0] = ry;
+	if (ry > wdata->state.calib_bboard[3][1])
+		wdata->state.calib_bboard[3][1] = ry;
+
+	/* Normalize using int math to prevent conversion to/from float */
+	lx = -2048 + (((__s32)(lx - wdata->state.calib_bboard[0][0]) * 4096)/
+	   (wdata->state.calib_bboard[0][1]-wdata->state.calib_bboard[0][0]));
+	ly = -2048 + (((__s32)(ly - wdata->state.calib_bboard[1][0]) * 4096)/
+	   (wdata->state.calib_bboard[1][1]-wdata->state.calib_bboard[1][0]));
+	rx = -2048 + (((__s32)(rx - wdata->state.calib_bboard[2][0]) * 4096)/
+	   (wdata->state.calib_bboard[2][1]-wdata->state.calib_bboard[2][0]));
+	ry = -2048 + (((__s32)(ry - wdata->state.calib_bboard[3][0]) * 4096)/
+	   (wdata->state.calib_bboard[3][1]-wdata->state.calib_bboard[3][0]));
+
+	input_report_abs(wdata->extension.input, ABS_X,  lx);
+	input_report_abs(wdata->extension.input, ABS_Y, -ly);
+	input_report_abs(wdata->extension.input, ABS_RX,  rx);
+	input_report_abs(wdata->extension.input, ABS_RY, -ry);
 
 	input_report_key(wdata->extension.input,
 			 wiimod_pro_map[WIIMOD_PRO_KEY_RIGHT],
@@ -1760,6 +1791,12 @@ static int wiimod_pro_probe(const struct wiimod_ops *ops,
 	if (!wdata->extension.input)
 		return -ENOMEM;
 
+	/* Initialize min/max values for all Axis with reasonable values */
+	for (i = 0; i < 4; ++i) {
+		wdata->state.calib_bboard[i][0] = 0x780;
+		wdata->state.calib_bboard[i][1] = 0x880;
+	}
+
 	set_bit(FF_RUMBLE, wdata->extension.input->ffbit);
 	input_set_drvdata(wdata->extension.input, wdata);
 
-- 
1.8.3.2


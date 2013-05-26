From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 29/26] HID: wiimote: fix classic controller parsing
Date: Sun, 26 May 2013 22:55:04 +0200
Message-ID: <1369601704-2311-3-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
 <1369601704-2311-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:39907 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab3EZU4F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 May 2013 16:56:05 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so2713939bkc.32
        for <linux-input@vger.kernel.org>; Sun, 26 May 2013 13:56:03 -0700 (PDT)
In-Reply-To: <1369601704-2311-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

I finally got a "Classic Controller" and "Classic Controller Pro" in my
hands and noticed that all analog data was incorrectly parsed. Fix this
up so we report the data that we pretend we do.

I really doubt that this breaks any backwards compatibility, but if we
get any reports, we only need to revert this single patch.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-modules.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 25483aa..c7a2c6b 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1062,12 +1062,12 @@ static void wiimod_classic_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 	 * With motionp enabled it changes slightly to this:
 	 *   Byte |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
 	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
-	 *    1   | RX <4:3>  |          LX <5:1>           | BDU |
-	 *    2   | RX <2:1>  |          LY <5:1>           | BDL |
+	 *    1   | RX <5:4>  |          LX <5:1>           | BDU |
+	 *    2   | RX <3:2>  |          LY <5:1>           | BDL |
 	 *   -----+-----+-----+-----+-----------------------+-----+
-	 *    3   |RX<0>| LT <4:3>  |         RY <4:0>            |
+	 *    3   |RX<1>| LT <5:4>  |         RY <5:1>            |
 	 *   -----+-----+-----------+-----------------------------+
-	 *    4   |     LT <2:0>    |         RT <4:0>            |
+	 *    4   |     LT <3:1>    |         RT <5:1>            |
 	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
 	 *    5   | BDR | BDD | BLT | B-  | BH  | B+  | BRT | EXT |
 	 *   -----+-----+-----+-----+-----+-----+-----+-----+-----+
@@ -1079,13 +1079,13 @@ static void wiimod_classic_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 
 	if (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE) {
 		lx = ext[0] & 0x3e;
-		ly = ext[0] & 0x3e;
+		ly = ext[1] & 0x3e;
 	} else {
 		lx = ext[0] & 0x3f;
-		ly = ext[0] & 0x3f;
+		ly = ext[1] & 0x3f;
 	}
 
-	rx = (ext[0] >> 3) & 0x14;
+	rx = (ext[0] >> 3) & 0x18;
 	rx |= (ext[1] >> 5) & 0x06;
 	rx |= (ext[2] >> 7) & 0x01;
 	ry = ext[2] & 0x1f;
@@ -1103,8 +1103,8 @@ static void wiimod_classic_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 	input_report_abs(wdata->extension.input, ABS_HAT1Y, ly - 0x20);
 	input_report_abs(wdata->extension.input, ABS_HAT2X, rx - 0x20);
 	input_report_abs(wdata->extension.input, ABS_HAT2Y, ry - 0x20);
-	input_report_abs(wdata->extension.input, ABS_HAT3X, rt - 0x20);
-	input_report_abs(wdata->extension.input, ABS_HAT3Y, lt - 0x20);
+	input_report_abs(wdata->extension.input, ABS_HAT3X, rt);
+	input_report_abs(wdata->extension.input, ABS_HAT3Y, lt);
 
 	input_report_key(wdata->extension.input,
 			 wiimod_classic_map[WIIMOD_CLASSIC_KEY_RIGHT],
-- 
1.8.2.3


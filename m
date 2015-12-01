From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 6/7] HID: wacom: Clean up value reading
Date: Mon, 30 Nov 2015 17:13:51 -0800
Message-ID: <1448932432-10115-6-git-send-email-killertofu@gmail.com>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34932 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbbLABN7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 20:13:59 -0500
Received: by pacej9 with SMTP id ej9so202497067pac.2
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2015 17:13:59 -0800 (PST)
In-Reply-To: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Make the logic for reading X, Y, distance, and pressure a bit more
clear. An additional bit was stuffed into the packet format many
models back, and /most/ devices in use will use it. If we happen
to be dealing with a particularly old tablet, just shift it off
the end to pretend we never read it.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index ce3afab..0008650 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -887,21 +887,23 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int idx = (features->type == INTUOS) ? (data[1] & 0x01) : 0;
 	unsigned char type = (data[1] >> 1) & 0x0F;
-	unsigned int t;
+	unsigned int x, y, distance, t;
 
 	if (data[0] != WACOM_REPORT_PENABLED && data[0] != WACOM_REPORT_CINTIQ &&
 		data[0] != WACOM_REPORT_INTUOS_PEN)
 		return 0;
 
-	if (features->type >= INTUOS3S) {
-		input_report_abs(input, ABS_X, (data[2] << 9) | (data[3] << 1) | ((data[9] >> 1) & 1));
-		input_report_abs(input, ABS_Y, (data[4] << 9) | (data[5] << 1) | (data[9] & 1));
-		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 2) & 0x3f));
-	} else {
-		input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[2]));
-		input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[4]));
-		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 3) & 0x1f));
+	x = (be16_to_cpup((__be16 *)&data[2]) << 1) | ((data[9] >> 1) & 1);
+	y = (be16_to_cpup((__be16 *)&data[4]) << 1) | (data[9] & 1);
+	distance = data[9] >> 2;
+	if (features->type < INTUOS3S) {
+		x >>= 1;
+		y >>= 1;
+		distance >>= 1;
 	}
+	input_report_abs(input, ABS_X, x);
+	input_report_abs(input, ABS_Y, y);
+	input_report_abs(input, ABS_DISTANCE, distance);
 
 	switch (type) {
 	case 0x00:
@@ -909,10 +911,9 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 	case 0x02:
 	case 0x03:
 		/* general pen packet */
-		t = (data[6] << 2) | ((data[7] >> 6) & 3);
-		if (features->pressure_max == 2047) {
-			t = (t << 1) | (data[1] & 1);
-		}
+		t = (data[6] << 3) | ((data[7] & 0xC0) >> 5) | (data[1] & 1);
+		if (features->pressure_max < 2047)
+			t >>= 1;
 		input_report_abs(input, ABS_PRESSURE, t);
 		if (features->type != INTUOSHT2) {
 		    input_report_abs(input, ABS_TILT_X,
-- 
2.6.2


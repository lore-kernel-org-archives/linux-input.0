From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input: wacom - report hardware provided MT_TRACKING_IDs
Date: Sat, 30 Oct 2010 21:00:26 -0700
Message-ID: <1288497626-25416-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53768 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab0JaEAT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Oct 2010 00:00:19 -0400
Received: by gyg4 with SMTP id 4so2635444gyg.19
        for <linux-input@vger.kernel.org>; Sat, 30 Oct 2010 21:00:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

The "Multi-touch (MT) Protocol" says:

"The slot protocol requires the use of the ABS_MT_TRACKING_ID, either
provided by the hardware or computed from the raw data".

We get the IDs from Bamboo touch device. Let's use them instead of
compute our own.

Signed-off-by: Ping Cheng <pingc@wacom.com>

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index b3252ef..76d4980 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -885,7 +885,7 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
 			if (wacom->id[i] < 0)
-				wacom->id[i] = wacom->trk_id++ & MAX_TRACKING_ID;
+				wacom->id[i] = i;
 			if (!count++)
 				sp = p, sx = x, sy = y;
 		} else {
@@ -1283,7 +1283,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 					     0, features->pressure_max,
 					     features->pressure_fuzz, 0);
 			input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0,
-					     MAX_TRACKING_ID, 0, 0);
+					     1, 0, 0);
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 00ca015..b1310ec 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -42,9 +42,6 @@
 #define WACOM_QUIRK_MULTI_INPUT		0x0001
 #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0002
 
-/* largest reported tracking id */
-#define MAX_TRACKING_ID			0xfff
-
 enum {
 	PENPARTNER = 0,
 	GRAPHIRE,
@@ -100,7 +97,6 @@ struct wacom_wac {
 	int id[3];
 	__u32 serial[2];
 	int last_finger;
-	int trk_id;
 	struct wacom_features features;
 	struct wacom_shared *shared;
 	struct input_dev *input;

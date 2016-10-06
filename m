From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 11/19] HID: wacom: Read and internally use corrected Intuos tool IDs
Date: Thu,  6 Oct 2016 14:22:23 -0700
Message-ID: <20161006212231.31440-12-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33936 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935088AbcJFVW6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:22:58 -0400
Received: by mail-qt0-f194.google.com with SMTP id f6so835545qtd.1
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:22:58 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

The 'wacom_intuos_inout' function incorrectly assmebles tool IDs from the
proximity report, shifting the higher values of the ID four bits farther
than intended. This problem was not detected until too late, but has not
caused any issues since the incorrect IDs still fit in a 32-bit integer
and userspace programs have not required the value to match the hardware
(just that the values are unique and constant).

The tool IDs reported by the new MobileStudio Pro (or any future
HID_GENERIC device that supports them) do not suffer from the same
assembly issue, however. In order for 'wacom_intuos_get_tool_type' to
work for with both codepaths, we correct this issue internally and
have 'wacom_intuos_general' only mangle the ID when it is posted to
userspace.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0e8c99a..60f065b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -588,6 +588,11 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	return 1;
 }
 
+static int wacom_intuos_id_mangle(int tool_id)
+{
+	return (tool_id & ~0xFFF) << 4 | (tool_id & 0xFFF);
+}
+
 static int wacom_intuos_get_tool_type(int tool_id)
 {
 	int tool_type;
@@ -595,7 +600,7 @@ static int wacom_intuos_get_tool_type(int tool_id)
 	switch (tool_id) {
 	case 0x812: /* Inking pen */
 	case 0x801: /* Intuos3 Inking pen */
-	case 0x120802: /* Intuos4/5 Inking Pen */
+	case 0x12802: /* Intuos4/5 Inking Pen */
 	case 0x012:
 		tool_type = BTN_TOOL_PENCIL;
 		break;
@@ -610,11 +615,11 @@ static int wacom_intuos_get_tool_type(int tool_id)
 	case 0x804: /* Intuos4/5 13HD/24HD Marker Pen */
 	case 0x8e2: /* IntuosHT2 pen */
 	case 0x022:
-	case 0x100804: /* Intuos4/5 13HD/24HD Art Pen */
-	case 0x140802: /* Intuos4/5 13HD/24HD Classic Pen */
-	case 0x160802: /* Cintiq 13HD Pro Pen */
-	case 0x180802: /* DTH2242 Pen */
-	case 0x100802: /* Intuos4/5 13HD/24HD General Pen */
+	case 0x10804: /* Intuos4/5 13HD/24HD Art Pen */
+	case 0x14802: /* Intuos4/5 13HD/24HD Classic Pen */
+	case 0x16802: /* Cintiq 13HD Pro Pen */
+	case 0x18802: /* DTH2242 Pen */
+	case 0x10802: /* Intuos4/5 13HD/24HD General Pen */
 		tool_type = BTN_TOOL_PEN;
 		break;
 
@@ -648,12 +653,12 @@ static int wacom_intuos_get_tool_type(int tool_id)
 	case 0x80c: /* Intuos4/5 13HD/24HD Marker Pen Eraser */
 	case 0x80a: /* Intuos4/5 13HD/24HD General Pen Eraser */
 	case 0x90a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
-	case 0x14080a: /* Intuos4/5 13HD/24HD Classic Pen Eraser */
-	case 0x10090a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
-	case 0x10080c: /* Intuos4/5 13HD/24HD Art Pen Eraser */
-	case 0x16080a: /* Cintiq 13HD Pro Pen Eraser */
-	case 0x18080a: /* DTH2242 Eraser */
-	case 0x10080a: /* Intuos4/5 13HD/24HD General Pen Eraser */
+	case 0x1480a: /* Intuos4/5 13HD/24HD Classic Pen Eraser */
+	case 0x1090a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
+	case 0x1080c: /* Intuos4/5 13HD/24HD Art Pen Eraser */
+	case 0x1680a: /* Cintiq 13HD Pro Pen Eraser */
+	case 0x1880a: /* DTH2242 Eraser */
+	case 0x1080a: /* Intuos4/5 13HD/24HD General Pen Eraser */
 		tool_type = BTN_TOOL_RUBBER;
 		break;
 
@@ -662,7 +667,7 @@ static int wacom_intuos_get_tool_type(int tool_id)
 	case 0x112:
 	case 0x913: /* Intuos3 Airbrush */
 	case 0x902: /* Intuos4/5 13HD/24HD Airbrush */
-	case 0x100902: /* Intuos4/5 13HD/24HD Airbrush */
+	case 0x10902: /* Intuos4/5 13HD/24HD Airbrush */
 		tool_type = BTN_TOOL_AIRBRUSH;
 		break;
 
@@ -693,7 +698,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 			(data[6] << 4) + (data[7] >> 4);
 
 		wacom->id[idx] = (data[2] << 4) | (data[3] >> 4) |
-			((data[7] & 0x0f) << 20) | ((data[8] & 0xf0) << 12);
+		     ((data[7] & 0x0f) << 16) | ((data[8] & 0xf0) << 8);
 
 		wacom->tool[idx] = wacom_intuos_get_tool_type(wacom->id[idx]);
 
@@ -923,7 +928,7 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 	 * don't report events for invalid data
 	 */
 	/* older I4 styli don't work with new Cintiqs */
-	if ((!((wacom->id[idx] >> 20) & 0x01) &&
+	if ((!((wacom->id[idx] >> 16) & 0x01) &&
 			(features->type == WACOM_21UX2)) ||
 	    /* Only large Intuos support Lense Cursor */
 	    (wacom->tool[idx] == BTN_TOOL_LENS &&
@@ -1059,7 +1064,8 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		break;
 	}
 
-	input_report_abs(input, ABS_MISC, wacom->id[idx]); /* report tool id */
+	input_report_abs(input, ABS_MISC,
+			 wacom_intuos_id_mangle(wacom->id[idx])); /* report tool id */
 	input_report_key(input, wacom->tool[idx], 1);
 	input_event(input, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
 	wacom->reporting_data = true;
-- 
2.10.0


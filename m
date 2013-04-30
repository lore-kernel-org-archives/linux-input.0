From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] input : wacom - add a few new styli for Cintiq series
Date: Tue, 30 Apr 2013 15:22:17 -0700
Message-ID: <1367360537-30215-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:60610 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933606Ab3D3WWe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Apr 2013 18:22:34 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so436233dae.17
        for <linux-input@vger.kernel.org>; Tue, 30 Apr 2013 15:22:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Add new styli for Cintiq 13HD and 22HD. Update comments for
for tools. Check whole 10 nibbles of tool ID for tool
types. Remove unuecessary tool type for Intuos series PAD.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 3.7/wacom_wac.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/3.7/wacom_wac.c b/3.7/wacom_wac.c
index afe4fe0..3b6998a 100644
--- a/3.7/wacom_wac.c
+++ b/3.7/wacom_wac.c
@@ -342,10 +342,10 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		wacom->id[idx] = (data[2] << 4) | (data[3] >> 4) |
 			((data[7] & 0x0f) << 20) | ((data[8] & 0xf0) << 12);
 
-		switch (wacom->id[idx] & 0xfffff) {
+		switch (wacom->id[idx]) {
 		case 0x812: /* Inking pen */
 		case 0x801: /* Intuos3 Inking pen */
-		case 0x20802: /* Intuos4 Inking Pen */
+		case 0x120802: /* Intuos4/5 Inking Pen */
 		case 0x012:
 			wacom->tool[idx] = BTN_TOOL_PENCIL;
 			break;
@@ -356,11 +356,13 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x823: /* Intuos3 Grip Pen */
 		case 0x813: /* Intuos3 Classic Pen */
 		case 0x885: /* Intuos3 Marker Pen */
-		case 0x802: /* Intuos4 General Pen */
-		case 0x804: /* Intuos4 Marker Pen */
-		case 0x40802: /* Intuos4 Classic Pen */
-		case 0x18802: /* DTH2242 Grip Pen */
+		case 0x802: /* Intuos4/5 13HD/24HD General Pen */
+		case 0x804: /* Intuos4/5 13HD/24HD Marker Pen */
 		case 0x022:
+		case 0x100804: /* Intuos4/5 13HD/24HD Art Pen */
+		case 0x140802: /* Intuos4/5 13HD/24HD Classic Pen */
+		case 0x160802: /* Cintiq 13HD Pro Pen */
+		case 0x180802: /* DTH2242 Grip Pen */
 			wacom->tool[idx] = BTN_TOOL_PEN;
 			break;
 
@@ -391,10 +393,13 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x82b: /* Intuos3 Grip Pen Eraser */
 		case 0x81b: /* Intuos3 Classic Pen Eraser */
 		case 0x91b: /* Intuos3 Airbrush Eraser */
-		case 0x80c: /* Intuos4 Marker Pen Eraser */
-		case 0x80a: /* Intuos4 General Pen Eraser */
-		case 0x4080a: /* Intuos4 Classic Pen Eraser */
-		case 0x90a: /* Intuos4 Airbrush Eraser */
+		case 0x80c: /* Intuos4/5 13HD/24HD Marker Pen Eraser */
+		case 0x80a: /* Intuos4/5 13HD/24HD General Pen Eraser */
+		case 0x90a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
+		case 0x14080a: /* Intuos4/5 13HD/24HD Classic Pen Eraser */
+		case 0x10090a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
+		case 0x10080c: /* Intuos4/5 13HD/24HD Art Pen Eraser */
+		case 0x16080a: /* Cintiq 13HD Pro Pen Eraser */
 			wacom->tool[idx] = BTN_TOOL_RUBBER;
 			break;
 
@@ -402,7 +407,8 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x912:
 		case 0x112:
 		case 0x913: /* Intuos3 Airbrush */
-		case 0x902: /* Intuos4 Airbrush */
+		case 0x902: /* Intuos4/5 13HD/24HD Airbrush */
+		case 0x100902: /* Intuos4/5 13HD/24HD Airbrush */
 			wacom->tool[idx] = BTN_TOOL_AIRBRUSH;
 			break;
 
@@ -533,10 +539,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				input_report_key(input, BTN_8, (data[3] & 0x80));
 			}
 			if (data[1] | (data[2] & 0x01) | data[3]) {
-				input_report_key(input, wacom->tool[1], 1);
 				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
 			} else {
-				input_report_key(input, wacom->tool[1], 0);
 				input_report_abs(input, ABS_MISC, 0);
 			}
 		} else if (features->type == DTK) {
@@ -600,10 +604,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			}
 
 			if (data[1] | data[2] | (data[3] & 0x1f) | data[4] | data[6] | data[8]) {
-				input_report_key(input, wacom->tool[1], 1);
 				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
 			} else {
-				input_report_key(input, wacom->tool[1], 0);
 				input_report_abs(input, ABS_MISC, 0);
 			}
 		} else if (features->type >= INTUOS5S && features->type <= INTUOS5L) {
@@ -628,10 +630,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			}
 
 			if (data[2] | (data[3] & 0x01) | data[4] | data[5]) {
-				input_report_key(input, wacom->tool[1], 1);
 				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
 			} else {
-				input_report_key(input, wacom->tool[1], 0);
 				input_report_abs(input, ABS_MISC, 0);
 			}
 		} else {
@@ -678,10 +678,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			if ((data[5] & 0x1f) | data[6] | (data[1] & 0x1f) |
 				data[2] | (data[3] & 0x1f) | data[4] | data[8] |
 				(data[7] & 0x01)) {
-				input_report_key(input, wacom->tool[1], 1);
 				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
 			} else {
-				input_report_key(input, wacom->tool[1], 0);
 				input_report_abs(input, ABS_MISC, 0);
 			}
 		}
-- 
1.7.10.4


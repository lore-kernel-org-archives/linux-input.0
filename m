From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 2/4] input: wacom: Intuos5 Touch Ring/ExpressKey support
Date: Tue,  3 Apr 2012 14:49:00 -0700
Message-ID: <1333489742-29901-2-git-send-email-killertofu@gmail.com>
References: <1333489742-29901-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51439 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab2DCVtN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 17:49:13 -0400
Received: by mail-ob0-f174.google.com with SMTP id tb18so233630obb.19
        for <linux-input@vger.kernel.org>; Tue, 03 Apr 2012 14:49:13 -0700 (PDT)
In-Reply-To: <1333489742-29901-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com, tjaalton@ubuntu.com
Cc: Jason Gerecke <killertofu@gmail.com>

Intuos5 uses a new report type for Touch Ring and ExpressKey data.
Note that data from the capacitive sensors present on the ExpressKeys
will be ignored until a proper way is found to expose it.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
Reviewed-by: Ping Cheng <pingc@wacom.com>
---
No changes to patch; added signed-off-by and other tags.

 drivers/input/tablet/wacom_wac.c |   33 +++++++++++++++++++++++++++++++--
 drivers/input/tablet/wacom_wac.h |    1 +
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 35efc64..86827c7 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -484,7 +484,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	int idx = 0, result;
 
 	if (data[0] != WACOM_REPORT_PENABLED && data[0] != WACOM_REPORT_INTUOSREAD
-		&& data[0] != WACOM_REPORT_INTUOSWRITE && data[0] != WACOM_REPORT_INTUOSPAD) {
+		&& data[0] != WACOM_REPORT_INTUOSWRITE && data[0] != WACOM_REPORT_INTUOSPAD
+                && data[0] != WACOM_REPORT_INTUOS5PAD) {
 		dbg("wacom_intuos_irq: received unknown report #%d", data[0]);
                 return 0;
 	}
@@ -494,7 +495,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 		idx = data[1] & 0x01;
 
 	/* pad packets. Works as a second tool and is always in prox */
-	if (data[0] == WACOM_REPORT_INTUOSPAD) {
+	if (data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD) {
 		if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
 			input_report_key(input, BTN_0, (data[2] & 0x01));
 			input_report_key(input, BTN_1, (data[3] & 0x01));
@@ -570,6 +571,34 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				input_report_key(input, wacom->tool[1], 0);
 				input_report_abs(input, ABS_MISC, 0);
 			}
+		} else if (features->type >= INTUOS5S && features->type <= INTUOS5L) {
+			int i;
+
+			/* Touch ring mode switch has no capacitive sensor */
+			input_report_key(input, BTN_0, (data[3] & 0x01));
+
+			/* ExpressKeys on Intuos5 have a capacitive sensor in
+			 * addition to the mechanical switch. Switch data is
+			 * stored in data[4], capacitive data in data[5].
+			 */
+			for (i = 0; i < 8; i++) {
+				input_report_key(input, BTN_1 + i, data[4] & (1 << i));
+			}
+
+			if (data[2] & 0x80) {
+				input_report_abs(input, ABS_WHEEL, (data[2] & 0x7f));
+			} else {
+				/* Out of proximity, clear wheel value. */
+				input_report_abs(input, ABS_WHEEL, 0);
+			}
+
+			if (data[2] | (data[3] & 0x01) | data[4]) {
+				input_report_key(input, wacom->tool[1], 1);
+				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+			} else {
+				input_report_key(input, wacom->tool[1], 0);
+				input_report_abs(input, ABS_MISC, 0);
+			}
 		} else {
 			if (features->type == WACOM_21UX2) {
 				input_report_key(input, BTN_0, (data[5] & 0x01));
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 5eb10c5..99efc10 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -37,6 +37,7 @@
 #define WACOM_REPORT_INTUOSREAD		5
 #define WACOM_REPORT_INTUOSWRITE	6
 #define WACOM_REPORT_INTUOSPAD		12
+#define WACOM_REPORT_INTUOS5PAD         3
 #define WACOM_REPORT_TPC1FG		6
 #define WACOM_REPORT_TPC2FG		13
 #define WACOM_REPORT_TPCHID		15
-- 
1.7.9.1


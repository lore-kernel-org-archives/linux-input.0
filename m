From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/2] HID: hid-input: Add digitizer tilt usage support
Date: Tue, 20 Mar 2012 16:01:32 +0200
Message-ID: <1332252093-13394-2-git-send-email-spbnick@gmail.com>
References: <1332252093-13394-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34178 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758036Ab2CTOBz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 10:01:55 -0400
Received: by lahj13 with SMTP id j13so53014lah.19
        for <linux-input@vger.kernel.org>; Tue, 20 Mar 2012 07:01:53 -0700 (PDT)
In-Reply-To: <1332252093-13394-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Add digitizer X Tilt and Y Tilt usage support along with resolution calculation.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-input.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index af0200f..c8f9965 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -225,7 +225,10 @@ static __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 	 * Verify and convert units.
 	 * See HID specification v1.11 6.2.2.7 Global Items for unit decoding
 	 */
-	if (code == ABS_X || code == ABS_Y || code == ABS_Z) {
+	switch (code) {
+	case ABS_X:
+	case ABS_Y:
+	case ABS_Z:
 		if (field->unit == 0x11) {		/* If centimeters */
 			/* Convert to millimeters */
 			unit_exponent += 1;
@@ -239,7 +242,13 @@ static __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 		} else {
 			return 0;
 		}
-	} else if (code == ABS_RX || code == ABS_RY || code == ABS_RZ) {
+		break;
+
+	case ABS_RX:
+	case ABS_RY:
+	case ABS_RZ:
+	case ABS_TILT_X:
+	case ABS_TILT_Y:
 		if (field->unit == 0x14) {		/* If degrees */
 			/* Convert to radians */
 			prev = logical_extents;
@@ -250,7 +259,9 @@ static __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 		} else if (field->unit != 0x12) {	/* If not radians */
 			return 0;
 		}
-	} else {
+		break;
+
+	default:
 		return 0;
 	}
 
@@ -623,6 +634,14 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			map_key_clear(BTN_TOOL_RUBBER);
 			break;
 
+		case 0x3d: /* X Tilt */
+			map_abs_clear(ABS_TILT_X);
+			break;
+
+		case 0x3e: /* Y Tilt */
+			map_abs_clear(ABS_TILT_Y);
+			break;
+
 		case 0x33: /* Touch */
 		case 0x42: /* TipSwitch */
 		case 0x43: /* TipSwitch2 */
-- 
1.7.9.1


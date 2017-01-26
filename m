From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Fix poor prox handling in 'wacom_pl_irq'
Date: Thu, 26 Jan 2017 09:06:22 -0800
Message-ID: <20170126170622.6760-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33942 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbdAZRGv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 12:06:51 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so16813988pfb.1
        for <linux-input@vger.kernel.org>; Thu, 26 Jan 2017 09:06:39 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit 025bcc1 performed cleanup work on the 'wacom_pl_irq' function, making
it follow the standards used in the rest of the codebase. The change
unintiontionally allowed the function to send input events from reports
that are not marked as being in prox. This can cause problems as the
report values for X, Y, etc. are not guaranteed to be correct. In
particular, occasionally the tablet will send a report with these values
set to zero. If such a report is received it can caus an unexpected jump
in the XY position.

This patch surrounds more of the processing code with a proximity check,
preventing these zeroed reports from overwriting the current state. To
be safe, only the tool type and ABS_MISC events should be reported when
the pen is marked as being out of prox.

Fixes: 025bcc1540 ("HID: wacom: Simplify 'wacom_pl_irq'")
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0884dc9554fd..672145b0d8f5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -166,19 +166,21 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 		wacom->id[0] = STYLUS_DEVICE_ID;
 	}
 
-	pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
-	if (features->pressure_max > 255)
-		pressure = (pressure << 1) | ((data[4] >> 6) & 1);
-	pressure += (features->pressure_max + 1) / 2;
-
-	input_report_abs(input, ABS_X, data[3] | (data[2] << 7) | ((data[1] & 0x03) << 14));
-	input_report_abs(input, ABS_Y, data[6] | (data[5] << 7) | ((data[4] & 0x03) << 14));
-	input_report_abs(input, ABS_PRESSURE, pressure);
-
-	input_report_key(input, BTN_TOUCH, data[4] & 0x08);
-	input_report_key(input, BTN_STYLUS, data[4] & 0x10);
-	/* Only allow the stylus2 button to be reported for the pen tool. */
-	input_report_key(input, BTN_STYLUS2, (wacom->tool[0] == BTN_TOOL_PEN) && (data[4] & 0x20));
+	if (prox) {
+		pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
+		if (features->pressure_max > 255)
+			pressure = (pressure << 1) | ((data[4] >> 6) & 1);
+		pressure += (features->pressure_max + 1) / 2;
+
+		input_report_abs(input, ABS_X, data[3] | (data[2] << 7) | ((data[1] & 0x03) << 14));
+		input_report_abs(input, ABS_Y, data[6] | (data[5] << 7) | ((data[4] & 0x03) << 14));
+		input_report_abs(input, ABS_PRESSURE, pressure);
+
+		input_report_key(input, BTN_TOUCH, data[4] & 0x08);
+		input_report_key(input, BTN_STYLUS, data[4] & 0x10);
+		/* Only allow the stylus2 button to be reported for the pen tool. */
+		input_report_key(input, BTN_STYLUS2, (wacom->tool[0] == BTN_TOOL_PEN) && (data[4] & 0x20));
+	}
 
 	if (!prox)
 		wacom->id[0] = 0;
-- 
2.11.0


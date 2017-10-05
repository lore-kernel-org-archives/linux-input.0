From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Revert "HID: wacom: generic: Send BTN_TOOL_PEN in prox once the pen enters range"
Date: Thu,  5 Oct 2017 11:14:02 -0700
Message-ID: <20171005181402.11149-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38677 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdJESOW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 14:14:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id 17so3534234qkq.5
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 11:14:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

This reverts commit 3e70969e44ee52d72053145dab2cbad74109c685.

This commit causes a few problems for userspace. The most noteworthy are
problems related to the distinguishing of different pens and pointer jumps
when entering proximity. Userspace is written with the expectation that a
pen will provide its tool ID and serial number (if available) in the very
first in-prox report. By sending BTN_TOOL_PEN when the tablet starts
communicating rather than waiting until a tool ID/serial number is
available, userspace ends up treating all pens as being the same and
lacking a serial number. Similarly, userspace assumes that the first
report will contain X/Y data, but by marking the pen as being in-prox
without an X/Y coordinate, userspace ends up warping the pen to the last-
known X/Y location. As of commit 5b40104edfb0 ("HID: wacom: generic: Reset
events back to zero when pen leaves") this means warping to (0,0).

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 2926e36cb684..e3223b0c4f90 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2247,17 +2247,6 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 			wacom_wac->tool[0] = wacom_intuos_get_tool_type(wacom_wac->id[0]);
 		else
 			wacom_wac->tool[0] = BTN_TOOL_PEN;
-
-		if (wacom_wac->shared->stylus_in_proximity &&
-		    wacom_wac->tool[0] != BTN_TOOL_PEN) {
-			input_report_key(input, BTN_TOOL_PEN, 0);
-			input_sync(input);
-		}
-	}
-	else if (!wacom_wac->tool[0] && !range) { /* entering in sense */
-		input_report_key(input, BTN_TOOL_PEN, sense);
-		input_report_key(input, BTN_TOUCH, 0);
-		input_sync(input);
 	}
 
 	/* keep pen state for touch events */
-- 
2.14.2


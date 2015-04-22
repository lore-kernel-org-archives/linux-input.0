From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] Input - synaptics: pin 3 touches when the firmware reports 3 fingers
Date: Wed, 22 Apr 2015 11:45:09 -0400
Message-ID: <1429717509-27396-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966049AbbDVPpQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2015 11:45:16 -0400
In-Reply-To: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Synaptics PS/2 touchpad can send only 2 touches in a report. They can
detect 4 or 5 and this information is valuable.

In commit 63c4fda3c0bb ("Input: synaptics - allocate 3 slots to keep
stability in image sensors"), we allocate 3 slots, but we still continue
to report the 2 available fingers. That means that the client sees 2 used
slots while there is a total of 3 fingers advertised by BTN_TOOL_TRIPLETAP.

For old kernels this is not a problem because max_slots was 2 and libinput/
xorg-synaptics knew how to deal with that. Now that max_slot is 3, the
clients ignore BTN_TOOL_TRIPLETAP and count the actual used slots (so 2).
It then gets confused when receiving the BTN_TOOL_TRIPLETAP and DOUBLETAP
information, and goes wild.

We can pin the 3 slots until we get a total number of fingers below 2.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1212230

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 630af73..c69b308 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -935,6 +935,14 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
 		input_report_abs(dev, ABS_MT_PRESSURE, hw[i]->z);
 	}
 
+	/* keep (slot count <= num_fingers) by pinning all slots */
+	if (num_fingers >= 3) {
+		for (i = 0; i < 3; i++) {
+			input_mt_slot(dev, i);
+			input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
+		}
+	}
+
 	input_mt_drop_unused(dev);
 
 	/* Don't use active slot count to generate BTN_TOOL events. */
-- 
2.1.0


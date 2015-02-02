From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input - synaptics: use dmax in input_mt_assign_slots
Date: Mon,  2 Feb 2015 14:15:58 -0500
Message-ID: <1422904558-30055-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46423 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932629AbbBBTQK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Feb 2015 14:16:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

When tapping a clickpad with two fingers, there is a chance that the
sensor sees first only one finger, and at the next scan only the
second one.
In this case, the sensors says that there has been only one finger
on the clickpad, which moved really fast between two scans.

We can try to counter this by adding a limit to what an actual finger
can move between 2 scans.
A distance of 1cm between two scans for one finger seems reasonable.

However, this is not really accurate because the resolution in X and in Y
differs. But heh, that's how the in-kernel tracking works right now, and
its job is quite good, even with this approximation.

This parameter solves most of the jumps observed, not all of them however.
But this is a hardware defect, and we might not be able to get something
better without much heavier computations.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=76722

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a3692e3..bee0387 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -67,6 +67,9 @@
 #define X_MAX_POSITIVE 8176
 #define Y_MAX_POSITIVE 8176
 
+/* maximum ABS_MT_POSITION displacement (in mm) */
+#define DMAX 10
+
 /*****************************************************************************
  *	Stuff we need even when we do not want native Synaptics support
  ****************************************************************************/
@@ -809,7 +812,7 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
 		pos[i].y = synaptics_invert_y(hw[i]->y);
 	}
 
-	input_mt_assign_slots(dev, slot, pos, nsemi, 0);
+	input_mt_assign_slots(dev, slot, pos, nsemi, DMAX * priv->x_res);
 
 	for (i = 0; i < nsemi; i++) {
 		input_mt_slot(dev, slot[i]);
-- 
2.1.0


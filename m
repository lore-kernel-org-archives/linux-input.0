From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/3] Revert "Revert "Input: synaptics - use dmax in input_mt_assign_slots""
Date: Mon, 30 Mar 2015 18:09:27 -0400
Message-ID: <1427753368-2795-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1427753368-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427753368-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This reverts commit 09d042a2eb90 ("Revert "Input: synaptics - use dmax in input_mt_assign_slots"")

Now that balanced slots assignments seem to be fixed, let's
reenable the use in synaptics.c and wait for users to complain
if there are still problems.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 1d3d11d..02a12b694 100644
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
@@ -922,7 +925,7 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
 		pos[i].y = synaptics_invert_y(hw[i]->y);
 	}
 
-	input_mt_assign_slots(dev, slot, pos, nsemi, 0);
+	input_mt_assign_slots(dev, slot, pos, nsemi, DMAX * priv->x_res);
 
 	for (i = 0; i < nsemi; i++) {
 		input_mt_slot(dev, slot[i]);
-- 
2.3.4

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input: elantech - mark protocols v2 and v3 as semi-mt
Date: Mon, 11 Jan 2016 11:09:00 +0100
Message-ID: <1452506940-26659-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758650AbcAKKJE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2016 05:09:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

When using a protocol v2 or v3 hardware, elantech uses the function
elantech_report_semi_mt_data() to report data. This devices are rather
creepy because if num_finger is 3, (x2,y2) is (0,0). Yes, only one valid
touch is reported.

Anyway, userspace (libinput) is now confused by these (0,0) touches,
and detect them as palm, and rejects them.

Commit 3c0213d17a09 ("Input: elantech - fix semi-mt protocol for v3 HW")
was sufficient enough for xf86-input-synaptics and libinput before it has
palm rejection. Now we need to actually tell libinput that this device is
a semi-mt one and it should not rely on the actual values of the 2 touches.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 537ebb0..78f93cf 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1222,7 +1222,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 			input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
 					     ETP_WMAX_V2, 0, 0);
 		}
-		input_mt_init_slots(dev, 2, 0);
+		input_mt_init_slots(dev, 2, INPUT_MT_SEMI_MT);
 		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
 		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
 		break;
-- 
2.5.0


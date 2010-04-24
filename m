From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH 3/4] Input: elantech - Ignore high bits in the position coordinates
Date: Sat, 24 Apr 2010 22:41:01 +0200
Message-ID: <1272141662-23431-4-git-send-email-rafl@debian.org>
References: <1272141662-23431-1-git-send-email-rafl@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:54449 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab0DXV0h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 17:26:37 -0400
In-Reply-To: <1272141662-23431-1-git-send-email-rafl@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Florian Ragwitz <rafl@debian.org>

In older versions of the elantech hardware/firmware those bits always were
unset, so it didn't actually matter, but newer versions seem to use those high
bits for something else, screwing up the coordinates we report to the input
layer for those devices.

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 drivers/input/mouse/elantech.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index bfd08c7..254a967 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -251,13 +251,13 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 
 	switch (fingers) {
 	case 1:
-		/* byte 1: x15 x14 x13 x12 x11 x10 x9  x8
+		/* byte 1:  .   .   .   .   .  x10 x9  x8
 		   byte 2: x7  x6  x5  x4  x4  x2  x1  x0 */
-		input_report_abs(dev, ABS_X, (packet[1] << 8) | packet[2]);
-		/* byte 4: y15 y14 y13 y12 y11 y10 y8  y8
+		input_report_abs(dev, ABS_X, ((packet[1] & 0x07) << 8) | packet[2]);
+		/* byte 4:  .   .   .   .   .   .  y8  y8
 		   byte 5: y7  y6  y5  y4  y3  y2  y1  y0 */
 		input_report_abs(dev, ABS_Y, ETP_YMAX_V2 -
-			((packet[4] << 8) | packet[5]));
+			(((packet[4] & 0x03) << 8) | packet[5]));
 		break;
 
 	case 2:
-- 
1.7.0.5


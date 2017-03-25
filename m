From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH 2/3] Input: synaptics-rmi4 - change F12 clip to inactive border debug
Date: Sat, 25 Mar 2017 00:58:59 +0000
Message-ID: <1490403540-31425-3-git-send-email-nick@shmanahar.org>
References: <1490403540-31425-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:54883 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754414AbdCYBGz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 21:06:55 -0400
In-Reply-To: <1490403540-31425-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick@shmanahar.org>

The data in F12_2D_Ctrl8 corresponds to the inactive border width used by the
RMI device. It is not in pixel units and should not be treated as a clip value.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_f12.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 07aff43..8b0db08 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -113,20 +113,16 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	}
 
 	if (rmi_register_desc_has_subpacket(item, 2)) {
-		sensor->axis_align.clip_x_low = buf[offset];
-		sensor->axis_align.clip_x_high = sensor->max_x
-							- buf[offset + 1];
-		sensor->axis_align.clip_y_low = buf[offset + 2];
-		sensor->axis_align.clip_y_high = sensor->max_y
-							- buf[offset + 3];
+		/* Units 1/128 sensor pitch */
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+			"%s: Inactive Border xlo:%d xhi:%d ylo:%d yhi:%d\n",
+			__func__,
+			buf[offset], buf[offset + 1],
+			buf[offset + 2], buf[offset + 3]);
+
 		offset += 4;
 	}
 
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: x low: %d x high: %d y low: %d y high: %d\n",
-		__func__,
-		sensor->axis_align.clip_x_low, sensor->axis_align.clip_x_high,
-		sensor->axis_align.clip_y_low, sensor->axis_align.clip_y_high);
-
 	if (rmi_register_desc_has_subpacket(item, 3)) {
 		rx_receivers = buf[offset];
 		tx_receivers = buf[offset + 1];
-- 
2.7.4


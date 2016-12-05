From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH] Input: synaptics-rmi4 - fix debug for sensor clip
Date: Mon,  5 Dec 2016 01:04:41 +0000
Message-ID: <1480899881-31425-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:44875 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcLEBEt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 4 Dec 2016 20:04:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

The debug would only ever output zero for the clip information.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---

 drivers/input/rmi4/rmi_f12.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 8c5360c..e35c64b 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -71,10 +71,6 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	u8 buf[15];
 	int pitch_x = 0;
 	int pitch_y = 0;
-	int clip_x_low = 0;
-	int clip_x_high = 0;
-	int clip_y_low = 0;
-	int clip_y_high = 0;
 	int rx_receivers = 0;
 	int tx_receivers = 0;
 	int sensor_flags = 0;
@@ -127,7 +123,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	}
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: x low: %d x high: %d y low: %d y high: %d\n",
-		__func__, clip_x_low, clip_x_high, clip_y_low, clip_y_high);
+		__func__, sensor->axis_align.clip_x_low, sensor->axis_align.clip_x_high,
+		sensor->axis_align.clip_y_low, sensor->axis_align.clip_y_high);
 
 	if (rmi_register_desc_has_subpacket(item, 3)) {
 		rx_receivers = buf[offset];
-- 
2.7.4


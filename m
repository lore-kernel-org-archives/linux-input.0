From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] Input: edt-ft5x06 - fix setting gain, offset, and threshold via device tree
Date: Tue,  9 Feb 2016 18:22:38 +0100
Message-ID: <1455038558-27471-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57285 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753679AbcBIRWl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 12:22:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, linux-input@vger.kernel.org, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

A recent patch broke parsing the gain, offset, and threshold parameters
from device tree. Instead of setting the cached values and writing them
to the correct registers during probe, it would write the values from DT
into the register address variables and never write them to the chip
during normal operation.

Fixes: 2e23b7a96372 ("Input: edt-ft5x06 - use generic properties API")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/input/touchscreen/edt-ft5x06.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 0b0f8c1..23fbe38 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -822,16 +822,22 @@ static void edt_ft5x06_ts_get_defaults(struct device *dev,
 	int error;
 
 	error = device_property_read_u32(dev, "threshold", &val);
-	if (!error)
-		reg_addr->reg_threshold = val;
+	if (!error) {
+		edt_ft5x06_register_write(tsdata, reg_addr->reg_threshold, val);
+		tsdata->threshold = val;
+	}
 
 	error = device_property_read_u32(dev, "gain", &val);
-	if (!error)
-		reg_addr->reg_gain = val;
+	if (!error) {
+		edt_ft5x06_register_write(tsdata, reg_addr->reg_gain, val);
+		tsdata->gain = val;
+	}
 
 	error = device_property_read_u32(dev, "offset", &val);
-	if (!error)
-		reg_addr->reg_offset = val;
+	if (!error) {
+		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset, val);
+		tsdata->offset = val;
+	}
 }
 
 static void
-- 
2.7.0.rc3


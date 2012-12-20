From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/4] input: adxl34x: don't set THRESH_TAP twice
Date: Thu, 20 Dec 2012 14:51:09 +0100
Message-ID: <1356011471-18757-3-git-send-email-w.sang@pengutronix.de>
References: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50895 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2LTNv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 08:51:29 -0500
In-Reply-To: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, device-drivers-devel@blackfin.uclinux.org, Wolfram Sang <w.sang@pengutronix.de>

The datasheet doesn't say anything about writing twice, so this was
probably overlooked.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/input/misc/adxl34x.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index b18d3e2..6be8687 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -827,7 +827,6 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	if (err)
 		goto err_remove_attr;
 
-	AC_WRITE(ac, THRESH_TAP, pdata->tap_threshold);
 	AC_WRITE(ac, OFSX, pdata->x_axis_offset);
 	ac->hwcal.x = pdata->x_axis_offset;
 	AC_WRITE(ac, OFSY, pdata->y_axis_offset);
-- 
1.7.10.4


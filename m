From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 4/4] input: adxl34x: default platform_data should not use defines from driver
Date: Thu, 20 Dec 2012 14:51:11 +0100
Message-ID: <1356011471-18757-5-git-send-email-w.sang@pengutronix.de>
References: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50900 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab2LTNv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 08:51:29 -0500
In-Reply-To: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, device-drivers-devel@blackfin.uclinux.org, Wolfram Sang <w.sang@pengutronix.de>

Only use the defines which are defined in the platform_data include
file.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/input/misc/adxl34x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 6be8687..0735de3 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -232,7 +232,7 @@ static const struct adxl34x_platform_data adxl34x_default_init = {
 
 	.ev_code_tap = {BTN_TOUCH, BTN_TOUCH, BTN_TOUCH}, /* EV_KEY {x,y,z} */
 	.power_mode = ADXL_AUTO_SLEEP | ADXL_LINK,
-	.fifo_mode = FIFO_STREAM,
+	.fifo_mode = ADXL_FIFO_STREAM,
 	.watermark = 0,
 };
 
-- 
1.7.10.4


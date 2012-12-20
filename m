From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/4] input: adxl34x: consistently use read/write encapsulation
Date: Thu, 20 Dec 2012 14:51:08 +0100
Message-ID: <1356011471-18757-2-git-send-email-w.sang@pengutronix.de>
References: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50896 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab2LTNv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 08:51:29 -0500
In-Reply-To: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, device-drivers-devel@blackfin.uclinux.org, Wolfram Sang <w.sang@pengutronix.de>

Don't open code the AC_READ and AC_WRITE macros.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/input/misc/adxl34x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 1cf72fe..b18d3e2 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -732,7 +732,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	mutex_init(&ac->mutex);
 
 	input_dev->name = "ADXL34x accelerometer";
-	revid = ac->bops->read(dev, DEVID);
+	revid = AC_READ(ac, DEVID);
 
 	switch (revid) {
 	case ID_ADXL345:
@@ -809,7 +809,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	if (FIFO_MODE(pdata->fifo_mode) == FIFO_BYPASS)
 		ac->fifo_delay = false;
 
-	ac->bops->write(dev, POWER_CTL, 0);
+	AC_WRITE(ac, POWER_CTL, 0);
 
 	err = request_threaded_irq(ac->irq, NULL, adxl34x_irq,
 				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-- 
1.7.10.4


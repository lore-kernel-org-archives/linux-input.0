From: Michael Roth <mroth@nessie.de>
Subject: [PATCH 2/2] Input: ads7846 - support to swap x and y axes
Date: Mon, 18 May 2009 20:23:13 +0200
Message-ID: <1242670993-6846-3-git-send-email-mroth@nessie.de>
References: <1242670993-6846-1-git-send-email-mroth@nessie.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from monster.nessie.de ([84.200.20.120]:47710 "EHLO
	monster.nessie.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbZERS2T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2009 14:28:19 -0400
In-Reply-To: <1242670993-6846-1-git-send-email-mroth@nessie.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru, imre.deak@nokia.com, mroth@nessie.de

Signed-off-by: Michael Roth <mroth@nessie.de>
---
 drivers/input/touchscreen/ads7846.c |    7 +++++++
 include/linux/spi/ads7846.h         |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 642f37d..95f1f2e 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -98,6 +98,8 @@ struct ads7846 {
 	u16			x_plate_ohms;
 	u16			pressure_max;
 
+	bool			swap_xy;
+
 	struct ads7846_packet	*packet;
 
 	struct spi_transfer	xfer[18];
@@ -600,6 +602,10 @@ static void ads7846_rx(void *ads)
 			dev_dbg(&ts->spi->dev, "DOWN\n");
 #endif
 		}
+
+		if (ts->swap_xy)
+			swap(x, y);
+
 		input_report_abs(input, ABS_X, x);
 		input_report_abs(input, ABS_Y, y);
 		input_report_abs(input, ABS_PRESSURE, Rt);
@@ -918,6 +924,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	ts->spi = spi;
 	ts->input = input_dev;
 	ts->vref_mv = pdata->vref_mv;
+	ts->swap_xy = pdata->swap_xy;
 
 	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ts->timer.function = ads7846_timer;
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 2ea2032..51948eb 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -17,6 +17,7 @@ struct ads7846_platform_data {
 	u16	vref_mv;		/* external vref value, milliVolts */
 	bool	keep_vref_on;		/* set to keep vref on for differential
 					 * measurements as well */
+	bool	swap_xy;		/* swap x and y axes */
 
 	/* Settling time of the analog signals; a function of Vcc and the
 	 * capacitance on the X/Y drivers.  If set to non-zero, two samples
-- 
1.6.0.6


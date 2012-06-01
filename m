From: <michael.hennerich@analog.com>
Subject: [PATCH] input: touchscreen ad7879 add option to correct xy axis
Date: Fri, 1 Jun 2012 12:37:01 +0200
Message-ID: <1338547021-2931-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:59548
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759149Ab2FAKhc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Jun 2012 06:37:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, sebastian.zenker@gmx.de, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Sebastian Zenker reported that driver swaps x and y samples when the
touchscreen leads are connected in accordance with the datasheet specification.
Transposed axis can be typically corrected by touch screen calibration
however this bug also negatively influences touch pressure measurements.

Add an option to correct x and y axis.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Reported-and-tested-by: Sebastian Zenker <sebastian.zenker@gmx.de>
---
 drivers/input/touchscreen/ad7879.c |    5 +++++
 include/linux/spi/ad7879.h         |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e2482b4..e607092 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -118,6 +118,7 @@ struct ad7879 {
 	unsigned int		irq;
 	bool			disabled;	/* P: input->mutex */
 	bool			suspended;	/* P: input->mutex */
+	bool			swap_xy;
 	u16			conversion_data[AD7879_NR_SENSE];
 	char			phys[32];
 	u8			first_conversion_delay;
@@ -161,6 +162,9 @@ static int ad7879_report(struct ad7879 *ts)
 	z1 = ts->conversion_data[AD7879_SEQ_Z1] & MAX_12BIT;
 	z2 = ts->conversion_data[AD7879_SEQ_Z2] & MAX_12BIT;
 
+	if (ts->swap_xy)
+		swap(x, y);
+
 	/*
 	 * The samples processed here are already preprocessed by the AD7879.
 	 * The preprocessing function consists of a median and an averaging
@@ -520,6 +524,7 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	ts->dev = dev;
 	ts->input = input_dev;
 	ts->irq = irq;
+	ts->swap_xy = pdata->swap_xy;
 
 	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
 
diff --git a/include/linux/spi/ad7879.h b/include/linux/spi/ad7879.h
index 6334cee..9113a59 100644
--- a/include/linux/spi/ad7879.h
+++ b/include/linux/spi/ad7879.h
@@ -12,6 +12,7 @@ struct ad7879_platform_data {
 	u16	y_min, y_max;
 	u16	pressure_min, pressure_max;
 
+	bool	swap_xy;		/* swap x and y axes */
 	/* [0..255] 0=OFF Starts at 1=550us and goes
 	 * all the way to 9.440ms in steps of 35us.
 	 */
-- 
1.7.0.4



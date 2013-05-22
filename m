From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 2/7] input/ti_am33x_tsc: remove platform_data support
Date: Wed, 22 May 2013 23:08:12 +0200
Message-ID: <1369256897-25984-2-git-send-email-bigeasy@linutronix.de>
References: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369256897-25984-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Patil Rachna <rachna-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch removes access to platform data mfd_tscadc_board because the
platform is DT only.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 20f4505..e778ffd 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -24,7 +24,6 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/input/ti_am335x_tsc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -430,24 +429,6 @@ static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
 	return err;
 }
 
-static int titsc_parse_pdata(struct ti_tscadc_dev *tscadc_dev,
-					struct titsc *ts_dev)
-{
-	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
-
-	if (!pdata)
-		return -EINVAL;
-
-	ts_dev->wires = pdata->tsc_init->wires;
-	ts_dev->x_plate_resistance =
-		pdata->tsc_init->x_plate_resistance;
-	ts_dev->steps_to_configure =
-		pdata->tsc_init->steps_to_configure;
-	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
-		sizeof(pdata->tsc_init->wire_config));
-	return 0;
-}
-
 /*
  * The functions for inserting/removing driver as a module.
  */
@@ -473,13 +454,9 @@ static int titsc_probe(struct platform_device *pdev)
 	ts_dev->input = input_dev;
 	ts_dev->irq = tscadc_dev->irq;
 
-	if (tscadc_dev->dev->platform_data)
-		err = titsc_parse_pdata(tscadc_dev, ts_dev);
-	else
-		err = titsc_parse_dt(tscadc_dev, ts_dev);
-
+	err = titsc_parse_dt(tscadc_dev, ts_dev);
 	if (err) {
-		dev_err(&pdev->dev, "Could not find platform data\n");
+		dev_err(&pdev->dev, "Could not find valid DT data.\n");
 		err = -EINVAL;
 		goto err_free_mem;
 	}
-- 
1.7.10.4

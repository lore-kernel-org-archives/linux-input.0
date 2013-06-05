From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/22] iio/ti_am335x_adc: remove platform_data support
Date: Wed,  5 Jun 2013 18:24:42 +0200
Message-ID: <1370449495-29981-10-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35179 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350Ab3FEQZP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jun 2013 12:25:15 -0400
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This patch removes access to platform data mfd_tscadc_board because the
platform is DT only.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 95bcd56..502e929 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -26,7 +26,6 @@
 #include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
-#include <linux/platform_data/ti_am335x_adc.h>
 
 struct tiadc_device {
 	struct ti_tscadc_dev *mfd_tscadc;
@@ -154,13 +153,12 @@ static int tiadc_probe(struct platform_device *pdev)
 	struct iio_dev		*indio_dev;
 	struct tiadc_device	*adc_dev;
 	struct ti_tscadc_dev	*tscadc_dev = ti_tscadc_dev_get(pdev);
-	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
 	struct device_node	*node = tscadc_dev->dev->of_node;
 	int			err;
 	u32			val32;
 
-	if (!pdata && !node) {
-		dev_err(&pdev->dev, "Could not find platform data\n");
+	if (!node) {
+		dev_err(&pdev->dev, "Could not find valid DT data.\n");
 		return -EINVAL;
 	}
 
@@ -174,20 +172,16 @@ static int tiadc_probe(struct platform_device *pdev)
 
 	adc_dev->mfd_tscadc = tscadc_dev;
 
-	if (pdata)
-		adc_dev->channels = pdata->adc_init->adc_channels;
-	else {
-		node = of_get_child_by_name(node, "adc");
-		if (!node) {
-			err = -EINVAL;
-			goto err_free_device;
-		}
-		err = of_property_read_u32(node,
-				"ti,adc-channels", &val32);
-		if (err < 0)
-			goto err_free_device;
-		adc_dev->channels = val32;
+	node = of_get_child_by_name(node, "adc");
+	if (!node) {
+		err = -EINVAL;
+		goto err_free_device;
 	}
+	err = of_property_read_u32(node,
+			"ti,adc-channels", &val32);
+	if (err < 0)
+		goto err_free_device;
+	adc_dev->channels = val32;
 
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
-- 
1.7.10.4


From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 08/22] iio/ti_am335x_adc: Add DT support
Date: Wed,  5 Jun 2013 18:24:41 +0200
Message-ID: <1370449495-29981-9-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

Add DT support for client ADC driver.

[ panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org : use of_get_child_by_name
	instead of of_find_node_by_name ]

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
[bigeasy: shift the code to the left, fix clean up on
          of_get_child_by_name() failer]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iio/adc/ti_am335x_adc.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 543b9c4..95bcd56 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -22,6 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/iio/iio.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 #include <linux/platform_data/ti_am335x_adc.h>
@@ -152,11 +154,12 @@ static int tiadc_probe(struct platform_device *pdev)
 	struct iio_dev		*indio_dev;
 	struct tiadc_device	*adc_dev;
 	struct ti_tscadc_dev	*tscadc_dev = ti_tscadc_dev_get(pdev);
-	struct mfd_tscadc_board	*pdata;
+	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
+	struct device_node	*node = tscadc_dev->dev->of_node;
 	int			err;
+	u32			val32;
 
-	pdata = tscadc_dev->dev->platform_data;
-	if (!pdata || !pdata->adc_init) {
+	if (!pdata && !node) {
 		dev_err(&pdev->dev, "Could not find platform data\n");
 		return -EINVAL;
 	}
@@ -170,7 +173,21 @@ static int tiadc_probe(struct platform_device *pdev)
 	adc_dev = iio_priv(indio_dev);
 
 	adc_dev->mfd_tscadc = tscadc_dev;
-	adc_dev->channels = pdata->adc_init->adc_channels;
+
+	if (pdata)
+		adc_dev->channels = pdata->adc_init->adc_channels;
+	else {
+		node = of_get_child_by_name(node, "adc");
+		if (!node) {
+			err = -EINVAL;
+			goto err_free_device;
+		}
+		err = of_property_read_u32(node,
+				"ti,adc-channels", &val32);
+		if (err < 0)
+			goto err_free_device;
+		adc_dev->channels = val32;
+	}
 
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
-- 
1.7.10.4

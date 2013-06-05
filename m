From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Date: Wed,  5 Jun 2013 18:24:45 +0200
Message-ID: <1370449495-29981-13-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35266 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3FEQ1T (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jun 2013 12:27:19 -0400
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Pantelis Antoniou <panto@antoniou-consulting.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Pantelis Antoniou <panto@antoniou-consulting.com>

Add an IIO map interface that consumers can use.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
[bigeasy: use static AIN[0-8] names, plugged a mem leak, use kcalloc()]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |   57 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 502e929..c6695a8 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -24,12 +24,15 @@
 #include <linux/iio/iio.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/iio/machine.h>
+#include <linux/iio/driver.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
 struct tiadc_device {
 	struct ti_tscadc_dev *mfd_tscadc;
 	int channels;
+	struct iio_map *map;
 };
 
 static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
@@ -84,34 +87,76 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
 	am335x_tsc_se_set(adc_dev->mfd_tscadc, step_en);
 }
 
+static const char * const chan_name_ain[] = {
+	"AIN0",
+	"AIN1",
+	"AIN2",
+	"AIN3",
+	"AIN4",
+	"AIN5",
+	"AIN6",
+	"AIN7",
+};
+
 static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
 {
+	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	struct iio_chan_spec *chan_array;
-	int i;
+	struct iio_chan_spec *chan;
+	int i, ret;
 
 	indio_dev->num_channels = channels;
-	chan_array = kcalloc(indio_dev->num_channels,
+	chan_array = kcalloc(channels,
 			sizeof(struct iio_chan_spec), GFP_KERNEL);
-
 	if (chan_array == NULL)
 		return -ENOMEM;
 
-	for (i = 0; i < (indio_dev->num_channels); i++) {
-		struct iio_chan_spec *chan = chan_array + i;
+	chan = chan_array;
+	for (i = 0; i < channels; i++, chan++) {
+
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
 		chan->channel = i;
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		chan->datasheet_name = chan_name_ain[i];
+		chan->scan_type.sign = 'u';
+		chan->scan_type.realbits = 12;
+		chan->scan_type.storagebits = 32;
+		chan->scan_type.shift = 0;
 	}
 
 	indio_dev->channels = chan_array;
 
-	return indio_dev->num_channels;
+	adc_dev->map = kcalloc(channels + 1, sizeof(struct iio_map),
+			GFP_KERNEL);
+	if (adc_dev->map == NULL)
+		goto err_free_chan;
+
+	for (i = 0; i < channels; i++) {
+		adc_dev->map[i].adc_channel_label =
+			chan_array[i].datasheet_name;
+		adc_dev->map[i].consumer_dev_name = "any";
+		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
+	}
+
+	ret = iio_map_array_register(indio_dev, adc_dev->map);
+	if (ret)
+		goto err_map;
+
+	return 0;
+err_map:
+	kfree(adc_dev->map);
+err_free_chan:
+	kfree(chan_array);
+	return -ENOMEM;
 }
 
 static void tiadc_channels_remove(struct iio_dev *indio_dev)
 {
+	struct tiadc_device *adc_dev = iio_priv(indio_dev);
+
 	kfree(indio_dev->channels);
+	kfree(adc_dev->map);
 }
 
 static int tiadc_read_raw(struct iio_dev *indio_dev,
-- 
1.7.10.4


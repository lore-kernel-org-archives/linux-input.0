From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Date: Mon, 10 Jun 2013 18:27:33 +0200
Message-ID: <20130610162733.GA22366@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
 <1370449495-29981-13-git-send-email-bigeasy@linutronix.de>
 <51B4B024.8070102@metafoo.de>
 <51B582D3.1050501@linutronix.de>
 <51B59071.9090908@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57415 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3FJQ1j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jun 2013 12:27:39 -0400
Content-Disposition: inline
In-Reply-To: <51B59071.9090908@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Pantelis Antoniou <panto@antoniou-consulting.com>

* Lars-Peter Clausen | 2013-06-10 10:38:09 [+0200]:

>- Lars

Thank you for the pointers Lars. This is what I propose instead of the
original patch. I plan to repost the series tomorrow with a few changes
to the device tree nodes so the device is found on lookup.

Subject: [PATCH] iio/ti_tscadc: provide datasheet_name and scan_type

This patch provides the members "datasheet_name" and scan_type. This is
the remaining part of the earlier patch where I (bigeasy) removed iio_map
because it is now supplied by the device tree.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
[bigeasy: use static AIN[0-8] names, use kcalloc(), removed iio_map,
	patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 502e929..4588085 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -24,6 +24,8 @@
 #include <linux/iio/iio.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/iio/machine.h>
+#include <linux/iio/driver.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
@@ -84,29 +86,46 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
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
+	struct iio_chan_spec *chan;
 	int i;
 
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
 	}
 
 	indio_dev->channels = chan_array;
 
-	return indio_dev->num_channels;
+	return 0;
 }
 
 static void tiadc_channels_remove(struct iio_dev *indio_dev)
-- 
1.7.10.4


Sebastian

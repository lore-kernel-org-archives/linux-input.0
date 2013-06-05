From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 22/22] iio/ti_am335x_adc: check if we found the value
Date: Wed,  5 Jun 2013 18:24:55 +0200
Message-ID: <1370449495-29981-23-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35259 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3FEQ1G (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jun 2013 12:27:06 -0400
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Usually we get all the values we wanted but it is possible, that te ADC
unit is busy performing the conversation for the HW events. In that case
-EBUSY is returned and the user may re-call the function.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 4bf34f2..4ef0354 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -171,6 +171,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	int i;
 	unsigned int fifo1count, read;
 	u32 step = UINT_MAX;
+	bool found = false;
 
 	/*
 	 * When the sub-system is first enabled,
@@ -195,11 +196,14 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++) {
 		read = tiadc_readl(adc_dev, REG_FIFO1);
-		if (read >> 16 == step)
+		if (read >> 16 == step) {
 			*val = read & 0xfff;
+			found = true;
+		}
 	}
 	am335x_tsc_se_update(adc_dev->mfd_tscadc);
-
+	if (found == false)
+		return -EBUSY;
 	return IIO_VAL_INT;
 }
 
-- 
1.7.10.4


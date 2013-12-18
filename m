From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/5] iio: ti_am335x_adc: adjust the closing bracket in tiadc_read_raw()
Date: Wed, 18 Dec 2013 17:52:53 +0100
Message-ID: <1387385577-24447-2-git-send-email-bigeasy@linutronix.de>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-input@vger.kernel.org

It somehow looks like the ending bracket belongs to the if statement but
it does belong to the while loop. This patch moves the bracket where it
belongs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index d4d7482..e948454 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -341,7 +341,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	while (tiadc_readl(adc_dev, REG_ADCFSM) & SEQ_STATUS) {
 		if (time_after(jiffies, timeout))
 			return -EAGAIN;
-		}
+	}
 	map_val = chan->channel + TOTAL_CHANNELS;
 
 	/*
-- 
1.8.5.1

From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 4/7] iio/ti_am335x_adc: remove the else case
Date: Wed, 22 May 2013 23:08:14 +0200
Message-ID: <1369256897-25984-4-git-send-email-bigeasy@linutronix.de>
References: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369256897-25984-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Patil Rachna <rachna-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The DT support added in ("iio: adc: am335x: Add DT support")
added an else case which shifts the code to the righ for no reaseon.
This patch simply removes the pointless else case and shifts the code
back to the left.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iio/adc/ti_am335x_adc.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index f258eb0..ac78672 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -214,14 +214,11 @@ static int tiadc_probe(struct platform_device *pdev)
 		node = of_get_child_by_name(node, "adc");
 		if (!node)
 			return  -EINVAL;
-		else {
-			err = of_property_read_u32(node,
-					"ti,adc-channels", &val32);
-			if (err < 0)
-				goto err_free_device;
-			else
-				adc_dev->channels = val32;
-		}
+		err = of_property_read_u32(node,
+				"ti,adc-channels", &val32);
+		if (err < 0)
+			goto err_free_device;
+		adc_dev->channels = val32;
 	}
 
 	indio_dev->dev.parent = &pdev->dev;
-- 
1.7.10.4

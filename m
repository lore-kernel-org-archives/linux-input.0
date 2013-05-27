From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 18/19] mfd/ti_am335x_tscadc: add a module alias for modprobe
Date: Mon, 27 May 2013 21:12:05 +0200
Message-ID: <1369681926-22185-19-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This ensures that the module is loaded on demand once hardware is found.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/mfd/ti_am335x_tscadc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 014df14..5e4076f 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -272,6 +272,7 @@ static const struct of_device_id ti_tscadc_dt_ids[] = {
 	{ .compatible = "ti,ti-tscadc", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
 
 static struct platform_driver ti_tscadc_driver = {
 	.driver = {
-- 
1.7.10.4

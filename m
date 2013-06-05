From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 20/22] input/ti_am335x_tsc: return IRQ_NONE if there was no IRQ for us
Date: Wed,  5 Jun 2013 18:24:53 +0200
Message-ID: <1370449495-29981-21-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The previous patch ("input/ti_am335x_tsc: ACK the HW_PEN irq in ISR")
acked the interrupt so we don't freeze if we don't handle an enabled
interrupt source. The interrupt core has a mechanism for this and to get
it work one should only say that it handled an interrupt if it is
actually the case.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 82d4a39..a06447f 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -314,10 +314,12 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
 	}
 
-	titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
-
-	am335x_tsc_se_update(ts_dev->mfd_tscadc);
-	return IRQ_HANDLED;
+	if (irqclr) {
+		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
+		am335x_tsc_se_update(ts_dev->mfd_tscadc);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
 }
 
 static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
-- 
1.7.10.4

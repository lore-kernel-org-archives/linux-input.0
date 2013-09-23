From: Matthias Kaehlcke <matthias.list@kaehlcke.net>
Subject: [PATCH] input: touchscreen: ti_am335x_tsc: Enable FIFO threshold
 interrupt on resume
Date: Mon, 23 Sep 2013 22:50:56 +0200
Message-ID: <20130923205056.GH27515@raspi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When returning from suspend the FIFO threshold interrupt is
disabled, re-enable it on resume

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>

---
 drivers/input/touchscreen/ti_am335x_tsc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index e1c5300..d86f140 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -480,6 +480,8 @@ static int titsc_resume(struct device *dev)
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
 			ts_dev->coordinate_readouts * 2 + 2 - 1);
+	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
+
 	return 0;
 }
 
-- 
1.7.9.5

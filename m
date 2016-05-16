From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/3] Input: ti_am335x_tsc - Prevent system suspend when TSC is in use
Date: Mon, 16 May 2016 16:56:23 +0530
Message-ID: <1463397984-15766-3-git-send-email-vigneshr@ti.com>
References: <1463397984-15766-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:44272 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400AbcEPLfD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2016 07:35:03 -0400
In-Reply-To: <1463397984-15766-1-git-send-email-vigneshr@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Prevent system suspend while user has finger on touch screen,
because TSC is wakeup source and suspending device while in use will
result in failure to disable the module.
This patch uses pm_stay_awake() and pm_relax() APIs to prevent and
resume system suspend as required.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index f9fefbe337b9..4683ed18b9f8 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -275,6 +275,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	if (status & IRQENB_HW_PEN) {
 		ts_dev->pen_down = true;
 		irqclr |= IRQENB_HW_PEN;
+		pm_stay_awake(ts_dev->mfd_tscadc->dev);
 	}
 
 	if (status & IRQENB_PENUP) {
@@ -284,6 +285,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			input_report_key(input_dev, BTN_TOUCH, 0);
 			input_report_abs(input_dev, ABS_PRESSURE, 0);
 			input_sync(input_dev);
+			pm_relax(ts_dev->mfd_tscadc->dev);
 		} else {
 			ts_dev->pen_down = true;
 		}
@@ -522,6 +524,7 @@ static int __maybe_unused titsc_resume(struct device *dev)
 		titsc_writel(ts_dev, REG_IRQWAKEUP,
 				0x00);
 		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
+		pm_relax(ts_dev->mfd_tscadc->dev);
 	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
-- 
2.8.2


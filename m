From: Y Vo <yvo@apm.com>
Subject: [PATCH v0] gpio_keys: fix gpio key driver to proper support GIC interrupt
Date: Thu,  4 Jun 2015 14:25:12 +0700
Message-ID: <1433402712-21399-1-git-send-email-yvo@apm.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Y Vo <yvo@apm.com>, Phong Vo <pvo@apm.com>, Toan Le <toanle@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, patches@apm.com
List-Id: linux-input@vger.kernel.org

GIC is designed to support two of trigger mechanisms - active level
high or edge rising. But in the gpio_keys driver, it tries to use both
edge rising and edge falling trigger. This patch fixes the gpio_keys
driver to request only the edge rising event when failed to configure the
interrupt.

Signed-off-by: Y Vo <yvo@apm.com>
---
 drivers/input/keyboard/gpio_keys.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ddf4045..7c3da2c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -532,9 +532,23 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
 					     isr, irqflags, desc, bdata);
 	if (error < 0) {
-		dev_err(dev, "Unable to claim irq %d; error %d\n",
-			bdata->irq, error);
-		return error;
+		/*
+		 * Attempt to request again with only rising edge trigger
+		 */
+		if ((irqflags & (IRQ_TYPE_EDGE_RISING | IRQF_TRIGGER_FALLING))) {
+			irqflags = IRQ_TYPE_EDGE_RISING;
+			error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
+							     isr, irqflags, desc, bdata);
+			if (error < 0) {
+				dev_err(dev, "Unable to claim irq %d; error %d\n",
+					bdata->irq, error);
+				return error;
+			}
+		} else {
+			dev_err(dev, "Unable to claim irq %d; error %d\n",
+				bdata->irq, error);
+			return error;
+		}
 	}
 
 	return 0;
-- 
1.7.1


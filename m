From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 8/8] Input: olpc_apsp: allocate the GPIOs used
Date: Mon, 10 Sep 2018 13:26:54 +0200
Message-ID: <20180910112654.42061-9-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Take the GPIO lines are used by the SP. The driver doesn't touch the
lines -- this is done to disallow anything else from fiddling with
them because that would confuse the SP firmware.

Also, the lines are now nicely visible in /sys/kernel/debug/gpio.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/input/serio/olpc_apsp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index fe9e19014e70..287759c5f36d 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
 
 /*
  * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
@@ -76,6 +77,8 @@ struct olpc_apsp {
 	struct serio *padio;
 	void __iomem *base;
 	struct clk *clk;
+	struct gpio_desc *clk_gpio;
+	struct gpio_desc *data_gpio;
 	int open_count;
 	int irq;
 };
@@ -211,6 +214,16 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	priv->clk_gpio = devm_gpiod_get_optional(&pdev->dev, "clk",
+							GPIOD_ASIS);
+	if (IS_ERR(priv->clk_gpio))
+		return PTR_ERR(priv->clk_gpio);
+
+	priv->data_gpio = devm_gpiod_get_optional(&pdev->dev, "data",
+							GPIOD_ASIS);
+	if (IS_ERR(priv->data_gpio))
+		return PTR_ERR(priv->data_gpio);
+
 	/* KEYBOARD */
 	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!kb_serio)
-- 
2.17.1

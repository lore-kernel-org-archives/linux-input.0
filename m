From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] Input: jornada720_ts - get rid of mach/irqs.h include
Date: Fri, 19 Aug 2016 17:31:17 +0100
Message-ID: <E1bamhR-0004We-61@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34987 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754510AbcHSQbU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 12:31:20 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Switch the jornada720 touchscreen driver to obtain its interrupt from
the platform device, rather than via a hard-coded interrupt number
obtained from the mach/irqs.h header.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/jornada720.c         |  6 ++++++
 drivers/input/touchscreen/jornada720_ts.c | 10 ++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 2b96f7bc16bd..010eaea04c69 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -228,9 +228,15 @@ static struct platform_device jornada_kbd_device = {
 	.resource	= jornada_kbd_resources,
 };
 
+static struct resource jornada_ts_resources[] = {
+	DEFINE_RES_IRQ(IRQ_GPIO9),
+};
+
 static struct platform_device jornada_ts_device = {
 	.name		= "jornada_ts",
 	.id		= -1,
+	.num_resources	= ARRAY_SIZE(jornada_ts_resources),
+	.resource	= jornada_ts_resources,
 };
 
 static struct platform_device *devices[] __initdata = {
diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index ea3b6a5b83e6..7e196f8e5661 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -22,7 +22,6 @@
 
 #include <mach/hardware.h>
 #include <mach/jornada720.h>
-#include <mach/irqs.h>
 
 MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
 MODULE_DESCRIPTION("HP Jornada 710/720/728 touchscreen driver");
@@ -101,7 +100,11 @@ static int jornada720_ts_probe(struct platform_device *pdev)
 {
 	struct jornada_ts *jornada_ts;
 	struct input_dev *input_dev;
-	int error;
+	int error, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq < 0 ? irq : -EINVAL;
 
 	jornada_ts = devm_kzalloc(&pdev->dev, sizeof(*jornada_ts), GFP_KERNEL);
 	if (!jornada_ts)
@@ -125,8 +128,7 @@ static int jornada720_ts_probe(struct platform_device *pdev)
 	input_set_abs_params(input_dev, ABS_X, 270, 3900, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y, 180, 3700, 0, 0);
 
-	error = devm_request_irq(&pdev->dev, IRQ_GPIO9,
-				 jornada720_ts_interrupt,
+	error = devm_request_irq(&pdev->dev, irq, jornada720_ts_interrupt,
 				 IRQF_TRIGGER_RISING,
 				 "HP7XX Touchscreen driver", pdev);
 	if (error) {
-- 
2.1.0


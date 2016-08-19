From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 2/2] Input: jornada720_kbd - get rid of mach/irqs.h include
Date: Fri, 19 Aug 2016 17:29:30 +0100
Message-ID: <E1bamfi-0002YX-Ch@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34969 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbcHSQ3e (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 12:29:34 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Switch the jornada720 keyboard driver to obtain its interrupt from the
platform device, rather than via a hard-coded interrupt number obtained
from the mach/irqs.h header.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/jornada720.c       |  6 ++++++
 drivers/input/keyboard/jornada720_kbd.c | 11 +++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index c0b1f5bafae4..2b96f7bc16bd 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -217,9 +217,15 @@ static struct platform_device jornada_ssp_device = {
 	.id             = -1,
 };
 
+static struct resource jornada_kbd_resources[] = {
+	DEFINE_RES_IRQ(IRQ_GPIO0),
+};
+
 static struct platform_device jornada_kbd_device = {
 	.name		= "jornada720_kbd",
 	.id		= -1,
+	.num_resources	= ARRAY_SIZE(jornada_kbd_resources),
+	.resource	= jornada_kbd_resources,
 };
 
 static struct platform_device jornada_ts_device = {
diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
index 4b2e9ff18ba1..484ee1ff33b8 100644
--- a/drivers/input/keyboard/jornada720_kbd.c
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -26,7 +26,6 @@
 
 #include <mach/jornada720.h>
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 
 MODULE_AUTHOR("Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
 MODULE_DESCRIPTION("HP Jornada 710/720/728 keyboard driver");
@@ -98,7 +97,11 @@ static int jornada720_kbd_probe(struct platform_device *pdev)
 {
 	struct jornadakbd *jornadakbd;
 	struct input_dev *input_dev;
-	int i, err;
+	int i, err, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq < 0 ? irq : -EINVAL;
 
 	jornadakbd = devm_kzalloc(&pdev->dev, sizeof(*jornadakbd), GFP_KERNEL);
 	input_dev = devm_input_allocate_device(&pdev->dev);
@@ -126,10 +129,10 @@ static int jornada720_kbd_probe(struct platform_device *pdev)
 
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
-	err = devm_request_irq(&pdev->dev, IRQ_GPIO0, jornada720_kbd_interrupt,
+	err = devm_request_irq(&pdev->dev, irq, jornada720_kbd_interrupt,
 			       IRQF_TRIGGER_FALLING, "jornadakbd", pdev);
 	if (err) {
-		printk(KERN_INFO "jornadakbd720_kbd: Unable to grab IRQ\n");
+		dev_err(dev, "unable to grab IRQ%d: %d\n", irq, err);
 		return err;
 	}
 
-- 
2.1.0


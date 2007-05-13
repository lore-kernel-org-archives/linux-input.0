From: Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH] Fix spitzkbd compile warnings
Date: Sun, 13 May 2007 13:35:47 +0100
Message-ID: <1179059748.5883.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Fix compile warnings from spitzkbd.c. Registration failure of these IRQs
isn't fatal so just warn about it.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

diff --git a/drivers/input/keyboard/spitzkbd.c b/drivers/input/keyboard/spitzkbd.c
index 41b8038..a609d43 100644
--- a/drivers/input/keyboard/spitzkbd.c
+++ b/drivers/input/keyboard/spitzkbd.c
@@ -418,21 +418,26 @@ static int __init spitzkbd_probe(struct platform_device *dev)
 	pxa_gpio_mode(SPITZ_GPIO_SWA | GPIO_IN);
 	pxa_gpio_mode(SPITZ_GPIO_SWB | GPIO_IN);
 
-	request_irq(SPITZ_IRQ_GPIO_SYNC, spitzkbd_interrupt,
+	if (request_irq(SPITZ_IRQ_GPIO_SYNC, spitzkbd_interrupt,
 		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd Sync", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_ON_KEY, spitzkbd_interrupt,
+		    "Spitzkbd Sync", spitzkbd))
+		printk(KERN_WARNING "spitzkbd: Failed to request sync IRQ\n");
+	if (request_irq(SPITZ_IRQ_GPIO_ON_KEY, spitzkbd_interrupt,
 		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd PwrOn", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_SWA, spitzkbd_hinge_isr,
+		    "Spitzkbd PwrOn", spitzkbd))
+		printk(KERN_WARNING "spitzkbd: Failed to request GPIO IRQ\n");
+	if (request_irq(SPITZ_IRQ_GPIO_SWA, spitzkbd_hinge_isr,
 		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd SWA", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd_hinge_isr,
+		    "Spitzkbd SWA", spitzkbd))
+		printk(KERN_WARNING "spitzkbd: Failed to request SWA IRQ\n");
+	if (request_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd_hinge_isr,
 		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd SWB", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd_hinge_isr,
+		    "Spitzkbd SWB", spitzkbd))
+		printk(KERN_WARNING "spitzkbd: Failed to request SWB IRQ\n");
+	if (request_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd_hinge_isr,
 		    IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		    "Spitzkbd HP", spitzkbd);
+		    "Spitzkbd HP", spitzkbd))
+		printk(KERN_WARNING "spitzkbd: Failed to request AK IRQ\n");
 
 	return 0;
 

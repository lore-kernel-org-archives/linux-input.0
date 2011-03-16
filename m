From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] Input: tca6416-keypad: Suspend/Resume wakeup support
Date: Wed, 16 Mar 2011 14:10:30 +0900
Message-ID: <20110316051030.2399.19707.sendpatchset@t400s>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: srk@ti.com, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, chinyeow.sim.xt@renesas.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the tca6416 driver to use enable_irq_wake()
and disable_irq_wake() in the suspend/resume hooks.

This makes it possible to wake up from suspend-to-ram
using a tca6416 key on the sh7372 mackerel board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/tca6416-keypad.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- 0001/drivers/input/keyboard/tca6416-keypad.c
+++ work/drivers/input/keyboard/tca6416-keypad.c	2011-03-16 12:53:34.000000000 +0900
@@ -297,6 +297,7 @@ static int __devinit tca6416_keypad_prob
 	}
 
 	i2c_set_clientdata(client, chip);
+	device_init_wakeup(&client->dev, 1);
 
 	return 0;
 
@@ -326,10 +327,35 @@ static int __devexit tca6416_keypad_remo
 	return 0;
 }
 
+static int tca6416_keypad_suspend(struct device *dev)
+{
+	struct tca6416_keypad_chip *chip = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(chip->irqnum);
+
+	return 0;
+}
+
+static int tca6416_keypad_resume(struct device *dev)
+{
+	struct tca6416_keypad_chip *chip = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(chip->irqnum);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tca6416_keypad_dev_pm_ops = {
+	.suspend = tca6416_keypad_suspend,
+	.resume = tca6416_keypad_resume,
+};
 
 static struct i2c_driver tca6416_keypad_driver = {
 	.driver = {
 		.name	= "tca6416-keypad",
+		.pm	= &tca6416_keypad_dev_pm_ops,
 	},
 	.probe		= tca6416_keypad_probe,
 	.remove		= __devexit_p(tca6416_keypad_remove),

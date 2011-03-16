From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tca6416-keypad: Suspend/Resume wakeup support
Date: Tue, 15 Mar 2011 22:32:02 -0700
Message-ID: <20110316053202.GA14604@core.coreip.homeip.net>
References: <20110316051030.2399.19707.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110316051030.2399.19707.sendpatchset@t400s>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: srk@ti.com, linux-sh@vger.kernel.org, chinyeow.sim.xt@renesas.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 16, 2011 at 02:10:30PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Extend the tca6416 driver to use enable_irq_wake()
> and disable_irq_wake() in the suspend/resume hooks.
> 
> This makes it possible to wake up from suspend-to-ram
> using a tca6416 key on the sh7372 mackerel board.
> 

Hi Magnus,

Looks good, but why don't we guard PM code with CONFIG_PM_SLEEP, like
below? I also believe we should use bus-specific helpers to access
private driver data since it does not have to stay alias for the
core data pointer.

Thanks.

-- 
Dmitry


Input: tca6416-keypad - Suspend/Resume wakeup support

From: Magnus Damm <damm@opensource.se>

Extend the tca6416 driver to use enable_irq_wake()
and disable_irq_wake() in the suspend/resume hooks.

This makes it possible to wake up from suspend-to-ram
using a tca6416 key on the sh7372 mackerel board.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/tca6416-keypad.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)


diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 800fbcc..3afea3f 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -297,6 +297,7 @@ static int __devinit tca6416_keypad_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, chip);
+	device_init_wakeup(&client->dev, 1);
 
 	return 0;
 
@@ -326,10 +327,37 @@ static int __devexit tca6416_keypad_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int tca6416_keypad_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(chip->irqnum);
+
+	return 0;
+}
+
+static int tca6416_keypad_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(chip->irqnum);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(tca6416_keypad_dev_pm_ops,
+			 tca6416_keypad_suspend, tca6416_keypad_resume);
 
 static struct i2c_driver tca6416_keypad_driver = {
 	.driver = {
 		.name	= "tca6416-keypad",
+		.pm	= &tca6416_keypad_dev_pm_ops,
 	},
 	.probe		= tca6416_keypad_probe,
 	.remove		= __devexit_p(tca6416_keypad_remove),

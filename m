From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.30] input:  dm355evm_keys uses threaded IRQs
Date: Wed, 24 Jun 2009 10:21:05 -0700
Message-ID: <200906241021.06141.david-b@pacbell.net>
References: <200901171315.08019.david-b@pacbell.net> <200906211710.50537.david-b@pacbell.net> <20090623050519.GA14724@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:44942 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757445AbZFXRVD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2009 13:21:03 -0400
In-Reply-To: <20090623050519.GA14724@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Convert the dm355evm keys driver to use IRQ threading instead of
a private workqueue.  IRQ threads were added to Linux after this
driver was written, and in this case fit what the driver needs.
(Although the non-shared thread costs more runtime memory.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/input/misc/dm355evm_keys.c |   42 ++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -23,30 +23,16 @@
  * pressed, or its autorepeat kicks in, an event is sent.  This driver
  * read those events from the small (32 event) queue and reports them.
  *
- * Because we communicate with the MSP430 using I2C, and all I2C calls
- * in Linux sleep, we need to cons up a kind of threaded IRQ handler
- * using a work_struct.  The IRQ is active low, but we use it through
- * the GPIO controller so we can trigger on falling edges.
- *
  * Note that physically there can only be one of these devices.
  *
  * This driver was tested with firmware revision A4.
  */
 struct dm355evm_keys {
-	struct work_struct	work;
 	struct input_dev	*input;
 	struct device		*dev;
 	int			irq;
 };
 
-static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
-{
-	struct dm355evm_keys	*keys = _keys;
-
-	schedule_work(&keys->work);
-	return IRQ_HANDLED;
-}
-
 /* These initial keycodes can be remapped by dm355evm_setkeycode(). */
 static struct {
 	u16	event;
@@ -110,13 +96,12 @@ static struct {
 	{ 0x3169, KEY_PAUSE, },
 };
 
-static void dm355evm_keys_work(struct work_struct *work)
+/* runs in an IRQ thread -- can (and will!) sleep */
+static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
 {
-	struct dm355evm_keys	*keys;
+	struct dm355evm_keys	*keys = _keys;
 	int			status;
 
-	keys = container_of(work, struct dm355evm_keys, work);
-
 	/* For simplicity we ignore INPUT_COUNT and just read
 	 * events until we get the "queue empty" indicator.
 	 * Reading INPUT_LOW decrements the count.
@@ -183,6 +168,19 @@ static void dm355evm_keys_work(struct wo
 		input_report_key(keys->input, keycode, 0);
 		input_sync(keys->input);
 	}
+	return IRQ_HANDLED;
+}
+
+/*
+ * Because we communicate with the MSP430 using I2C, and all I2C calls
+ * in Linux sleep, we use a threaded IRQ handler.  The IRQ itself is
+ * active low, but we go through the GPIO controller so we can trigger
+ * on falling edges and not worry about enabling/disabling the IRQ in
+ * the keypress handling path.
+ */
+static irqreturn_t dm355evm_keys_hardirq(int irq, void *_keys)
+{
+	return IRQ_WAKE_THREAD;
 }
 
 static int dm355evm_setkeycode(struct input_dev *dev, int index, int keycode)
@@ -233,7 +231,6 @@ static int __devinit dm355evm_keys_probe
 
 	keys->dev = &pdev->dev;
 	keys->input = input;
-	INIT_WORK(&keys->work, dm355evm_keys_work);
 
 	/* set up "threaded IRQ handler" */
 	status = platform_get_irq(pdev, 0);
@@ -260,9 +257,10 @@ static int __devinit dm355evm_keys_probe
 
 	/* REVISIT:  flush the event queue? */
 
-	status = request_irq(keys->irq, dm355evm_keys_irq,
-			     IRQF_TRIGGER_FALLING,
-			     dev_name(&pdev->dev), keys);
+	status = request_threaded_irq(keys->irq,
+			dm355evm_keys_hardirq, dm355evm_keys_irq,
+			IRQF_TRIGGER_FALLING,
+			dev_name(&pdev->dev), keys);
 	if (status < 0)
 		goto fail1;
 

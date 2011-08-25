From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/RFT][PATCH] Input: tsc2007 - convert to threaded IRQ
Date: Wed, 24 Aug 2011 23:43:33 -0700
Message-ID: <20110825064333.GA15655@core.coreip.homeip.net>
References: <20110823061738.GA25272@core.coreip.homeip.net>
 <20110825062159.GB25708@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33283 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab1HYGnj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 02:43:39 -0400
Received: by gxk21 with SMTP id 21so1497713gxk.19
        for <linux-input@vger.kernel.org>; Wed, 24 Aug 2011 23:43:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110825062159.GB25708@avionic-0098.mockup.avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Linux Input <linux-input@vger.kernel.org>, Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>

On Thu, Aug 25, 2011 at 08:21:59AM +0200, Thierry Reding wrote:
> * Dmitry Torokhov wrote:
> > This is completely untested but I believe it should work better than original
> > workqueue solution, especially when we do not have get_pendown_state method
> > available. I wonder if it will help Richard's issue with IRQ getting re-raised
> > after pen up event.
> > 
> > Anyone who has hardware - please give it a spin.
> 
> I can see no noticeable changes with this patch.
> 

That's the result I was aiming for ;) Thanks for testing.

Oh, crap... Does it still work if you change IRQ flags in
request_threaded_irq() from 0 to IRQF_ONESHOT? 

Also, while we are at it would you ming trying out another patch
(below)?

Thanks!

-- 
Dmitry


Input: tsc2007 - add open and close methods

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2007.c |   46 +++++++++++++++++++++++++++++------
 1 files changed, 38 insertions(+), 8 deletions(-)


diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 0fbc530..494b175 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -237,12 +237,40 @@ static irqreturn_t tsc2007_hard_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
-static void tsc2007_free_irq(struct tsc2007 *ts)
+static void tsc2007_stop(struct tsc2007 *ts)
 {
 	ts->stopped = true;
 	mb();
 	wake_up(&ts->wait);
-	free_irq(ts->irq, ts);
+
+	disable_irq(ts->irq);
+}
+
+static int tsc2007_open(struct input_dev *input_dev)
+{
+	struct tsc2007 *ts = input_get_drvdata(input_dev);
+	int err;
+
+	ts->stopped = false;
+	mb();
+
+	enable_irq(ts->irq);
+
+	/* Prepare for touch readings - power down ADC and enable PENIRQ */
+	err = tsc2007_xfer(ts, PWRDOWN);
+	if (err) {
+		tsc2007_stop(ts);
+		return err;
+	}
+
+	return 0;
+}
+
+static void tsc2007_close(struct input_dev *input_dev)
+{
+	struct tsc2007 *ts = input_get_drvdata(input_dev);
+
+	tsc2007_stop(ts);
 }
 
 static int __devinit tsc2007_probe(struct i2c_client *client,
@@ -289,6 +317,11 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	input_dev->phys = ts->phys;
 	input_dev->id.bustype = BUS_I2C;
 
+	input_dev->open = tsc2007_open;
+	input_dev->close = tsc2007_close;
+
+	input_set_drvdata(input_dev, ts);
+
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
@@ -307,10 +340,7 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
-	/* Prepare for touch readings - power down ADC and enable PENIRQ */
-	err = tsc2007_xfer(ts, PWRDOWN);
-	if (err < 0)
-		goto err_free_irq;
+	tsc2007_stop(ts);
 
 	err = input_register_device(input_dev);
 	if (err)
@@ -321,7 +351,7 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	return 0;
 
  err_free_irq:
-	tsc2007_free_irq(ts);
+	free_irq(ts->irq, ts);
 	if (pdata->exit_platform_hw)
 		pdata->exit_platform_hw();
  err_free_mem:
@@ -335,7 +365,7 @@ static int __devexit tsc2007_remove(struct i2c_client *client)
 	struct tsc2007	*ts = i2c_get_clientdata(client);
 	struct tsc2007_platform_data *pdata = client->dev.platform_data;
 
-	tsc2007_free_irq(ts);
+	free_irq(ts->irq, ts);
 
 	if (pdata->exit_platform_hw)
 		pdata->exit_platform_hw();

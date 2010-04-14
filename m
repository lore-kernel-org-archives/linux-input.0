From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: eeti_ts: cancel pending work when going to suspend
Date: Wed, 14 Apr 2010 11:14:18 -0700
Message-ID: <20100414181417.GA27661@core.coreip.homeip.net>
References: <1271183505-28133-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56740 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359Ab0DNSO1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 14:14:27 -0400
Received: by wyb39 with SMTP id 39so49411wyb.19
        for <linux-input@vger.kernel.org>; Wed, 14 Apr 2010 11:14:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271183505-28133-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Tue, Apr 13, 2010 at 08:31:45PM +0200, Daniel Mack wrote:
> This fixes a race between the suspend code and input events.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/eeti_ts.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
> index 204b8a1..2a01695 100644
> --- a/drivers/input/touchscreen/eeti_ts.c
> +++ b/drivers/input/touchscreen/eeti_ts.c
> @@ -250,6 +250,9 @@ static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
>  	if (device_may_wakeup(&client->dev))
>  		enable_irq_wake(priv->irq);
>  
> +	disable_irq(priv->irq);
> +	cancel_work_sync(&priv->work);

You need to check 'users' when disabling as well, otherwise you may get
enable/disable unbalanced when there are no users.

Does the patch below still work for you?

-- 
Dmitry


Input: eeti_ts - cancel pending work when going to suspend

From: Daniel Mack <daniel@caiaq.de>

This fixes a race between the suspend code and input events.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/eeti_ts.c |   56 +++++++++++++++++++++++++++++------
 1 files changed, 46 insertions(+), 10 deletions(-)


diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 204b8a1..75f8b73 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -124,14 +124,25 @@ static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int eeti_ts_open(struct input_dev *dev)
+static void eeti_ts_start(struct eeti_ts_priv *priv)
 {
-	struct eeti_ts_priv *priv = input_get_drvdata(dev);
-
 	enable_irq(priv->irq);
 
 	/* Read the events once to arm the IRQ */
 	eeti_ts_read(&priv->work);
+}
+
+static void eeti_ts_stop(struct eeti_ts_priv *priv)
+{
+	disable_irq(priv->irq);
+	cancel_work_sync(&priv->work);
+}
+
+static int eeti_ts_open(struct input_dev *dev)
+{
+	struct eeti_ts_priv *priv = input_get_drvdata(dev);
+
+	eeti_ts_start(priv);
 
 	return 0;
 }
@@ -140,8 +151,7 @@ static void eeti_ts_close(struct input_dev *dev)
 {
 	struct eeti_ts_priv *priv = input_get_drvdata(dev);
 
-	disable_irq(priv->irq);
-	cancel_work_sync(&priv->work);
+	eeti_ts_stop(priv);
 }
 
 static int __devinit eeti_ts_probe(struct i2c_client *client,
@@ -153,10 +163,12 @@ static int __devinit eeti_ts_probe(struct i2c_client *client,
 	unsigned int irq_flags;
 	int err = -ENOMEM;
 
-	/* In contrast to what's described in the datasheet, there seems
+	/*
+	 * In contrast to what's described in the datasheet, there seems
 	 * to be no way of probing the presence of that device using I2C
 	 * commands. So we need to blindly believe it is there, and wait
-	 * for interrupts to occur. */
+	 * for interrupts to occur.
+	 */
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -212,9 +224,11 @@ static int __devinit eeti_ts_probe(struct i2c_client *client,
 		goto err2;
 	}
 
-	/* Disable the irq for now. It will be enabled once the input device
-	 * is opened. */
-	disable_irq(priv->irq);
+	/*
+	 * Disable the device for now. It will be enabled once the
+	 * input device is opened.
+	 */
+	eeti_ts_stop(priv);
 
 	device_init_wakeup(&client->dev, 0);
 	return 0;
@@ -235,6 +249,12 @@ static int __devexit eeti_ts_remove(struct i2c_client *client)
 	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
 
 	free_irq(priv->irq, priv);
+	/*
+	 * eeti_ts_stop() leaves IRQ disabled. We need to re-enable it
+	 * so that device still works if we reload the driver.
+	 */
+	enable_irq(priv->irq);
+
 	input_unregister_device(priv->input);
 	i2c_set_clientdata(client, NULL);
 	kfree(priv);
@@ -246,6 +266,14 @@ static int __devexit eeti_ts_remove(struct i2c_client *client)
 static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
 {
 	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
+	struct input_dev *input_dev = priv->input;
+
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users)
+		eeti_ts_stop(priv);
+
+	mutex_unlock(&input_dev->mutex);
 
 	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(priv->irq);
@@ -256,10 +284,18 @@ static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
 static int eeti_ts_resume(struct i2c_client *client)
 {
 	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
+	struct input_dev *input_dev = priv->input;
 
 	if (device_may_wakeup(&client->dev))
 		disable_irq_wake(priv->irq);
 
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users)
+		eeti_ts_start(priv);
+
+	mutex_unlock(&input_dev->mutex);
+
 	return 0;
 }
 #else

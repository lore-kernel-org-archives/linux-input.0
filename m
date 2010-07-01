From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input/misc: new ADXL345/346 driver
Date: Thu, 1 Jul 2010 00:53:16 -0700
Message-ID: <20100701075316.GA14696@core.coreip.homeip.net>
References: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
 <1256028039-15044-1-git-send-email-vapier@gentoo.org>
 <20100625071425.GA631@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917712E66DFEF69@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63511 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab0GAHx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Jul 2010 03:53:27 -0400
Received: by pvc7 with SMTP id 7so703730pvc.19
        for <linux-input@vger.kernel.org>; Thu, 01 Jul 2010 00:53:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E66DFEF69@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Chris Verges <chrisv@cyberswitching.com>, Luotao Fu <l.fu@pengutronix.de>, "Song, Barry" <Barry.Song@analog.com>

On Fri, Jun 25, 2010 at 02:59:24PM +0100, Hennerich, Michael wrote:
> Dmitry Torokhov wrote on 2010-06-25:
> > Hi Mike, Michael,
> >
> > On Tue, Oct 20, 2009 at 04:40:39AM -0400, Mike Frysinger wrote:
> >> From: Michael Hennerich <michael.hennerich@analog.com>
> >>
> >> This is a driver for the ADXL345/346 Three-Axis Digital Accelerometers.
> >>
> >
> > As I mentioned in one of the threads I decided to pull 3-axis
> > acceleromenetrs into input and I am finally getting around to apply
> > the patch... However I messed a bit with it so I was wondering if
> > someone could give it a short spin to see if I broke it or not.
> >
> > Thanks!
> >
> 
> Hi Dmitry,
> 
> Thanks for merging this driver.
> I gave it a quick spin. And there is one issue.
> There is a code path that is taken with the mutex held,
> which is also trying to acquire the mutex.
> 
> Take a look at
> 
> adxl34x_input_close() -> __adxl34x_disable()
> or
> adxl34x_disable() -> __adxl34x_disable()
> 
> I think __adxl34x_disable() should not acquire the mutex!
>

Yes, indeed it shoudl not have. I fixed it up and applied the patch.
Could you also please try the following patch - hopefully it also works
;)

Thank you in advance.

-- 
Dmitry

Input: adxl34 - make enable/disable separate from suspend/resume

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Suspending and resuming the device should be separate from enabling
and disabling it through sysfs attribute and thus should not alter
ac->disabled flag.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/adxl34x-i2c.c |   16 ++++----
 drivers/input/misc/adxl34x-spi.c |   16 ++++----
 drivers/input/misc/adxl34x.c     |   77 ++++++++++++++++++++++++--------------
 drivers/input/misc/adxl34x.h     |    4 +-
 4 files changed, 67 insertions(+), 46 deletions(-)


diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 76194b5..b1b8df3 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -105,26 +105,26 @@ static int __devexit adxl34x_i2c_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int adxl34x_suspend(struct i2c_client *client, pm_message_t message)
+static int adxl34x_i2c_suspend(struct i2c_client *client, pm_message_t message)
 {
 	struct adxl34x *ac = i2c_get_clientdata(client);
 
-	adxl34x_disable(ac);
+	adxl34x_suspend(ac);
 
 	return 0;
 }
 
-static int adxl34x_resume(struct i2c_client *client)
+static int adxl34x_i2c_resume(struct i2c_client *client)
 {
 	struct adxl34x *ac = i2c_get_clientdata(client);
 
-	adxl34x_enable(ac);
+	adxl34x_resume(ac);
 
 	return 0;
 }
 #else
-# define adxl34x_suspend NULL
-# define adxl34x_resume  NULL
+# define adxl34x_i2c_suspend NULL
+# define adxl34x_i2c_resume  NULL
 #endif
 
 static const struct i2c_device_id adxl34x_id[] = {
@@ -141,8 +141,8 @@ static struct i2c_driver adxl34x_driver = {
 	},
 	.probe    = adxl34x_i2c_probe,
 	.remove   = __devexit_p(adxl34x_i2c_remove),
-	.suspend  = adxl34x_suspend,
-	.resume   = adxl34x_resume,
+	.suspend  = adxl34x_i2c_suspend,
+	.resume   = adxl34x_i2c_resume,
 	.id_table = adxl34x_id,
 };
 
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index 7f99235..782de9e 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -94,26 +94,26 @@ static int __devexit adxl34x_spi_remove(struct spi_device *spi)
 }
 
 #ifdef CONFIG_PM
-static int adxl34x_suspend(struct spi_device *spi, pm_message_t message)
+static int adxl34x_spi_suspend(struct spi_device *spi, pm_message_t message)
 {
 	struct adxl34x *ac = dev_get_drvdata(&spi->dev);
 
-	adxl34x_disable(ac);
+	adxl34x_suspend(ac);
 
 	return 0;
 }
 
-static int adxl34x_resume(struct spi_device *spi)
+static int adxl34x_spi_resume(struct spi_device *spi)
 {
 	struct adxl34x *ac = dev_get_drvdata(&spi->dev);
 
-	adxl34x_enable(ac);
+	adxl34x_resume(ac);
 
 	return 0;
 }
 #else
-# define adxl34x_suspend NULL
-# define adxl34x_resume  NULL
+# define adxl34x_spi_suspend NULL
+# define adxl34x_spi_resume  NULL
 #endif
 
 static struct spi_driver adxl34x_driver = {
@@ -124,8 +124,8 @@ static struct spi_driver adxl34x_driver = {
 	},
 	.probe   = adxl34x_spi_probe,
 	.remove  = __devexit_p(adxl34x_spi_remove),
-	.suspend = adxl34x_suspend,
-	.resume  = adxl34x_resume,
+	.suspend = adxl34x_spi_suspend,
+	.resume  = adxl34x_spi_resume,
 };
 
 static int __init adxl34x_spi_init(void)
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 77fb409..2706ea0 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -200,6 +200,7 @@ struct adxl34x {
 	unsigned orient3d_saved;
 	bool disabled;	/* P: mutex */
 	bool opened;	/* P: mutex */
+	bool suspended;	/* P: mutex */
 	bool fifo_delay;
 	int irq;
 	unsigned model;
@@ -399,41 +400,44 @@ static irqreturn_t adxl34x_irq(int irq, void *handle)
 
 static void __adxl34x_disable(struct adxl34x *ac)
 {
-	if (!ac->disabled && ac->opened) {
-		/*
-		 * A '0' places the ADXL34x into standby mode
-		 * with minimum power consumption.
-		 */
-		AC_WRITE(ac, POWER_CTL, 0);
-
-		ac->disabled = true;
-	}
+	/*
+	 * A '0' places the ADXL34x into standby mode
+	 * with minimum power consumption.
+	 */
+	AC_WRITE(ac, POWER_CTL, 0);
 }
 
 static void __adxl34x_enable(struct adxl34x *ac)
 {
-	if (ac->disabled && ac->opened) {
-		AC_WRITE(ac, POWER_CTL, ac->pdata.power_mode | PCTL_MEASURE);
-		ac->disabled = false;
-	}
+	AC_WRITE(ac, POWER_CTL, ac->pdata.power_mode | PCTL_MEASURE);
 }
 
-void adxl34x_disable(struct adxl34x *ac)
+void adxl34x_suspend(struct adxl34x *ac)
 {
 	mutex_lock(&ac->mutex);
-	__adxl34x_disable(ac);
+
+	if (!ac->suspended && !ac->disabled && ac->opened)
+		__adxl34x_disable(ac);
+
+	ac->suspended = true;
+
 	mutex_unlock(&ac->mutex);
 }
-EXPORT_SYMBOL_GPL(adxl34x_disable);
+EXPORT_SYMBOL_GPL(adxl34x_suspend);
 
-void adxl34x_enable(struct adxl34x *ac)
+void adxl34x_resume(struct adxl34x *ac)
 {
 	mutex_lock(&ac->mutex);
-	__adxl34x_enable(ac);
+
+	if (ac->suspended && !ac->disabled && ac->opened)
+		__adxl34x_enable(ac);
+
+	ac->suspended= false;
+
 	mutex_unlock(&ac->mutex);
 }
 
-EXPORT_SYMBOL_GPL(adxl34x_enable);
+EXPORT_SYMBOL_GPL(adxl34x_resume);
 
 static ssize_t adxl34x_disable_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
@@ -455,10 +459,21 @@ static ssize_t adxl34x_disable_store(struct device *dev,
 	if (error)
 		return error;
 
-	if (val)
-		adxl34x_disable(ac);
-	else
-		adxl34x_enable(ac);
+	mutex_lock(&ac->mutex);
+
+	if (!ac->suspended && ac->opened) {
+		if (val) {
+			if (!ac->disabled)
+				__adxl34x_disable(ac);
+		} else {
+			if (ac->disabled)
+				__adxl34x_enable(ac);
+		}
+	}
+
+	ac->disabled = !!val;
+
+	mutex_unlock(&ac->mutex);
 
 	return count;
 }
@@ -499,7 +514,6 @@ static ssize_t adxl34x_calibrate_store(struct device *dev,
 	ac->hwcal.y -= (ac->saved.y / 4);
 	ac->swcal.y = ac->saved.y % 4;
 
-	ac->hwcal.z -= (ac->saved.z / 4);
 	ac->swcal.z = ac->saved.z % 4;
 
 	AC_WRITE(ac, OFSX, (s8) ac->hwcal.x);
@@ -575,7 +589,7 @@ static ssize_t adxl34x_autosleep_store(struct device *dev,
 	else
 		ac->pdata.power_mode &= ~(PCTL_AUTO_SLEEP | PCTL_LINK);
 
-	if (!ac->disabled && ac->opened)
+	if (!ac->disabled && !ac->suspended && ac->opened)
 		AC_WRITE(ac, POWER_CTL, ac->pdata.power_mode | PCTL_MEASURE);
 
 	mutex_unlock(&ac->mutex);
@@ -649,8 +663,12 @@ static int adxl34x_input_open(struct input_dev *input)
 	struct adxl34x *ac = input_get_drvdata(input);
 
 	mutex_lock(&ac->mutex);
+
+	if (!ac->suspended && !ac->disabled)
+		__adxl34x_enable(ac);
+
 	ac->opened = true;
-	__adxl34x_enable(ac);
+
 	mutex_unlock(&ac->mutex);
 
 	return 0;
@@ -661,8 +679,12 @@ static void adxl34x_input_close(struct input_dev *input)
 	struct adxl34x *ac = input_get_drvdata(input);
 
 	mutex_lock(&ac->mutex);
-	__adxl34x_disable(ac);
+
+	if (!ac->suspended && !ac->disabled)
+		__adxl34x_disable(ac);
+
 	ac->opened = false;
+
 	mutex_unlock(&ac->mutex);
 }
 
@@ -878,7 +900,6 @@ EXPORT_SYMBOL_GPL(adxl34x_probe);
 
 int adxl34x_remove(struct adxl34x *ac)
 {
-	adxl34x_disable(ac);
 	sysfs_remove_group(&ac->dev->kobj, &adxl34x_attr_group);
 	free_irq(ac->irq, ac);
 	input_unregister_device(ac->input);
diff --git a/drivers/input/misc/adxl34x.h b/drivers/input/misc/adxl34x.h
index ea9093c..bbbc80f 100644
--- a/drivers/input/misc/adxl34x.h
+++ b/drivers/input/misc/adxl34x.h
@@ -20,8 +20,8 @@ struct adxl34x_bus_ops {
 	int (*write)(struct device *, unsigned char, unsigned char);
 };
 
-void adxl34x_disable(struct adxl34x *ac);
-void adxl34x_enable(struct adxl34x *ac);
+void adxl34x_suspend(struct adxl34x *ac);
+void adxl34x_resume(struct adxl34x *ac);
 struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 			      bool fifo_delay_default,
 			      const struct adxl34x_bus_ops *bops);

From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] input/keyboard: add ADP5588
	QWERTY I2C Keyboard	Input device driver
Date: Tue, 15 Sep 2009 22:02:36 -0700
Message-ID: <20090916050236.GF2756@core.coreip.homeip.net>
References: <20090915062050.GB10232@core.coreip.homeip.net>
	<1253062178-18196-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1253062178-18196-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Sep 15, 2009 at 08:49:38PM -0400, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
> ---
> v2
> 	- merge my and Dmitry's clean up fixes
> 

Looks good, I'd also like to add this instead of recalcularing delay
every time:

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 892a532..d48c808 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -63,7 +63,7 @@ struct adp5588_kpad {
 	struct i2c_client *client;
 	struct input_dev *input;
 	struct delayed_work work;
-	unsigned revid;
+	unsigned long delay;
 	unsigned short keycode[ADP5588_KEYMAPSIZE];
 };
 
@@ -119,9 +119,7 @@ static irqreturn_t adp5588_irq(int irq, void *handle)
 	 * REVID < 4
 	 */
 
-	schedule_delayed_work(&kpad->work,
-			WA_DELAYED_READOUT_REVID(kpad->revid) ?
-			(unsigned long) msecs_to_jiffies(30) : 0);
+	schedule_delayed_work(&kpad->work, kpad->delay);
 
 	return IRQ_HANDLED;
 }
@@ -164,6 +162,7 @@ static int __devinit adp5588_probe(struct i2c_client *client,
 	struct adp5588_kpad *kpad;
 	struct adp5588_kpad_platform_data *pdata = client->dev.platform_data;
 	struct input_dev *input;
+	unsigned int revid;
 	int ret, i;
 	int error;
 
@@ -210,7 +209,9 @@ static int __devinit adp5588_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
-	kpad->revid = (u8) ret & ADP5588_DEVICE_ID_MASK;
+	revid = (u8) ret & ADP5588_DEVICE_ID_MASK;
+	if (WA_DELAYED_READOUT_REVID(revid))
+		kpad->delay = msecs_to_jiffies(30);
 
 	input->name = client->name;
 	input->phys = "adp5588-keys/input0";
@@ -221,7 +222,7 @@ static int __devinit adp5588_probe(struct i2c_client *client,
 	input->id.bustype = BUS_I2C;
 	input->id.vendor = 0x0001;
 	input->id.product = 0x0001;
-	input->id.version = kpad->revid;
+	input->id.version = revid;
 
 	input->keycodesize = sizeof(kpad->keycode[0]);
 	input->keycodemax = pdata->keymapsize;
@@ -247,8 +248,8 @@ static int __devinit adp5588_probe(struct i2c_client *client,
 	}
 
 	error = request_irq(client->irq, adp5588_irq,
-		IRQF_TRIGGER_FALLING | IRQF_DISABLED,
-		client->dev.driver->name, kpad);
+			    IRQF_TRIGGER_FALLING | IRQF_DISABLED,
+			    client->dev.driver->name, kpad);
 	if (error) {
 		dev_err(&client->dev, "irq %d busy?\n", client->irq);
 		goto err_unreg_dev;
@@ -261,9 +262,7 @@ static int __devinit adp5588_probe(struct i2c_client *client,
 	device_init_wakeup(&client->dev, 1);
 	i2c_set_clientdata(client, kpad);
 
-	dev_info(&client->dev, "Rev.%d keypad, irq %d\n",
-		kpad->revid, client->irq);
-
+	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
 	return 0;
 
  err_free_irq:

-- 
Dmitry

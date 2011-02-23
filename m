From: jcbian <jcbian@pixcir.com.cn>
Subject: Re: [PATCH] input: add driver for pixcir i2c touchscreens
Date: Wed, 23 Feb 2011 09:04:28 +0800 (HKT)
Message-ID: <f2894b.b085.12e500bb5f2.Coremail.jcbian@pixcir.com.cn>
References: <20110222034808.GC18299@sirena.org.uk>
 <4D632AAD.8040405@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail37.corpease.net ([61.145.121.42]:22390 "EHLO corpease.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751517Ab1BWBEh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 20:04:37 -0500
In-Reply-To: <20110222034808.GC18299@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

Dear Mark
  Thanks for your feedbaxk!

> On Tue, Feb 22, 2011 at 11:17:01AM +0800, jcbian wrote:
> 
> > +config TOUCHSCREEN_PIXCIR
> > + tristate "PIXCIR touchscreen panel support"
> > + depends on I2C
> > + help
> > + Say Y here if you have a PIXCIR based touchscreen.
> > +
> > + To compile this driver as a module, choose M here: the
> > + module will be called pixcir_i2c_ts.
> 
> It looks like your mail client messes with the indentation of your
> files, it looks like it turned all the tabs into spaces.
> 
Yes,so I resend the patch v2 which send from web.

> > +#define DEBUG 0
> 
> Best just to remove this.
> 
Nice.

> > +static struct workqueue_struct *pixcir_wq;
> 
> If you can have a single global workqueue could you use the system one
> and avoid having to create one at all?
> 
The system one is less efficient then the the creating one in my opioion,is it right?

> > + int posx1, posy1, posx2, posy2;
> > + u_int8_t Rdbuf[10], Wrbuf[1];
> 
> Use u8.  The upper case at the start of teh bariable names is also a bit
> odd for Linux.
> 
Nice.

> > + Wrbuf[0] = 0;
> > + ret = i2c_master_send(tsdata->client, Wrbuf, 1);
> > + if (ret != 1) {
> > + dev_err(&tsdata->client->dev, "Unable to write to i2c touchscreen!\n");
> > + goto out;
> 
> It'd be good to print the error code.
> 
Great.

> > +static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
> > +{
> > + struct pixcir_i2c_ts_data *tsdata = dev_id;
> > + disable_irq_nosync(irq);
> > +
> > + queue_work(pixcir_wq, &tsdata->work.work);
> > +
> > + return IRQ_HANDLED;
> > +}
> 
> Use a threaded IRQ handler - genirq can now implement this pattern for
> you.
> 
I do not use genirq before, what the diffetence? Thanks!

> > +static int pixcir_ts_open(struct input_dev *dev)
> > +{
> > + return 0;
> > +}
> 
> You should have code to start the controller here, and matching shutdown
> code in close().
> 
Yes normally should do like this,but this controller need any command to open,may be take come code
to test the device working? 

> > + #ifdef DEBUG
> > + printk(KERN_EMERG "pixcir_i2c_ts probe!\n");
> > + #endif
> 
> dev_dbg() or just remove this.
> 
Nice.

> > + tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
> > + if (!tsdata) {
> > + dev_err(&client->dev, "Failed to allocate driver data!\n");
> > + error = -ENOMEM;
> > + dev_set_drvdata(&client->dev, NULL);
> 
> Don't need to clear the driver data if you're exiting.
> 
Well,

> > + if (request_irq(tsdata->irq, pixcir_ts_isr,
> > + IRQF_TRIGGER_LOW, client->name, tsdata)) {
> > + dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
> > + input_unregister_device(input);
> > + input = NULL;
> > + }
> 
> Your error handling doesn't aways clean everything up - it's often best
> to use gotos to jump to cleanup code that unwinds everything to make
> sure you don't miss some things.
> 
Nice advice.

> > +
> > + dev_err(&tsdata->client->dev, "insmod successfully!\n");
> 
> No need for logs like this in production code, and the priority is all
> wrong.
> 
I just want to show the correctly insmod.

> > +#ifdef CONFIG_PM
> > +static int pixcir_i2c_ts_suspend(struct i2c_client *client,
> > pm_message_t mesg)
> > +{
> > + struct pixcir_i2c_ts_data *tsdata = dev_get_drvdata(&client->dev);
> > +
> > + if (device_may_wakeup(&client->dev))
> > + enable_irq_wake(tsdata->irq);
> > +
> > + return 0;
> > +}
> 
> Please use dev_pm_ops instead of bus-specific suspend/resume callbacks -
> there is a general move to remove the bus specific ones to allow better
> development of the PM core.
> 
Great idea, I never notice the dev_pm_ops before,thanks!

> > +MODULE_AUTHOR(DRIVER_AUTHOR);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > +MODULE_LICENSE(DRIVER_LICENSE);
> 
> Just put the definitions of these in directly, they're only used in one
> place.
Nice.





From: Olivier Sobrie <olivier.sobrie@gmail.com>
Subject: Re: [PATCH v3] ili210x: Add support for Ilitek ILI210x based
 touchscreens
Date: Wed, 7 Mar 2012 11:11:29 +0100
Message-ID: <20120307101129.GA23355@hposo>
References: <20120307070027.GA29010@hposo>
 <1331103902-23538-1-git-send-email-olivier@sobrie.be>
 <20120307084401.GC20493@core.coreip.homeip.net>
Reply-To: Olivier Sobrie <olivier.sobrie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46528 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab2CGKLh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 05:11:37 -0500
Received: by bkcik5 with SMTP id ik5so5025507bkc.19
        for <linux-input@vger.kernel.org>; Wed, 07 Mar 2012 02:11:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120307084401.GC20493@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olivier Sobrie <olivier@sobrie.be>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>

Hi Dmitry,

On Wed, Mar 07, 2012 at 12:44:01AM -0800, Dmitry Torokhov wrote:
> > +#define MAX_TOUCHES		2
> > +#define POLL_PERIOD		msecs_to_jiffies(1)
> 
> That seems very aggressive...

I'll do test and try to increase it without reducing too much performances.
One of our customers requires very short delays between successive
touches...

> > +	input->id.bustype = BUS_I2C;
> > +	input->dev.parent = dev;
> > +
> > +	input_set_drvdata(input, priv);
> > +
> > +	INIT_DELAYED_WORK(&priv->dwork, ili210x_work);
> > +	priv->get_pendown_state = pdata->get_pendown_state;
> > +	rc = request_irq(client->irq, ili210x_irq, pdata->irq_flags,
> > +			 client->name, priv);
> > +	if (rc) {
> > +		dev_err(dev, "Unable to request touchscreen IRQ, err: %d\n",
> > +			rc);
> > +		goto fail_probe;
> > +	}
> > +
> > +	rc = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
> > +	if (rc) {
> > +		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
> > +			rc);
> > +		goto fail_sysfs;
> > +	}
> > +
> > +	rc = input_register_device(input);
> > +	if (rc) {
> > +		dev_err(dev, "Cannot regiser input device, err: %d\n", rc);
> > +		goto fail_input;
> > +	}
> > +
> > +	priv->client = client;
> > +	priv->input = input;
> 
> This is too late. BY this time IRQ might already be raised and work that
> dereferences priv->input migt already be executing.

Argh.
Ok I'll fix this.

> 
> > +
> > +	device_init_wakeup(&client->dev, 1);
> > +
> > +	dev_info(dev,
> > +		 "ILI210x initialized (IRQ: %d), firmware version %d.%d.%d",
> > +		 client->irq, firmware.id, firmware.major, firmware.minor);
> 
> Do we need to be this noisy?

Need? certainly not...
Ok I'll remove the trace...

> 
> > +
> > +	return 0;
> > +
> > +fail_input:
> > +	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
> > +fail_sysfs:
> > +	free_irq(client->irq, priv);
> > +fail_probe:
> > +	input_free_device(input);
> > +fail:
> > +	kfree(priv);
> > +	return rc;
> > +}
> > +
> > +static int __devexit ili210x_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct ili210x *priv = dev_get_drvdata(&client->dev);
> > +	struct device *dev = &priv->client->dev;
> > +
> > +	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
> > +	cancel_delayed_work_sync(&priv->dwork);
> > +	free_irq(priv->client->irq, priv);
> 
> Wrong order. You want to free IRQ first and then cancel residual work.
> If you try to cancel first and then free IRQ ISR might get fired and new
> work might get scheduled.

Ok. Thanks.

> 
> > +	input_unregister_device(priv->input);
> > +	kfree(priv);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int ili210x_i2c_suspend(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +
> > +	if (device_may_wakeup(&client->dev))
> > +		enable_irq_wake(client->irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ili210x_i2c_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +
> > +	if (device_may_wakeup(&client->dev))
> > +		disable_irq_wake(client->irq);
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(ili210x_i2c_pm, ili210x_i2c_suspend,
> > +			 ili210x_i2c_resume);
> > +
> > +static const struct i2c_device_id ili210x_i2c_id[] = {
> > +	{ "ili210x", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ili210x_i2c_id);
> > +
> > +static struct i2c_driver ili210x_ts_driver = {
> > +	.driver = {
> > +		.name = "ili210x_i2c",
> > +		.owner = THIS_MODULE,
> > +		.pm = &ili210x_i2c_pm,
> > +	},
> > +	.id_table = ili210x_i2c_id,
> > +	.probe = ili210x_i2c_probe,
> > +	.remove = ili210x_i2c_remove,
> 
> __devexit_p()

OK. Thanks

> > +static int __init ili210x_ts_init(void)
> > +{
> > +	return i2c_add_driver(&ili210x_ts_driver);
> > +}
> > +module_init(ili210x_ts_init);
> > +
> > +static void __exit ili210x_ts_exit(void)
> > +{
> > +	i2c_del_driver(&ili210x_ts_driver);
> > +}
> > +module_exit(ili210x_ts_exit);
> 
> Instead of boilerplate above simply use:
> 
> module_i2c_driver(ili210x_ts_driver);

No problem for me to use the macro.
The reason I didn't do that before is that it is not yet available in the
input/next tree.

> 
> > +
> > +MODULE_AUTHOR("Olivier Sobrie <olivier@sobrie.be>");
> > +MODULE_DESCRIPTION("ILI210X I2C Touchscreen Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/input/ili210x.h b/include/linux/input/ili210x.h
> > new file mode 100644
> > index 0000000..710b3dd2
> > --- /dev/null
> > +++ b/include/linux/input/ili210x.h
> > @@ -0,0 +1,9 @@
> > +#ifndef _ILI210X_H
> > +#define _ILI210X_H
> > +
> > +struct ili210x_platform_data {
> > +	unsigned long irq_flags;
> > +	int (*get_pendown_state)(void);
> 
> You sure you do not want to pass device or something else identifying
> the device you are working with to get_pendown_state()? Also it should
> probably return bool.

Personnaly I don't need to give anything else to the function.
In my onfig, the function only read the value of a gpio.

I will convert the return value to bool.
The same should also maybe be done in ads7846 and tsc2007 drivers?

Thanks,

-- 
Olivier Sobrie

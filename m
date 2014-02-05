From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 04/15] Input: synaptics-rmi4 - remove sensor name from
 platform data
Date: Tue, 4 Feb 2014 18:30:00 -0800
Message-ID: <20140205022959.GD1706@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <52F172ED.1040902@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:13361 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbaBEC2R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 21:28:17 -0500
Content-Disposition: inline
In-Reply-To: <52F172ED.1040902@synaptics.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, linus.walleij@linaro.org

On Wed, Feb 05, 2014 at 12:08:29AM +0100, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> > The driver/device already has a name, no need for another one.
> 
> This is extremely useful in initial system bring up on systems with more 
> than one RMI4 sensor.  We'd prefer to keep this.
> 

While I understand that this may be useful, IMO it is the wrong way to do
things.  Instead, one should name the devices something useful rather
than "sensor%02d".  Then all the dev_(err|dbg) printouts would already
have the name in the log.

> >
> > Cc: Christopher Heiny <cheiny@synaptics.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> > ---
> >   drivers/input/rmi4/rmi_bus.c    | 4 ++--
> >   drivers/input/rmi4/rmi_driver.c | 7 ++-----
> >   drivers/input/rmi4/rmi_f11.c    | 3 +--
> >   drivers/input/rmi4/rmi_i2c.c    | 3 +--
> >   include/linux/rmi.h             | 4 ----
> >   5 files changed, 6 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> > index cd7bfbd..fd14acb 100644
> > --- a/drivers/input/rmi4/rmi_bus.c
> > +++ b/drivers/input/rmi4/rmi_bus.c
> > @@ -116,8 +116,8 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
> >   		return error;
> >   	}
> >
> > -	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
> > -		pdata->sensor_name, dev_name(&rmi_dev->dev));
> > +	dev_dbg(xport->dev, "%s: Registered %s\n", __func__,
> > +		dev_name(&rmi_dev->dev));
> >
> >   	return 0;
> >   }
> > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> > index 4965589..5fb582c 100644
> > --- a/drivers/input/rmi4/rmi_driver.c
> > +++ b/drivers/input/rmi4/rmi_driver.c
> > @@ -531,12 +531,10 @@ static int create_function(struct rmi_device *rmi_dev,
> >   {
> >   	struct device *dev = &rmi_dev->dev;
> >   	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> > -	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
> >   	struct rmi_function *fn;
> >   	int error;
> >
> > -	dev_dbg(dev, "Initializing F%02X for %s.\n",
> > -		pdt->function_number, pdata->sensor_name);
> > +	dev_dbg(dev, "Initializing F%02X\n", pdt->function_number);
> >
> >   	fn = kzalloc(sizeof(struct rmi_function), GFP_KERNEL);
> >   	if (!fn) {
> > @@ -822,8 +820,7 @@ static int rmi_driver_probe(struct device *dev)
> >
> >   	retval = rmi_scan_pdt(rmi_dev);
> >   	if (retval) {
> > -		dev_err(dev, "PDT scan for %s failed with code %d.\n",
> > -			pdata->sensor_name, retval);
> > +		dev_err(dev, "PDT scan failed with code %d.\n", retval);
> >   		goto err_free_data;
> >   	}
> >
> > diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> > index 4e0a296..553afd8 100644
> > --- a/drivers/input/rmi4/rmi_f11.c
> > +++ b/drivers/input/rmi4/rmi_f11.c
> > @@ -1182,8 +1182,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
> >   	struct f11_2d_sensor *sensor;
> >   	u8 buf;
> >
> > -	dev_dbg(&fn->dev, "Initializing F11 values for %s.\n",
> > -		 pdata->sensor_name);
> > +	dev_dbg(&fn->dev, "Initializing F11 values.\n");
> >
> >   	/*
> >   	** init instance data, fill in values and create any sysfs files
> > diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> > index 24d8a04..910f05c 100644
> > --- a/drivers/input/rmi4/rmi_i2c.c
> > +++ b/drivers/input/rmi4/rmi_i2c.c
> > @@ -196,8 +196,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
> >   		return -EINVAL;
> >   	}
> >
> > -	dev_dbg(&client->dev, "Probing %s at %#02x (GPIO %d).\n",
> > -		pdata->sensor_name ? pdata->sensor_name : "-no name-",
> > +	dev_dbg(&client->dev, "Probing %#02x (GPIO %d).\n",
> >   		client->addr, pdata->attn_gpio);
> >
> >   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> > index 735e978..65b59b5 100644
> > --- a/include/linux/rmi.h
> > +++ b/include/linux/rmi.h
> > @@ -194,8 +194,6 @@ struct rmi_device_platform_data_spi {
> >   /**
> >    * struct rmi_device_platform_data - system specific configuration info.
> >    *
> > - * @sensor_name - this is used for various diagnostic messages.
> > - *
> >    * @firmware_name - if specified will override default firmware name,
> >    * for reflashing.
> >    *
> > @@ -247,8 +245,6 @@ struct rmi_device_platform_data_spi {
> >    * functions.
> >    */
> >   struct rmi_device_platform_data {
> > -	char *sensor_name;	/* Used for diagnostics. */
> > -
> >   	int attn_gpio;
> >   	enum rmi_attn_polarity attn_polarity;
> >   	bool level_triggered;
> >

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023 and SMB380
 accelerometers
Date: Wed, 26 Jan 2011 11:42:47 +0000
Message-ID: <20110126114247.71a7fd86@lxorguk.ukuu.org.uk>
References: <20110125160418.30747.22469.stgit@bob.linux.org.uk>
	<4D40016A.50704@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55697 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752791Ab1AZLmx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Jan 2011 06:42:53 -0500
In-Reply-To: <4D40016A.50704@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-input@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>, Hemanth V <hemanthv@ti.com>

> * Lots of discussion on sysfs attributes needed, documentation will obviously
> make this easier!  I think there are some magic numbers in here still in
> no particular units? Difficult to tell without the datasheet.

I'll double check on that. I don't believe the data sheet is available
publically.

> > We expose the data from this device to uusers through sysfs interface in
> > the same manner as the lis drivers 
> 
> This is a somewhat misleading comment. Unless a lot of new sysfs changes to

I meant the XYZ are exposed in the same format but do need some scaling
info yes.

> Whilst several discussions of sysfs interfaces for these devices have bounced
> around, no particularly firm decisions have been reached and perhaps we need
> futher discussion.  We do have a fairly extensive set of equivalents in IIO
> but are still open to other suggestions. (please see our docs in
> staging/iio/Documentation) They are reasonaly comprehensive, though a few
> things have snuck into the drivers without proper documentation in place.

IIO is something that unfortunately isn't within our timescales -
especially with no certainty it'll ever go upstream. That's a hint btw -
I think IIO needs throwing at Linus ;)

Once IIO was upstream then the rest would follow (and we've got a few
other driver bits in misc and in internal trees that would then be able
to follow nicely)


> > +struct bma023_sensor {
> > +	struct i2c_client *client;
> > +	struct device *dev;
> > +	struct input_dev *idev;
> > +	struct mutex lock;
> > +	struct bma023_data data;
> > +	int auto_delay;
> I for one have no idea what auto_delay and soft_power might be...
> Perhaps some documentation?

Power management delay and our soft power state - will comment
accordingly.


> > +static int bma023_read_reg(struct i2c_client *client, u8 reg)
> > +{
> > +	int ret = i2c_smbus_read_byte_data(client, reg);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "%s: reg 0x%x, err %d\n",
> > +			__func__, reg, ret);
> 
> Do we need this wrapper? It does pretty print any errors, but do we
> care assuming they are correctly passed on?

At this point I'd certainly like to keep it but long term it may well not
be needed.


> I can't help feeling that much of the following could be combined
> into 2 functions with the right macro foo and container structures,
> much the way it is done in hwmon an others.

Some of it was originally macro foo, including some truely 'elegant' use
of the pre-processor. When I expanded it by hand it was several times
larger than the code now in its place. gcc is pretty good at its job so
letting gcc work out what it wants inlined seems best.

> > + *	bma023_set_hg_dur	-	set high-g duration
> > + *	@client: i2c client for the sensor
> > + *	@dur: duration value, 0-255
> Again, units are?  We really need this stuff to be clear.

> > + *	bma023_set_hg_thres	-	set high-g threshold
> > + *	@client: i2c client for the sensor
> > + *	@thres: threshold value, 0-255
> Units are?  

> > +	mutex_lock(&sensor->lock);
> > +	bma023_read_xyz(sensor->client, &sensor->data);
> > +	mutex_unlock(&sensor->lock);
> > +
> > +	pm_runtime_put(dev);
> > +
> These look to be raw adc values. If you want to do that, please provide
> in sysfs the numbers needed to convert them to SI units.


> > +static struct attribute *bma023_attributes[] = {
> > +	&dev_attr_accel_data.attr,
> These are raw values I think?  Again, we allow this in IIO, but insist
> on conversion factors to m/s^2 also being provided in the sysfs interface
> so userspace knows what it is getting.

This isn't an IIO driver. As and when IIO isn't in staging then we can
worry about this a bit more IMHO.

> > +	&dev_attr_power_mode.attr,
> Perhaps rename this low_power_mode and invert the value as then
> it won't be a pair of magic numbers.

I'll take a look - ultimately I'd like to kill it off and just rely on
runtime PM but not everyone builds runtime PM systems yet.

> > +	&dev_attr_new_data_int.attr,
> (is this enabling and disabling the interrupt? Surely that should be handled
> by the input code and doesn't really want to be exposed?

It depends what you are doing with the device what events you want to be
flagged. In almost all cases the platform would know and provide the
right defaults.

> For reference, the IIO equivalents may seem long winded, but they
> are clear, consistent and generalizable. I'm guessing a bit on
> what the bosch chip is doing based on other parts.

Again when/if IIO is upstream it will make sense to follow IIO.


> > +		ret = request_threaded_irq(client->irq, NULL,
> > +				bma023_interrupt_thread, IRQF_TRIGGER_RISING,
> > +					"bma023_int", sensor);
> Is there any reason to have the _int postfix?  It is clearly an interrupt and
> I don't think the device has any others.

Good point - killed

> > +	pm_runtime_enable(&client->dev);
> 
> Why store auto_delay, it is only used here...

Already fixed

> > +static int bma023_runtime_suspend(struct device *dev)
> > +{
> > +	struct bma023_sensor *sensor = dev_get_drvdata(dev);
> > +	bma023_set_power_mode(sensor->client, BMA023_SUSPEND);
> On these could we usefully pass on the return value from
> bma023_set_power_mode?

In the suspend case it is pretty meaningless - on the resume case I will
do so.
